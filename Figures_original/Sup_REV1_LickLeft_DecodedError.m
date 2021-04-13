function Sup_REV1_LickLeft_DecodedError()



session_uid = fetchn(EXP.SessionID & (ANL.SVMdecoderFindErrorTrials2 & 'trial_type_name="l"') & (ANL.SVMdecoderFindErrorTrials2 & 'trial_type_name="l_-0.8Full"'), 'session_uid');

session_decoded_error=[];
trial_type_name = {'l','l_-0.8Full'};
for i = 1:1:numel(session_uid)
    key=[];
    key.session_uid = session_uid(i)
    
    rel = ANL.SVMdecoderFindErrorTrials2*EXP.SessionID  & key;
    
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
    key.trial_type_name = 'l';
    
    rel = ANL.SVMdecoderFindErrorTrials2*EXP.SessionID*EXP.BehaviorTrial  & key;
    
    true_negative = rel & 'outcome="hit"' & 'trial_decoded_as_error=0';
    true_positive = rel & 'outcome="miss"' & 'trial_decoded_as_error=1';

   accuracy(i) = (true_negative.count + true_positive.count)/rel.count;
    
end

accuracy =accuracy'
mean(accuracy)
mean(session_decoded_error)
