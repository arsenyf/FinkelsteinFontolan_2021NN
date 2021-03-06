"""This module was auto-generated by datajoint from an existing schema"""


import datajoint as dj

schema = dj.Schema('arseny_s1alm_experiment')


vmod0 = dj.VirtualModule('vmod0', 'map_lab')


@schema
class TrialNoteType(dj.Lookup):
    definition = """
    trial_note_type      : varchar(12)                  
    """


@schema
class TrialEventType(dj.Lookup):
    definition = """
    trial_event_type     : varchar(24)                  
    """


@schema
class Outcome(dj.Lookup):
    definition = """
    outcome              : varchar(32)                  
    """


@schema
class EpochName(dj.Lookup):
    definition = """
    trial_epoch_name     : varchar(400)                 
    ---
    trial_epoch_name_name_description=null : varchar(4000)                
    """


@schema
class PhotostimDevice(dj.Lookup):
    definition = """
    photostim_device     : varchar(20)                  
    ---
    excitation_wavelength : decimal(5,1)                 # (nm)
    photostim_device_description : varchar(255)                 
    """


@schema
class Photostim(dj.Imported):
    definition = """
    -> PhotostimDevice
    photo_stim           : smallint                     
    ---
    duration             : decimal(8,4)                 # (s)
    waveform             : longblob                     # normalized to maximal power. The value of the maximal power is specified for each PhotostimTrialEvent individually
    """


    class Profile(dj.Part):
        definition = """
        -> Photostim
        ---
        intensity_timecourse : longblob                     # (mW/mm^2)
        """


@schema
class PhotostimLocation(dj.Manual):
    definition = """
    -> Photostim
    ---
    -> vmod0.Hemisphere
    -> vmod0.BrainArea
    -> vmod0.SkullReference
    photostim_ml_location=null : decimal(8,3)                 # um from ref ; right is positive;
    photostim_ap_location=null : decimal(8,3)                 # um from ref; anterior is positive;
    photostim_dv_location=null : decimal(8,3)                 # um from dura; ventral is positive;
    photostim_ml_angle=null : decimal(8,3)                 # Angle between the photostim path and the Medio-Lateral axis. A tilt towards the right hemishpere is positive.
    photostim_ap_angle=null : decimal(8,3)                 # Angle between the photostim path and the Anterior-Posterior axis. An anterior tilt is positive.
    """


@schema
class Session(dj.Manual):  #DONE
    definition = """
    -> vmod0.Subject
    session              : smallint                     # session number
    ---
    session_date         : date                         
    -> vmod0.Person
    -> vmod0.Rig
    """


@schema
class SessionComment(dj.Manual):  #DONE
    definition = """
    -> Session
    session_comment      : varchar(767)                 
    """


@schema
class SessionTrial(dj.Imported):
    definition = """
    -> Session
    trial                : smallint                     
    ---
    trial_uid            : int                          # unique across sessions/animals
    start_time           : decimal(8,4)                 # (s) % relative to session beginning
    """


@schema
class TrialNote(dj.Imported):
    definition = """
    -> SessionTrial
    -> TrialNoteType
    ---
    trial_note           : varchar(255)                 
    """


@schema
class PhotostimTrial(dj.Imported):
    definition = """
    -> SessionTrial
    """


    class Event(dj.Part):
        definition = """
        -> PhotostimTrial
        -> Photostim
        photostim_event_time : decimal(8,3)                 # (s) from trial start
        power                : decimal(8,3)                 # Maximal power (mW)
        """


@schema
class PassivePhotostimTrial(dj.Computed):
    definition = """
    # Non-behavioral trials with photostimulation
    -> PhotostimTrial
    """


@schema
class TrialID(dj.Computed):
    definition = """
    -> Session
    trial                : smallint                     
    ---
    trial_uid            : int                          # unique across sessions/animals
    """


@schema
class SessionID(dj.Computed):
    definition = """
    -> Session
    ---
    session_uid          : int                          # unique across sessions/animals
    """


