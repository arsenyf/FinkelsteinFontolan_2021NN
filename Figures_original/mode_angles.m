function mode_angles()
key.brain_area='ALM'
key.hemisphere='left';
key.training_type='regular';
rel = ANL.Mode10*EXP.SessionID*EPHYS.Unit*EPHYS.UnitPosition* EXP.SessionTraining & ANL.IncludeUnit2 & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0');

s_uid=unique(fetchn(rel & key,'session_uid'));
r=[];
for i=1:1:numel(s_uid)
    k.session_uid = s_uid(i);
key.mode_type_name='Ramping Orthog.1';
w1=fetchn( rel & key &k,'mode_unit_weight','ORDER BY unit_uid');

key.mode_type_name='ChoiceMatched';
w4=fetchn( rel & key &k,'mode_unit_weight','ORDER BY unit_uid');
r(i)=corr(w1,w4,'rows','pairwise');

end
nanmean(r)
nanstd(r)/sqrt(numel(r))

figure
histogram(r)

