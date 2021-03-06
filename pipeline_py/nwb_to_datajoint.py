import os
import pynwb
import pathlib
import numpy as np
from pynwb import NWBHDF5IO
from tqdm import tqdm
import sys
import datajoint as dj
import re
import json
import uuid
import traceback
import time
from . import cf, lab, experiment, ephys, misc, db_prefix
from .insert_lookup import insert_lookup
import ndx_events


schema = dj.schema(db_prefix + 'ingestion')


@schema
class NWBFile(dj.Manual):
    definition = """
    nwb_fullpath: varchar(256)
    """


@schema
class NWBtoDataJointIngestion(dj.Imported):
    definition = """
    -> NWBFile
    ---
    status: enum('complete', 'error')
    error_stack='': varchar(5000)
    """

    class Session(dj.Part):
        definition = """
        -> master
        ---
        -> experiment.Session
        """

    def make(self, key):
        nwb_filepath = pathlib.Path(key['nwb_fullpath'])
        try:
            session_key = ingest_to_pipeline(nwb_filepath)
            self.insert1({**key, 'status': 'complete'})
            self.Session.insert1({**key, **session_key})
        except Exception:
            self.insert1({**key,
                          'status': 'error',
                          'error_stack': traceback.format_exc()})


def ingest_to_pipeline(nwb_filepath):
    photostim_dict = {p['photo_stim']: p for p in experiment.Photostim.fetch('KEY')}

    print('-----------------------------------------------------------------------')
    print(f'Ingesting from: {nwb_filepath.name} ...')
    io = NWBHDF5IO(pathlib.Path(nwb_filepath).as_posix(), mode='r', load_namespaces=True)
    nwbfile = io.read()
    subject_key = {'subject_id': nwbfile.subject.subject_id}
    # =============================== SUBJECT ===========================
    if subject_key not in lab.Subject.proj():
        # lab.Subject
        subject = {**subject_key,
                   'cage_number': int(re.search('cage_number: (\d+)', nwbfile.subject.description).groups()[0]),
                   'username': nwbfile.experimenter[0],
                   'date_of_birth': nwbfile.subject.date_of_birth,
                   'sex': nwbfile.subject.sex,
                   'animal_source': re.search('source: (\w+);', nwbfile.subject.description).groups()[0]}
        # lab.Subject.GeneModification
        gene_modifications = nwbfile.subject.genotype.split(' x ')

        lab.Subject.insert1(subject)
        lab.Subject.GeneModification.insert([{**subject_key, 'gene_modification': gene_mod}
                                             for gene_mod in gene_modifications if gene_mod])

    # =============================== SESSION ===========================
    session_key = {**subject_key, 'session': int(nwbfile.identifier.split('_')[-1])}
    session_details = json.loads(nwbfile.session_description)
    print(f'\tSession: {session_key}')
    if session_key not in experiment.Session.proj():
        print(f'\tSession...')
        experiment.Session.insert1({**session_key, 'session_date': nwbfile.session_start_time.date(),
                                    'username': nwbfile.experimenter[0], 'rig': 'ephys'})
        experiment.SessionComment.insert1({**session_key, 'session_comment': nwbfile.data_collection})
        experiment.SessionTask.insert1(session_details, ignore_extra_fields=True)
        experiment.SessionTraining.insert1(session_details, ignore_extra_fields=True)

    units_df = nwbfile.units.to_dataframe()
    trials_df = nwbfile.trials.to_dataframe()

    # =============================== BEHAVIOR TRIALS ===============================
    if not (experiment.BehaviorTrial & session_key):
        print('\tBehavior & trials...')
        session_trial_list, behavior_trial_list, trial_name_list, photostim_trial_list = [], [], [], []
        photostim_event_list, behavior_event_list, action_event_list = [], [], []
        trial_go_times = {}  # times of go-cue for each trial (relative to trial's start)

        for trial_id, trial in trials_df.iterrows():
            dj.conn().ping()
            # trials
            trial_key = {**session_key, 'trial': trial_id}
            session_trial_list.append({**trial_key, 'start_time': trial.start_time,
                                       'trial_uid': len(experiment.SessionTrial()) + len(session_trial_list)})
            behavior_trial_list.append({**trial_key, 'task': trial.task,
                                        'task_protocol': trial.task_protocol,
                                        'trial_instruction': trial.trial_instruction,
                                        'early_lick': trial.early_lick,
                                        'outcome': trial.outcome})
            trial_name_list.append({**trial_key, 'task': trial.task, 'trial_type_name': trial.trial_type_name})
            if trial.photostim_duration != 'N/A' and trial.photostim_power != 'N/A' and trial.photostim_duration != 'N/A':
                photostim_trial_list.append({**trial_key})

            # trials' events
            event_ind = nwbfile.acquisition['LabeledEvents'].data[()]
            event_types = list(nwbfile.acquisition['LabeledEvents'].labels)
            event_names = set([re.sub('_start_times|_stop_times', '', e_ts) for e_ts in event_types if 'lick' not in e_ts])
            for event_type in event_names:
                event_start_idx = event_types.index(event_type + '_start_times')
                event_stop_idx = event_types.index(event_type + '_stop_times')

                event_times = nwbfile.acquisition['LabeledEvents'].timestamps[event_ind == event_start_idx]
                valid_trial_ind = np.where(np.logical_and(event_times >= trial.start_time,
                                                          event_times < trial.stop_time))[0]

                durations = nwbfile.acquisition['LabeledEvents'].timestamps[event_ind == event_stop_idx][valid_trial_ind] - event_times[valid_trial_ind]

                behavior_event_list.extend([{**trial_key, 'trial_event_type': event_type,
                                             'trial_event_time': start_time - trial.start_time, 'duration': dur}
                                            for start_time, dur in zip(event_times[valid_trial_ind], durations)])
                if event_type == 'go':
                    trial_go_times[trial_id] = event_times[valid_trial_ind][0] - trial.start_time

            # action events
            event_names = set([e_ts for e_ts in event_types if 'lick' in e_ts])
            for event_type in event_names:
                event_start_idx = event_types.index(event_type)
                event_times = nwbfile.acquisition['LabeledEvents'].timestamps[event_ind == event_start_idx]
                valid_trial_ind = np.where(np.logical_and(event_times >= trial.start_time,
                                                          event_times < trial.stop_time))[0]
                action_event_list.extend([{**trial_key, 'action_event_type': event_type,
                                           'action_event_time': start_time - trial.start_time}
                                          for start_time in event_times[valid_trial_ind]])

            # photostim events
            event_times = nwbfile.acquisition['PhotostimEvents']['photostim_start_times'].timestamps[()]
            valid_trial_ind = np.where(np.logical_and(event_times >= trial.start_time,
                                                      event_times < trial.stop_time))[0]
            powers = nwbfile.acquisition['PhotostimEvents']['photostim_start_times'].data[valid_trial_ind]
            stim_ind = nwbfile.acquisition['PhotostimEvents']['photostim_start_times'].control[valid_trial_ind]
            photostim_event_list.extend([{**trial_key, 'photostim_event_time': start_time - trial.start_time,
                                          'power': power, **photostim_dict[stim_id]}
                                         for start_time, power, stim_id in zip(event_times[valid_trial_ind], powers, stim_ind)])

        experiment.SessionTrial.insert(session_trial_list, allow_direct_insert=True)
        experiment.BehaviorTrial.insert(behavior_trial_list, allow_direct_insert=True)
        experiment.TrialName.insert(trial_name_list, allow_direct_insert=True)
        experiment.PhotostimTrial.insert(photostim_trial_list, allow_direct_insert=True)
        experiment.BehaviorTrial.Event.insert(behavior_event_list, allow_direct_insert=True)
        experiment.PhotostimTrial.Event.insert(photostim_event_list, allow_direct_insert=True)
        experiment.ActionEvent.insert(action_event_list, allow_direct_insert=True)

    # ======================== EXTRACELLULAR & CLUSTERING ===========================
    if not (ephys.Unit.Spikes & session_key):
        print('\tClustering & Units...')
        # Electrode Group
        electrode_group_keys = {}
        for egroup_no, egroup in nwbfile.electrode_groups.items():
            probe_type, probe_part_no = egroup.device.name.split('_')
            egroup_key = {**session_key, 'electrode_group': int(egroup_no)}
            electrode_group_keys[int(egroup_no)] = egroup_key
            insert_location = {k: None if v == 'None' else v
                               for k, v in json.loads(egroup.location).items()}

            ephys.Probe.insert1({'probe_part_no': probe_part_no,
                                 'probe_type': probe_type, 'probe_comment': ''},
                                skip_duplicates=True)
            ephys.ElectrodeGroup.insert1({**egroup_key,
                                          'probe_part_no': probe_part_no})
            ephys.ElectrodeGroup.Position.insert1({**egroup_key, **insert_location,
                                                   'cf_annotation_type': 'manipulator'},
                                                  ignore_extra_fields=True)
        # Unit
        unit_list, unit_celltype_list, unit_position_list = [], [], []
        unit_spikes_list, unit_wf_list, trialspikes_list = [], [], []
        for unit_id, unit in units_df.iterrows():
            dj.conn().ping()
            unit_key = {**electrode_group_keys[int(unit.electrode_group.name)], 'unit': unit_id}
            unit_list.append({**unit_key, 'unit_uid': len(ephys.Unit()) + len(unit_list), 'unit_quality': unit.quality,
                              'unit_channel': unit.electrodes.index[0]})
            unit_celltype_list.append({**unit_key, 'cell_type': unit.cell_type})
            unit_spikes_list.append({**unit_key, 'spike_times': unit.spike_times})
            unit_position_list.append({**unit_key, 'cf_annotation_type': 'manipulator',
                                       'hemisphere': insert_location['hemisphere'],
                                       'brain_area': insert_location['brain_area'],
                                       'skull_reference': insert_location['skull_reference'],
                                       'unit_ml_location': unit.unit_ml_location,
                                       'unit_ap_location': unit.unit_ap_location,
                                       'unit_dv_location': unit.unit_dv_location})
            unit_wf_list.append({**unit_key, 'waveform': unit.waveform_mean.flatten(),
                                 'spk_width_ms': unit.spk_width_ms,
                                 'sampling_fq': unit.sampling_rate,
                                 'waveform_amplitude': unit.waveform_amplitude})
            # trial-spikes
            for trial_id, start_time, stop_time in zip(trials_df.index, trials_df.start_time,
                                                       trials_df.stop_time):
                spks = unit.spike_times[np.logical_and(unit.spike_times >= start_time, unit.spike_times < stop_time)]
                if len(spks):
                    trialspikes_list.append({**unit_key, 'trial': trial_id, 'spike_times': spks - start_time})

        ephys.Unit.insert(unit_list, allow_direct_insert=True)
        ephys.UnitCellType.insert(unit_celltype_list, allow_direct_insert=True)
        ephys.Unit.Position.insert(unit_position_list, allow_direct_insert=True)
        ephys.Unit.Spikes.insert(unit_spikes_list, allow_direct_insert=True)
        ephys.Unit.Waveform.insert(unit_wf_list, allow_direct_insert=True)
        ephys.TrialSpikes.insert(trialspikes_list, allow_direct_insert=True)

    io.close()
    print(f'\tIngestion for {session_key} completed!')
    return session_key


def main():
    insert_lookup()

    nwb_directory = pathlib.Path(os.environ['NWB_DIRECTORY'])
    nwbfiles = [{'nwb_fullpath': nwb_fp.as_posix()} for nwb_fp in nwb_directory.rglob('*.nwb')]
    NWBFile.insert(nwbfiles, skip_duplicates=True)

    while True:
        # do ingestion
        NWBtoDataJointIngestion.populate()
        # clean up
        orphaned_sessions = (NWBtoDataJointIngestion - NWBtoDataJointIngestion.Session
                             & 'status = "complete"').fetch('KEY')
        if orphaned_sessions:
            with dj.config(safemode=False):
                (NWBtoDataJointIngestion & orphaned_sessions).delete()

        time.sleep(120)  # sleep for 2 minutes


# ============================== INGEST ALL NWB FILES ========================================


if __name__ == '__main__':
    if len(sys.argv) > 1:
        os.environ['NWB_DIRECTORY'] = sys.argv[1]

    main()