@schema
class ActionEventType(dj.Lookup):
    definition = """
    action_event_type    : varchar(32)                  
    ---
    action_event_description : varchar(1000)                
    """


@schema
class TrackingDevice(dj.Lookup):
    definition = """
    -> vmod0.Rig
    tracking_device_type : varchar(20)                  # e.g. camera, microphone
    tracking_device_id   : int                          # number of the device, e.g. in case there are multiple cameras
    ---
    tracking_device_description : varchar(1000)                # e.g. side-view camera
    tracking_device_model : varchar(1000)                # make and model of the tracking device
    """


@schema
class VideoFiducialsType(dj.Imported):
    definition = """
    -> TrackingDevice
    video_fiducial_name  : varchar(200)                 
    ---
    video_fiducial_description : varchar(1000)                
    """


@schema
class TrackingTrial(dj.Imported):
    definition = """
    -> SessionTrial
    -> TrackingDevice
    ---
    tracking_datafile_num=null : int                          # tracking data file number associated with this trial
    tracking_datafile_path=null : varchar(1000)                
    tracking_start_time=null : decimal(8,4)                 # (s) from trial start (which should coincide with the beginning of the ephys recordings)
    tracking_duration=null : decimal(8,4)                 # (s)
    tracking_sampling_rate=null : decimal(8,4)                 # Hz
    """


@schema
class VideoFiducialsTrial(dj.Imported):
    definition = """
    -> TrackingTrial
    -> VideoFiducialsType
    ---
    fiducial_x_position  : longblob                     # fiducial coordinate along the X axis of the video image
    fiducial_y_position  : longblob                     # fiducial coordinate along the Y axis of the video image
    fiducial_p           : longblob                     # fiducial probability
    fiducial_time        : longblob                     # fiducial time, relative to Go cue
    fiduical_x_position_median=null : double                       
    fiduical_y_position_median=null : double                       
    """


@schema
class Task(dj.Lookup):
    definition = """
    # Type of tasks
    task                 : varchar(12)                  # task type
    ---
    task_description     : varchar(4000)                
    """


@schema
class TrialNameType(dj.Imported):
    definition = """
    -> Task
    trial_type_name      : varchar(200)                 # trial-type name
    ---
    trial_type_name_description=null : varchar(4000)                
    """


@schema
class TrialName(dj.Imported):
    definition = """
    -> SessionTrial
    -> TrialNameType
    """


@schema
class TaskProtocol(dj.Lookup):
    definition = """
    # SessionType
    -> Task
    task_protocol        : tinyint                      # task ptotcol
    ---
    task_protocol_description : varchar(4000)                
    """


@schema
class SessionTask(dj.Manual):
    definition = """
    -> Session
    -> TaskProtocol
    """


@schema
class TrialInstruction(dj.Lookup):
    definition = """
    # Instruction to mouse
    trial_instruction    : varchar(8)                   
    """


@schema
class TrainingType(dj.Lookup):
    definition = """
    # Mouse training
    training_type        : varchar(100)                 # mouse training
    ---
    training_type_description : varchar(2000)                
    """


@schema
class SessionTraining(dj.Manual):
    definition = """
    -> Session
    -> TrainingType
    """


@schema
class EarlyLick(dj.Lookup):
    definition = """
    early_lick           : varchar(32)                  
    ---
    early_lick_description : varchar(4000)                
    """


@schema
class BehaviorTrial(dj.Imported):
    definition = """
    -> SessionTrial
    ---
    -> TaskProtocol
    -> TrialInstruction
    -> EarlyLick
    -> Outcome
    """


    class Event(dj.Part):
        definition = """
        -> BehaviorTrial
        -> TrialEventType
        trial_event_time     : decimal(8,4)                 # (s) from trial start
        ---
        duration             : decimal(8,4)                 # (s)
        """


@schema
class ActionEvent(dj.Imported):
    definition = """
    -> BehaviorTrial
    -> ActionEventType
    action_event_time    : decimal(8,4)                 # (s) from trial start
    """