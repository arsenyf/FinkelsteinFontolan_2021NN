function Sup_REV1_LickRight_DecodedError()



session_uid = fetchn(EXP.SessionID & (ANL.SVMdecoderFindErrorTrialsRightTrialsRevision & 'trial_type_name="r"') & (ANL.SVMdecoderFindErrorTrialsRightTrialsRevision & 'trial_type_name="r_-1.6Full"') & (ANL.SVMdecoderFindErrorTrialsRightTrialsRevision & 'trial_type_name="r_-0.8Full"'), 'session_uid');

session_decoded_error=[];
trial_type_name = {'r','r_-1.6Full','r_-0.8Full'};
for i = 1:1:numel(session_uid)
    key=[];
    key.session_uid = session_uid(i)
    
    rel = ANL.SVMdecoderFindErrorTrialsRightTrialsRevision*EXP.SessionID  & key;
    
    for j=1:1:numel(trial_type_name)
        key.trial_type_name = trial_type_name{j};
        key.trial_decoded_as_error = 0;
        rel_correct = rel & key;
        
        key.trial_decoded_as_error = 1;
        rel_error = rel & key;
        
        session_decoded_error(i,j)= rel_error.count/(rel_error.count + rel_correct.count);
        
    end
    
end


decoding_accuracy=[];
for i = 1:1:numel(session_uid)
    key=[];
    key.session_uid = session_uid(i)

    key=[];
    key.session_uid = session_uid(i)
    key.trial_type_name = 'r';
    
    rel = ANL.SVMdecoderFindErrorTrialsRightTrialsRevision*EXP.SessionID*EXP.BehaviorTrial  & key;
    
    true_negative = rel & 'outcome="hit"' & 'trial_decoded_as_error=0';
    true_positive = rel & 'outcome="miss"' & 'trial_decoded_as_error=1';

   accuracy(i) = (true_negative.count + true_positive.count)/rel.count;
    
end

mean(session_decoded_error)
mean(accuracy)