%{
# Sorted unit
-> EPHYS.Unit
---
unit_total_spikes                           : int       # total number of spikes emitted by the unit during the session
mean_fr                                     : double    # mean firing rate (Hz) of the unit for the entire trial duration

%}

classdef UnitFiringRate < dj.Computed
    properties
        keySource=EXP.Session & EPHYS.Unit;
    end
    methods(Access=protected)
        function makeTuples(self, key)
            tic
            %get params
            trial_start = -4.2;
            trial_end = 3;
            U = struct2table(fetch(EPHYS.Unit & key,'*'));
            
            % fetch and compute total number of spikes and mean FR
            rel1 = (ANL.TrialSpikesGoAligned) & key; %taking only trials that a had a go cue (i.e. some early lick trials won't be included)
            S=struct2table(fetch(rel1,'*'));
            units = unique([S.unit]);
            
            for iu=1:1:numel(units)
                k(iu).subject_id=key.subject_id;
                k(iu).session=key.session;
                k(iu).electrode_group=U.electrode_group(U.unit==units(iu));
                k(iu).unit=units(iu);
                
                u_idx_S= (S.unit==units(iu));
                num_trials_in_unit = sum(u_idx_S);
                spike_times_go = cell2mat(S.spike_times_go(u_idx_S));
                k(iu).unit_total_spikes = numel(spike_times_go);
                k(iu).mean_fr = sum(spike_times_go>=trial_start & trial_end>spike_times_go)/ ((trial_end-trial_start)*num_trials_in_unit);
                
                
            end
            insert(self,k);
            toc
        end
    end
end

