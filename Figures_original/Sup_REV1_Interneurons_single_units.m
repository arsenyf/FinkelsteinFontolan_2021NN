function Sup_REV1_Interneurons_single_units() % MATLAB R2017a
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_Interneurons_single_units';


%Graphics
%---------------------------------
figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 -5 23*1.2 25*1.4]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 0 0 0]);
set(gcf,'color',[1 1 1]);


panel_width3=0.1;
panel_height3=0.12;
horizontal_distance3=0.19;
vertical_distance3=0.3;

position_x3(1)=0.17;
position_x3(2)=position_x3(1)+horizontal_distance3;
position_x3(3)=position_x3(2)+horizontal_distance3;
position_x3(4)=position_x3(3)+horizontal_distance3;
position_x3(5)=position_x3(4)+horizontal_distance3;
position_x3(6)=position_x3(5)+horizontal_distance3;

position_y3(1)=0.7;
position_y3(2)=position_y3(1)-vertical_distance3;
position_y3(3)=position_y3(2)-vertical_distance3;
position_y3(4)=position_y3(3)-vertical_distance3;


legends{1}.colr = [0 0 0]; % Distractor naive mice -mini
legends{2}.colr = [0 0 0]; % Distractor trained mice - mini
legends{3}.colr = [0 0 0]; % Distractor trained mice - full
legends{1}.title_label='Distractor-naive';
legends{1}.stimuli_label='weak';
legends{2}.title_label='Distractor-trained';
legends{2}.stimuli_label='weak';
legends{3}.title_label='Distractor-trained';
legends{3}.stimuli_label='strong';
legends{1}.title_offset=30;
legends{2}.title_offset=30;
legends{3}.title_offset=30;
legends{1}.title_xoffset=-0.1;
legends{2}.title_xoffset=-0.1;
legends{3}.title_xoffset=-0.1;


Param = struct2table(fetch (ANL.Parameters,'*'));




