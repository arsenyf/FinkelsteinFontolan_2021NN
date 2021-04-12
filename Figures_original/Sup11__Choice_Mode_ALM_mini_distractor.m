function SupX2_Choice_Mode_ALM_mini_distractor() % MATLAB R2017a
close all;

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'SupXXX_Choice_Mode_ALM_mini_distractor';
flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

mode_type_name='ChoiceMatched';

legends{1}.colr = [0.7188    0.5234    0.0430]; % Distractor naive mice -mini
legends{2}.colr = [0.5 0 0.5]; % Distractor trained mice - mini
legends{3}.colr = [0.5 0 0.5]; % Distractor trained mice - full
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

%Graphics
%---------------------------------
figure1=figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);

panel_width1=0.1;
panel_height1=0.09;
horizontal_distance1=0.13;
vertical_distance1=0.21;

position_x1(1)=0.05;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1*1.4;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;

position_y1(1)=0.8;
position_y1(2)=position_y1(1)-vertical_distance1;
% position_y1(3)=position_y1(2)-vertical_distance1;
% position_y1(4)=position_y1(3)-vertical_distance1;
% position_y1(5)=position_y1(4)-vertical_distance1;


panel_width2=0.12;
panel_height2=0.12;
horizontal_distance2=0.19;
vertical_distance2=0.21;


position_x2(1)=0.53;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2;
position_x2(4)=position_x2(3)+horizontal_distance2;

position_y2(1)=0.8;
position_y2(2)=position_y2(1)-vertical_distance2;
% position_y2(3)=position_y2(2)-vertical_distance2;
% position_y2(4)=position_y2(3)-vertical_distance2;

Param = struct2table(fetch (ANL.Parameters,'*'));

unit_counter=0;




%% Both Hemispheres, Distractor-naive, Mini Stimuli

