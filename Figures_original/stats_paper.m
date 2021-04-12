function stats_paper
Param = struct2table(fetch (ANL.Parameters,'*'));


% %% Proportion of selective cells during Sample
% 
pval_threshold =Param.parameter_value{(strcmp('p_value_threshold_selectivity',Param.parameter_name))}'

% vS1
key.brain_area = 'vS1';
key.hemisphere = 'left';
rel=(EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType & ANL.IncludeUnit2)  & key ;
rel2=rel & (ANL.SelectivitySignifEpoch2 & sprintf('selectivity_pvalue_ranksum<%.6f',pval_threshold) & 'trial_epoch_name="sample"');
num_sample_selective_units =rel2.count
proportion_selective_units =rel2.count/rel.count


% ALM
key.brain_area = 'ALM';
key.hemisphere = 'left';
rel=(EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType & ANL.IncludeUnit2)  & key & 'cell_type="Pyr"';
rel2=rel & (ANL.SelectivitySignifEpoch2 & sprintf('selectivity_pvalue_ranksum<%.6f',pval_threshold) & 'trial_epoch_name="sample"');
num_sample_selective_units =rel2.count
proportion_selective_units =rel2.count/rel.count
% 
% 
% % Pyr
% rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="Pyr"' & 'training_type="distractor"';
% rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_good &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="Pyr"' & 'training_type="distractor"';;
% rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% 
% 
% 
% % FS
% rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="FS"';
% rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_good &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="FS"';
% rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'

% 
% %% Proportion of cells
% 
% % Well isolated: total verus included
% EPHYS.Unit & 'unit_quality="good" or unit_quality="ok"' % total
% EPHYS.Unit & 'unit_quality="good" or unit_quality="ok"' & ANL.IncludeUnit2 %included
% 
% % Multi-unit : total verus included
% EPHYS.Unit & 'unit_quality="multi"' % total
% PHYS.Unit & 'unit_quality="multi"' & ANL.IncludeUnit2 %included
% 
% % Well isolated Pyramidal cells included
% EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' & ANL.IncludeUnit2 & 'cell_type="Pyr"'
% 
% 
% % Pyr
% rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' & ANL.IncludeUnit2  & 'cell_type="Pyr"' ;
% rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_good &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="Pyr"' ;
% rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% 
% 
% 
% % FS
% rel_good=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="good" or unit_quality="ok"' &ANL.IncludeUnit2  & 'cell_type="FS"';
% rel_good & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_good & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_good &  'brain_area="vS1"' & 'hemisphere="left"'
% 
% rel_multi=EPHYS.Unit*EPHYS.UnitPosition*EPHYS.UnitCellType*EXP.SessionTraining & 'unit_quality="multi" ' & ANL.IncludeUnit2  & 'cell_type="FS"';
% rel_multi & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_multi & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_multi &  'brain_area="vS1"' & 'hemisphere="left"'
% 


% %% Stimulus Power, across sessions
% k=[];
% rel = EXP.PhotostimTrialEvent*EXP.TrialName*EXP.SessionID & (EXP.Session & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"'));
% sesssion_uid = unique(fetchn(rel,'session_uid'));
% p=[];
% for i_s = 1:1:numel(sesssion_uid)
%     k.session_uid = sesssion_uid(i_s);
%     k.trial_type_name='r';
%     p(i_s) = mean(fetchn(rel & k,'power'));
%     
% end
% min(p)
% max(p)
% mean(p)
% std(p)
% %histogram(p);
% 
% %% Weak distractor Power, across sessions
% k=[];
% rel = EXP.PhotostimTrialEvent*EXP.TrialName*EXP.SessionID * (EXP.SessionTask & 'task="s1 stim"') & (EXP.Session & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"')) - ANL.SessionWithDistractorPowerNotDocumented;
% sesssion_uid = unique(fetchn(rel,'session_uid'));
% p=[];
% for i_s = 1:1:numel(sesssion_uid)
%     k.session_uid = sesssion_uid(i_s);
%     k.trial_type_name='l_-1.6Mini';
%     p(i_s) = mean(fetchn(rel & k,'power'));
%     
% end
% p(isnan(p))=[];
% 
% min(p)
% max(p)
% mean(p)
% std(p)
% histogram(p);


% %% Number of Sessions recorded per training/area 
% 
% % Well isolated Pyramidal cells included
% 
% % Pyr
% rel_sessions=ANL.SessionPosition * EXP.SessionTraining  & ANL.IncludeUnit2 & 'training_type = "distractor"';
% rel_sessions & 'brain_area="ALM"' & 'hemisphere="left"'
% rel_sessions & 'brain_area="ALM"' & 'hemisphere="right"'
% rel_sessions &  'brain_area="vS1"' & 'hemisphere="left"'

%% Number of units in each trial projected
% num_units = fetchn(ANL.ProjTrial & 'cell_type="all"' & 'unit_quality="all"' & 'mode_type_name="Ramping Orthog.1"' & 'mode_weights_sign="all"','num_units_projected');
 %mean(num_units)
%std(num_units)./sqrt(numel(num_units))

end

