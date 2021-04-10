%{
# 
trial_event_type            : varchar(24)                   # 
%}


classdef TrialEventType < dj.Lookup
     properties
        contents = {
            'delay'
            'go'
            'sample'
            'sample-start chirp'
            'sample-end chirp'
            }
    end
end