%% Choice mode
flag_normalize_modes=1;
axes('position',[position_x3(2), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
hold on;
key=[]; k=[];
key.unit_quality = 'ok or good';
% key.unit_quality = 'all';
key.cell_type = 'FS';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = 'ChoiceMatched';
mode_names_titles = { 'Choice'};



sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];


stim_onset=[-2.5, -1.6, -0.8];
stim_duration=0.4;
for istim=1:1:numel(stim_onset)
    xdat = [0 0 stim_duration stim_duration];
    fill([stim_onset(istim) + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
end





plot_r_flag=1;
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11FS* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;

y_lims = [-0.05,1];
xlabel_flag=0;
ylabel_flag=0;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-1.6Full';
line_style='-';
[~, ~] =figure_plotModes_correct_or_error (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[0 y_lims(2)]);
% text(xl(1)-diff(xl)*0.4 , yl(1)+diff(yl)*1.25, 'h', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
%                 text(-0.5, yl(2)*1.6, sprintf('....\nError\ntrials'), 'Color', [1 0.5 0.3], 'FontSize',7,'HorizontalAlignment','center')
box off;

%Distractor full


xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,0);
% [xl, yl] =figure_plotModes2 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
%}
set(gca,'YLim',[-0.25 1],'Ytick',[0 y_lims(2)]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'F', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Motor plan \nrobustness in ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
box off;

xlim([-3.5,0])
ylim(y_lims)


%% Switching as a function of ramping
early_delay_colr=[0 0 0];
key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'FS';
key.unit_quality = 'ok or good';
% key.unit_quality = 'all';
key.mode_weights_sign='all';
key.mode_type_name = 'Ramping Orthog.111';
key.trial_decoded_type='all';



%% Binned switch trials - distractor-trained
axes('position',[position_x3(3), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
k=[];
k=key;
k.training_type = 'distractor'
condition = 'full'
if strcmp(condition,'mini')
    k.session_flag_mini = 1;
    k.trialtype_flag_mini = 1;
elseif strcmp(condition,'full')
    k.session_flag_full = 1;
    k.trialtype_flag_full = 1;
elseif strcmp(condition,'full_late')
    k.session_flag_full_late = 1;
    k.trialtype_flag_full_late = 1;
end

hold on;

k.trial_type_name='l_-1.6Full';
rel_Switch = (ANL.SwitchProbabilityHighvsLow11FSGood* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping ) & k & (EXP.SessionTask &'task="s1 stim"') & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
switch_prob = cell2mat(fetchn(rel_Switch,'switch_prob' ,'ORDER BY session_uid'));
normalized_proj_bins =  cell2mat(fetchn(rel_Switch,'normalized_proj_bins' ,'ORDER BY session_uid'));
hold on;
switch_prob1 =  switch_prob;
x=nanmedian(normalized_proj_bins);
y_mean=nanmedian(switch_prob1);
y_stem=nanstd(switch_prob1)./sqrt(size(switch_prob1,1));
% shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',colr,'markeredgecolor',colr,'markerfacecolor',colr,'linewidth',1});

k.trial_type_name='l';
rel_Switch = (ANL.SwitchProbabilityHighvsLow11FSGood* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping) & k & (EXP.SessionTask &'task="s1 stim"') &  (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
switch_prob = cell2mat(fetchn(rel_Switch,'switch_prob' ,'ORDER BY session_uid'));
normalized_proj_bins =  cell2mat(fetchn(rel_Switch,'normalized_proj_bins' ,'ORDER BY session_uid'));
hold on;
switch_prob2 = switch_prob;
x=nanmedian(normalized_proj_bins);
y_mean=nanmedian(switch_prob2);
y_stem=nanstd(switch_prob2)./sqrt(size(switch_prob2,1));
% shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',colr,'markeredgecolor',colr,'markerfacecolor',colr,'linewidth',1});


%differencehold on;
x=nanmedian(normalized_proj_bins);
switch_prob=switch_prob1-switch_prob2;
switch_prob=switch_prob./100;
% switch_prob = switch_prob- nanmean(switch_prob,2);
% switch_prob = switch_prob- nanmin(switch_prob,[],2);
y_mean=nanmedian(switch_prob);
y_stem=nanstd(switch_prob)./sqrt(size(switch_prob,1));
shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',early_delay_colr,'markeredgecolor',early_delay_colr,'markerfacecolor',early_delay_colr,'linewidth',1});
xl=[0 1];
yl=[0 0.5];
xlim(xl);
ylim(yl);
set(gca,'FontSize',7,'Xtick',[0 0.5 1],'Ytick',yl);
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.4,sprintf('Ramping before \n distractor (a.u.)'),'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.6, sprintf('%s \n strong distractors    '),'FontSize',7,'HorizontalAlignment','center','fontweight','bold');
% text(xl(1)+diff(xl)*-0.4, yl(1)+diff(yl)*0.5,sprintf('\\Delta response\n lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*-0.6, yl(1)+diff(yl)*0.5,sprintf('Proportion of\n  Switching Trials '),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');



[h,p]=ttest2(switch_prob(:,1),switch_prob(:,end))

% Cuzick's test
values=[switch_prob(:,1)',switch_prob(:,2)',switch_prob(:,3)'];
groups=[1*ones(1,length(switch_prob(:,1)')) ,2*ones(1,length(switch_prob(:,1)')) , 3*ones(1,length(switch_prob(:,1)'))];
idx_notNAN=~isnan(values);
x=[values(idx_notNAN)' groups(idx_notNAN)'];
cuzick(x)

% Repeated Measures ANOVA
t = table(switch_prob(:,1),switch_prob(:,2),switch_prob(:,3),...
    'VariableNames',{'meas1','meas2','meas3'});
Ramping_levels = [1,2,3];
rm = fitrm(t,'meas1-meas3 ~ 1','WithinDesign',Ramping_levels);

ranovatbl = ranova(rm);
ranovatbl
ranovatbl.pValue
if ranovatbl.pValue(1)<=0.05
    tbl = multcompare(rm,'Time','ComparisonType','tukey-kramer')
end


%% FS and Pyr endpoints

Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};

min_num_units_projected = 6;

smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.1;
t2=0;
tidx = time>t1 & time<=t2;



%% Endpoints PYR

mode_type_name ='Ramping Orthog.111';
% mode_type_name ='ChoiceMatched';

key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'PYR';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.is_outlier=0;
key.mode_type_name = mode_type_name;
% key.trial_type_name='r';

rel_PYR = ( ANL.ProjTrialNormalizedMedianNormalized11Pyr * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;


%% Endpoints FS

key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'FS';
% key.unit_quality = 'all';
key.unit_quality = 'ok or good';

key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.is_outlier=0;
key.mode_type_name = mode_type_name;
% key.trial_type_name='r';

rel_FS = ( ANL.ProjTrialNormalizedMedianNormalized11FSGood * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;


rel_trials = (EXP.TrialID & rel_PYR & rel_FS);

rel_PYR = rel_PYR & rel_trials;
rel_FS = rel_FS & rel_trials;


all_projs=cell2mat(fetchn(rel_PYR*EXP.TrialID & k,'proj_trial', 'ORDER BY trial_uid'));
all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints_PYR = nanmean(all_projs(:,tidx),2);


all_projs=cell2mat(fetchn(rel_FS*EXP.TrialID & k,'proj_trial', 'ORDER BY trial_uid'));
all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints_FS = nanmean(all_projs(:,tidx),2);

idx_not_nan = ~isnan(endpoints_PYR+endpoints_FS);


endpoints_PYR = endpoints_PYR (idx_not_nan);
endpoints_FS = endpoints_FS (idx_not_nan);

idx_not_inf = ~((endpoints_PYR+endpoints_FS)==inf | (endpoints_PYR+endpoints_FS)==-inf);

endpoints_PYR = endpoints_PYR (idx_not_inf);
endpoints_FS = endpoints_FS (idx_not_inf);

% isoutlier_PYR = isoutlier(endpoints_PYR)
% isoutlier_FS = isoutlier(endpoints_FS);
%
% endpoints_PYR = endpoints_PYR (~isoutlier_PYR & ~isoutlier_FS);
% endpoints_FS = endpoints_FS (~isoutlier_PYR & ~isoutlier_FS);



axes('position',[position_x3(1), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
hold on;
plot(rescale(endpoints_PYR), rescale(endpoints_FS),'.')
r=corr([endpoints_PYR,endpoints_FS]);
xlabel(sprintf('Putative Pyramidal cells,\nRamping mode \n (normalized)'));
ylabel(sprintf('Putative F.S. interneurons,\nRamping mode\n (normalized)'));
title(sprintf('Single-trial \nendpoints r = %.2f',r(2)))

axis equal
axis tight


%% Stimulus quantification

% axes('position',[position_x3(1), position_y3(2), panel_width3*1.4, panel_height3*1.2]);
% % Full Stimuli
% key=[]; k=[];
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.training_type = 'distractor';
% % key.unit_quality = 'ok or good'  %'ok or good'
% key.unit_quality = 'multi';
% key.cell_type = 'FS';
% k = key;
% k.session_flag_full = 1;
% k.trialtype_flag_left_stim_full_nopresample = 1;
% k.trialtype_flag_full = 1;
% if contains(key.unit_quality, 'ok or good')
%     k= rmfield(k,'unit_quality');
%     rel3=(EXP.SessionID *  EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'unit_quality!="multi"' & 'outcome="response"' & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
%     key.unit_quality = 'ok';
% elseif contains(key.unit_quality, 'multi')
%     k= rmfield(k,'unit_quality');
%     rel3=(EXP.SessionID * EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'outcome="response"' & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
%     key.unit_quality = 'multi';
% else
%     rel3=(EXP.SessionID * EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'outcome="response"' & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
% end
% 
% % Plot
% k3=k;
% label_flag=0;
% plot_r_flag=1;
% [xl,yl] = figure_plot_vs1_stimulus_full(rel3, k3, label_flag, plot_r_flag);
% % text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.55, sprintf('%s', legends{2}.title_label),'FontSize',7,'Color',legends{3}.colr,'HorizontalAlignment','center','fontweight','bold');
% % text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35, sprintf('full stimuli'),'FontSize',7,'Color',legends{3}.colr,'HorizontalAlignment','center','fontweight','bold');
% % 
% % text(-1.8,ceil(yl(2))*0.93,'Delay','FontSize',6);
% set(gca,'Xtick',[-2.5 -1.6 -0.8 0],'XtickLabel',[-2.5 -1.6 -0.8 0]);
% text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
% text(-3,yl(1)+diff(yl)*1.35,'Population response','FontSize',7);
%     text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*0.5,[' \Delta Firing ' sprintf('rate \n(Spikes s^{-1})')], 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
% text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'D', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% 
% 
% % FR Quantification
% axes('position',[position_x3(2), position_y3(2), panel_width3*1.4, panel_height3*1.2]);
% 
% xl=[-2.9 0];
% yl=[0,1];
% 
% text(xl(1)-diff(xl)*0.25, yl(1)+diff(yl)*0.5,['\Delta spikes'], 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',legends{1}.colr);
% text(-1.8,yl(2)*0.9,'Delay','FontSize',6);
% colr=legends{1}.colr;
% fn_plot_stimulus_quantification(rel3, k3,colr, yl)
% ylim(yl);
% xlim(xl);
% set(gca,'Ytick',yl, 'YColor',colr,'Fontsize', 7,'XTick',[])
% % xlabel ('Time (s)','Fontsize', 7);
% % title(sprintf('Spike count in vS1\n  at stimulation'),'Fontsize', 7);
% text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'F', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);
% text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
% set(gca,'Xtick',[-2 0], 'Ytick',[yl(1) yl(2)], 'YColor',colr,'Fontsize', 7)
% 
% xlim([-3.5,0])
% 




% Population
plot_r_flag=1;
flag_normalize_modes=1;
key=[]; k=[];
key.unit_quality = 'ok or good';
% key.unit_quality = 'all';

key.cell_type = 'FS';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = 'Stimulus Orthog.111';
mode_names_titles = { 'Stimulus'};
key.training_type = 'distractor';

% All Weights
axes('position',[position_x3(3), position_y3(2), panel_width3*1.4, panel_height3*1.2]);
k=key;
k.mode_weights_sign = 'all';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
% rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverageBaseline5* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"') - ANL.ExcludeSession) & k ;
rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11FS * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"') ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');

stim_icon_flag=1;
ylabel_flag=1;
xlabel_flag=1;
y_lims = [-0.7,1.05];
% [xl, yl] =figure_plotModes6 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_icon_flag);
[xl, yl] =figure_plotModes2 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_icon_flag);

% text(xl(1)-diff(xl)*0.5, yl(1)+diff(yl)*1.3, 'j', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'Ytick',[ 0 1]);
text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*1.3, 'G', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Population response','FontSize',7);
xlim([-3.5,0])
ylim(y_lims)


% Stimulus quantification
%-----------------------------------------------------------------------------
plot_r_flag=1;
flag_normalize_modes=1;
axes('position',[position_x3(4), position_y3(2), panel_width3*1.4, panel_height3*1.2]);
hold on;
colr = legends{3}.colr;
yl=[0,1.5];
ylim(yl);
signif_display_offset =-0.3;
compute_stim_amp_full_pairwise2 (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);
% compute_stim_amp_full (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);

xl=[-2.9 0];
xlim(xl);
set(gca,'Xtick',[-2.5 -1.6 -0.8 0], 'Ytick',[0 1], 'Fontsize', 7)
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5, sprintf('Stimulus mode \n response (a.u.)'), 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',colr);
xl=[-2.9 0];
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-1.8,ceil(yl(2))*0.6,'Delay','FontSize',6);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'H', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);
xlim([-3.5,0])







%% Ramping mode
flag_normalize_modes=1;
axes('position',[position_x3(4), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
hold on;
key=[]; k=[];
key.unit_quality = 'ok or good';
% key.unit_quality = 'all';
key.cell_type = 'FS';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = 'Ramping Orthog.111';
mode_names_titles = { 'Ramping'};



sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];


stim_onset=[-2.5];
stim_duration=0.4;
for istim=1:1:numel(stim_onset)
    xdat = [0 0 stim_duration stim_duration];
    fill([stim_onset(istim) + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
end

plot_r_flag=1;
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_left_and_right_no_distractors = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11FS* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;

y_lims = [-0.1,1];
xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=1;
outcome='hit';
line_style='-';
[~, ~] =figure_plotModes_correct_or_error (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[0 y_lims(2)]);
box off;
set(gca,'YLim',[-0.25 1],'Ytick',[0 y_lims(2)]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'F', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
box off;

xlim([-3.5,0])
ylim(y_lims)



if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end

figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end