% Cell 1
key_u.unit_uid=2732; %2587, 2732, 
yl=[5,42];
axes('position',[position_x1(1), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='A';
fn_plot_PSTH_Supp4 (Param, 'hit', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);
text(-3,yl(2)*1.7,'Distractor-naive mice, weak distractors','HorizontalAlignment','Left','FontSize',9,'Color', legends{1}.colr,'fontweight','bold' )
text(-1.5,yl(2)*1.2,'Delay','FontSize',6);

% Cell 2
key_u.unit_uid=2695; %3987
yl=[0,7];
axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='';
fn_plot_PSTH_Supp4 (Param, 'hit', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);

% 
% % Cell 3
% key_u.unit_uid=2817; %4712, 4775
% yl=[10,30];
% axes('position',[position_x1(3), position_y1(1), panel_width1, panel_height1]);
% xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title='Right ALM'; cell_label='';
% fn_plot_PSTH_Supp4 (Param, 'hit', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);

% % Population
% plot_r_flag=1;
% flag_normalize_modes=1;
% key=[]; k=[];
% key.unit_quality = 'ok or good';
% key.cell_type = 'Pyr';
% key.brain_area = 'ALM';
% % key.hemisphere = 'left';
% key.mode_type_name = mode_type_name;
% key.outcome='hit';
% key.training_type = 'regular';
% 
% % All Weights
% axes('position',[position_x1(4), position_y1(1), panel_width1, panel_height1]);
% k=key;
% k.mode_weights_sign = 'all';
% k.session_flag_mini = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_mini = 1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_reg_mini =((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverageBaseline* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime) ) & k ;
% ylabel_flag=1;
% xlabel_flag=1;
% y_lims = [-0.15,1.05];
% [xl, yl] =figure_plotModes3 (rel_choice_reg_mini,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag);
% text(xl(1)-diff(xl)*0.6, yl(1)+diff(yl)*1.2, 'b', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% set(gca,'FontSize',7,'Ytick',[ 0 1]);


% Choice mode
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = mode_type_name;
mode_names_titles = { 'Choice'};


axes('position',[position_x1(3), position_y1(1), panel_width1, panel_height1]);
%Distractor full
plot_r_flag=1;
k=[];
k=key;
k.training_type = 'regular';
k.session_flag_mini = 1;
k.trialtype_flag_left_and_control_right_nopresample_nosample = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_mini = 1;
title1 = '';
title2='';
title3=[];
rel_choice_naive =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.7,1];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error_suppl_mini (rel_choice_naive,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.2, 'B', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'FontSize',7,'Ytick',[ 0 1]);
text(-3,yl(1)+diff(yl)*1.35,'Population response','HorizontalAlignment','Left','FontSize',7)



%% Both hemispheres, Distractor-trained, Mini Stimuli

% Cell 1
key_u.unit_uid=49; %61 good; 42 216 %very good 324 % 1327 not good %3719 great
yl=[0,18];
axes('position',[position_x1(1), position_y1(2), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='C';
fn_plot_PSTH_Supp4 (Param, 'hit',1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);
text(-3,yl(2)*1.7,'Distractor-trained mice, weak distractors','HorizontalAlignment','Left','FontSize',9,'Color', legends{3}.colr,'fontweight','bold')

% Cell 2
key_u.unit_uid=101; % 81 good %1563 %271 not good because it is not selective in the end
yl=[0,40];
axes('position',[position_x1(2), position_y1(2), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='';
fn_plot_PSTH_Supp4 (Param, 'hit', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);


% % Cell 3
% key_u.unit_uid=1565; %367 %306 %320 good
% yl=[0,44];
% axes('position',[position_x1(3), position_y1(2), panel_width1, panel_height1]);
% xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title='Right ALM'; cell_label='';
% fn_plot_PSTH_Supp4 (Param, 'hit',1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label, yl);


% % Population
% plot_r_flag=1;
% flag_normalize_modes=1;
% key=[]; k=[];
% key.unit_quality = 'ok or good';
% key.cell_type = 'Pyr';
% key.brain_area = 'ALM';
% % key.hemisphere = 'left';
% key.outcome='hit';
% key.mode_type_name = mode_type_name;
% key.training_type = 'distractor';
% 
% % All Weights
% axes('position',[position_x1(4), position_y1(2), panel_width1, panel_height1]);
% k=key;
% k.mode_weights_sign = 'all';
% k.session_flag_mini = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_mini = 1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_dist_mini =((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverageBaseline* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime) ) & k ;
% ylabel_flag=1;
% xlabel_flag=1;
% y_lims = [-1,1.05];
% [xl, yl] =figure_plotModes3 (rel_choice_dist_mini,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag);
% text(xl(1)-diff(xl)*0.6, yl(1)+diff(yl)*1.2, 'd', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% set(gca,'FontSize',7,'Ytick',[-1 0 1]);
% 
% 

% Choice mode
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = mode_type_name;
mode_names_titles = { 'Choice'};


axes('position',[position_x1(3), position_y1(2), panel_width1, panel_height1]);
%Distractor full
plot_r_flag=1;
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_mini = 1;
k.trialtype_flag_left_and_control_right_nopresample_nosample = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;

k.trialtype_flag_mini = 1;
title1 = '';
title2='';
title3=[];
rel_choice_trained =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-1.5,1];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error_suppl_mini (rel_choice_trained,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.2, 'D', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'FontSize',7,'Ytick',[ 0 1]);
text(-3,yl(1)+diff(yl)*1.35,'Population response','HorizontalAlignment','Left','FontSize',7)





%% Stim kinetics
flag_normalize_modes=1;

% Regular mini
axes('position',[position_x2(1), position_y2(1), panel_width2, panel_height2]);
 xdat = [0 0 0.1 0.1];
 sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
fill([0 + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
outcome='hit';
% Distractor mini
%Trained
colr = legends{3}.colr;
% compute_stim_kinetics_modes4 ((rel_choice_trained & 'outcome="hit"'),  Param, colr, flag_normalize_modes, key);
compute_stim_kinetics_modes5 (rel_choice_trained, outcome,  Param, colr, flag_normalize_modes, key);
%Naive
colr = legends{1}.colr;
% compute_stim_kinetics_modes4 ((rel_choice_naive & 'outcome="hit"'),  Param, colr, flag_normalize_modes, key);
compute_stim_kinetics_modes5 (rel_choice_naive, outcome,   Param, colr, flag_normalize_modes, key);

% % Distractor full
% colr = legends{3}.colr;
% compute_stim_kinetics_modes4 (rel_choice_dis_full,  Param, colr, flag_normalize_modes, key);

% xl=[0 0.8];
xl=[0 0.8];
xlim(xl);
yl = [-0.1 0.15];
ylim(yl);
set(gca,'FontSize',7,'Ytick',[0 0.15], 'Xtick',[0 xl(2)], 'XtickLabel',[0 0.8]);
text(xl(1)+diff(xl)*-0.4, yl(1)+diff(yl)*1.2, 'E', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time relative \n to distractor onset (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text ((xl(1)-diff(xl)*0.3), (yl(1) + diff(yl)*0.4), sprintf('Impact on\nChoice mode  (a.u.)'),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*1.15), sprintf('Distractor impact'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
text(xl(1)+diff(xl)*1.3, yl(1)+diff(yl)*0.8,sprintf('Distractor\nnaive'),'Color', legends{1}.colr,'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*1.3, yl(1)+diff(yl)*0.4,sprintf('Distractor\ntrained'),'Color', legends{3}.colr,'FontSize',7,'HorizontalAlignment','center');

box off;


mintrials_behav_typeoutcome =fetch1(ANL.Parameters & 'parameter_name="mintrials_behav_typeoutcome"','parameter_value');


%% Behavior at LateDelay
axes('position',[position_x2(1), position_y2(2), panel_width2, panel_height2]);
late_delay_colr=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');

k=[];
b_query2 = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="regular"'  & 'task_protocol in (2,5,7,8,9)' & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) ));
[trial_type_names, b] = fn_fetch_behav(b_query2);
idx_pure_l = strcmp(trial_type_names,'l');
idx_dist_l = strcmp(trial_type_names,'l_-0.8Mini');
behav_param = b.prcnt_hit_outof_noignore_noearly;
x=(100-behav_param(idx_dist_l).values ) - (100-behav_param(idx_pure_l).values );
bias(1).mean= nanmean(x);
bias(1).stem= nanstd(x)/sqrt(numel(~isnan(x)));

b_query2 = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="regular"'  & 'task_protocol in (7,8,9)' & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) ));
[trial_type_names, b] = fn_fetch_behav(b_query2);
idx_pure_l = strcmp(trial_type_names,'l');
idx_dist_l = strcmp(trial_type_names,'l_-0.8Full');
behav_param = b.prcnt_hit_outof_noignore_noearly;
x=(100-behav_param(idx_dist_l).values ) - (100-behav_param(idx_pure_l).values );
bias(2).mean= nanmean(x);
bias(2).stem= nanstd(x)/sqrt(numel(~isnan(x)));
[~,p] = ttest2(behav_param(idx_dist_l).values , behav_param(idx_pure_l).values)

% 
% k.trial_type_name='l_-0.8Mini';
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & 'training_type="distractor"' );
% b_query = (EXP.SessionID * ANL.SessionBehavPerformance & k) & ((EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (2,5,7,8,9)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)) & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)));
% late_delay=fetchn(b_query,'prcnt_hit_outof_noignore_noearly');
% k.trial_type_name='l';
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & 'training_type="distractor"' );
% b_query = (EXP.SessionID * ANL.SessionBehavPerformance & k) & ((EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (2,5,7,8,9)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)) & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)));
% l=fetchn(b_query,'prcnt_hit_outof_noignore_noearly');
b_query2 = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (2,5,7,8,9)' & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) ));
[trial_type_names, b] = fn_fetch_behav(b_query2);
idx_pure_l = strcmp(trial_type_names,'l');
idx_dist_l = strcmp(trial_type_names,'l_-0.8Mini');
behav_param = b.prcnt_hit_outof_noignore_noearly;
x=(100-behav_param(idx_dist_l).values ) - (100-behav_param(idx_pure_l).values );
bias(3).mean= nanmean(x);
bias(3).stem= nanstd(x)/sqrt(numel(~isnan(x)));

% k.trial_type_name='l_-0.8Full';
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)' & 'training_type="distractor"' );
% b_query = (EXP.SessionID * ANL.SessionBehavPerformance & k) & ((EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (4,6)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)) & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)));
% late_delay=fetchn(b_query,'prcnt_hit_outof_noignore_noearly');
% k.trial_type_name='l';
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)' & 'training_type="distractor"' );
% b_query = (EXP.SessionID * ANL.SessionBehavPerformance & k) & ((EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (4,6)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)) & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)));
% l=fetchn(b_query,'prcnt_hit_outof_noignore_noearly');
b_query2 = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="distractor"'  & 'task_protocol in (4,6)' & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) ));
[trial_type_names, b] = fn_fetch_behav(b_query2);
idx_pure_l = strcmp(trial_type_names,'l');
idx_dist_l = strcmp(trial_type_names,'l_-0.8Full');
behav_param = b.prcnt_hit_outof_noignore_noearly;
x=(100-behav_param(idx_dist_l).values ) - (100-behav_param(idx_pure_l).values );
bias(4).mean= nanmean(x);
bias(4).stem= nanstd(x)/sqrt(numel(~isnan(x)));


hold on;
xl=[0 5.5];
yl=[0 50];
bar([1 2 3.5 4.5],[bias.mean],'facecolor',late_delay_colr)
errorbar([1 2 3.5 4.5],[bias.mean],  [bias.stem],'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',6);
set(gca,'Xlim',xl,'Ylim',yl,'Xtick',[1 2 3.5 4.5],'XtickLabel',{'Weak     ',' Strong ','     Weak  ','           Strong'},'FontSize',6);
text(xl(1)+diff(xl)*0.2, yl(1)-diff(yl)*0.3,sprintf('Distractor\nnaive'),'Color', legends{1}.colr,'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*0.8, yl(1)-diff(yl)*0.3,sprintf('Distractor\ntrained'),'Color', legends{3}.colr,'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'Distractors at Late Delay','FontSize',7,'HorizontalAlignment','center','Color',late_delay_colr);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.2, 'F', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(2, 47, '***', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold','HorizontalAlignment','center');
text(xl(1)-diff(xl)*0.25,yl(1)+diff(yl)*0.45,sprintf('\\Delta response  lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');




if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




