function Fig4() % MATLAB R2017a
close all;

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Fig4';

legends{2}.colr = [0 0 1]; % Distractor trained mice, right stimuli
legends{2}.title_label='Distractor-trained mice';
legends{2}.stimuli_label='full';
legends{1}.title_offset=25;
legends{2}.title_offset=0;
legends{1}.title_xoffset=-0.1 ;
legends{2}.title_xoffset=-0.1;
%Graphics
%---------------------------------
figure1=figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);
set(gcf,'color',[1 1 1]);

panel_width1=0.11;
panel_height1=0.09;
horizontal_distance1=0.16;
vertical_distance1=0.16;

position_x1(1)=0.07;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;
position_x1(7)=position_x1(6)+horizontal_distance1*0.6;

position_y1(1)=0.77;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1*1;


panel_width2=0.075;
panel_height2=0.08;
horizontal_distance2=0.105;
vertical_distance2=0.11;


position_x2(1)=0.47;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2*1.25;
position_x2(4)=position_x2(3)+horizontal_distance2;
position_x2(5)=position_x2(4)+horizontal_distance2;
position_x2(6)=position_x2(5)+horizontal_distance2;

position_y2(1)=0.8;
position_y2(2)=position_y2(1)-vertical_distance2*0.9;
position_y2(3)=position_y2(2)-vertical_distance2*1.1;
position_y2(4)=position_y2(3)-vertical_distance2;

Param = struct2table(fetch (ANL.Parameters,'*'));

%%{
%% Behavior
axes('position',[position_x1(1), position_y1(1), panel_width1, panel_height1]);
flag_plot_left_right_trials =2 % (0 both), (1 left), (2 right) (3 right with left as baseline)

%Expert on Full distractors
%--------------------------------------
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6,3,2,5,7,8,9)' & 'training_type="distractor"' & 'session_comment="good behavior"');
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)' & 'training_type="distractor"' & 'session_comment="good behavior"');
clear trial_type_names  b
[trial_type_names, b] = fn_fetch_behav(b_query);
names_right_trials = {'r', 'r_-3.8Full', 'r_-1.6Full', 'r_-0.8Full'};
% names_left_trials = {'l', 'l_-3.8Full','r', 'l_-1.6Full', 'l_-0.8Full'};
names_left_trials = {'l', 'r', 'l_-1.6Full', 'l_-0.8Full'};
x_r = [(-3.8), (-1.6), (-0.8)];
% x_l = [(-3.8),(-2.5), (-1.6), (-0.8)];
x_l = [(-2.5), (-1.6), (-0.8)];
% Choosing which trial-types to display
%--------------------------------------
clear behav_param behav_param_mean behav_param_signif trn_r trn_l y_r y_l
behav_param = b.prcnt_hit_outof_noignore_noearly;
[behav_param_mean, behav_param_signif, trn_r, trn_l, y_r, y_l ] = fn_choose_behav_trials(behav_param,trial_type_names, names_right_trials, names_left_trials);
% Plotting Performance
%-------------------------------------------
plot_signif_offset=+5;
[xl,yl]=figure_plot_behav_distractor_full_righttrials (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset, names_right_trials, names_left_trials, legends{2} );

text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.55, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.27,'Time (s)', 'FontSize',7,'HorizontalAlignment','center');

%}

%% Choice mode - right trial
plot_r_flag=1;
flag_normalize_modes=1;

key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.outcome='hit';
key.mode_type_name = 'ChoiceMatched';
mode_names_titles = { 'Choice'};

axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
%Distractor full
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_right_full_nopresample_and_control_left=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.13,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes4 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'b', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca,'YTick',[0 1]);

%% Choice mode - right trial, presample
plot_r_flag=1;
flag_normalize_modes=1;
k=[];
axes('position',[position_x1(3), position_y1(1), panel_width1, panel_height1]);
%Distractor full
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_right_full_only_presample_and_control_left=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.13,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes4 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca,'YTick',[0 1]);

% %% Example cells
% unit_counter=0;
% % Cell 1
% key_u.unit_uid=1228; %306 good % 369 interesting, 409 interesting, 1228 ok, 3322 great
% axes('position',[position_x1(4), position_y1(1), panel_width1, panel_height1]);
% xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='d';
% fn_plot_PSTH_Supp_right (Param, 'hit', 1, 1, [], 1, key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);
% 
% 
% xl=[-2.9 1];

%% No-lick Trials - Regular mice
%--------------------------------------------------------------------------
xl=[-3.5 0.1];

plot_r_flag=1;
flag_normalize_modes=1;

key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.training_type = 'regular';


% Stimulus mode
mode_names = { 'Stimulus Orthog.111'};
mode_names_titles = { 'Stimulus'};
axes('position',[position_x1(1), position_y1(2), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=1;
y_lims = [-0.25,1];
stim_time_flag=1;
stim_legend_flag=1;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.2, 'd', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*1.0, yl(1)+diff(yl)*1.2, '--- No-lick trials', ...
    'fontsize', 7,  'fontweight', 'bold', 'HorizontalAlignment','center');
text(-1.75, yl(1)+diff(yl)*1, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca, 'Ytick',[0 y_lims(2)]);

% Choice mode
mode_names = { 'ChoiceMatched'};
mode_names_titles = { 'Choice'};
axes('position',[position_x1(2), position_y1(2), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=0;
y_lims = [-1,1];
stim_time_flag=1;
stim_legend_flag=1;
[~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
text(-1.75, yl(1)+diff(yl)*1, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca, 'Ytick',[y_lims(1) 0 y_lims(2)]);

% Ramping mode
mode_names = { 'Ramping Orthog.111'};
mode_names_titles = { 'Ramping '};
axes('position',[position_x1(3), position_y1(2), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=0;
y_lims = [-0.25,1];
stim_time_flag=1;
stim_legend_flag=1;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
text(-1.75, yl(1)+diff(yl)*1, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');


%% No-lick Trials - Distractor mice
%--------------------------------------------------------------------------
plot_r_flag=1;
flag_normalize_modes=1;

key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.training_type = 'distractor';


% Stimulus mode
mode_names = { 'Stimulus Orthog.111'};
mode_names_titles = { 'Stimulus'};
axes('position',[position_x1(1), position_y1(3), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=0;
y_lims = [-0.25,1];
stim_time_flag=1;
stim_legend_flag=1;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.2, 'e', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(-2.5, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');

% Choice mode
mode_names = { 'ChoiceMatched'};
mode_names_titles = { 'Choice'};
axes('position',[position_x1(2), position_y1(3), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=0;
y_lims = [-1,1];
stim_time_flag=1;
stim_legend_flag=1;
[~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
% text(-2.5, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
set(gca, 'Ytick',[y_lims(1) 0 y_lims(2)]);


% Ramping mode
mode_names = { 'Ramping Orthog.111'};
mode_names_titles = { 'Ramping '};
axes('position',[position_x1(3), position_y1(3), panel_width1, panel_height1]);
outcome='hit';
line_style='-';
k=[];
k=key;
k.mode_weights_sign = 'all';
k.trialtype_left_and_right_no_distractors=1;
title1 = '';
title2='';
title3=[];
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=0;
ylabel_flag=0;
y_lims = [-0.25,1];
stim_time_flag=1;
stim_legend_flag=1;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);

outcome='ignore';
xlabel_flag=1;
ylabel_flag=1;
line_style='--';
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
stim_time_flag=0;
stim_legend_flag=0;
[xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag, stim_legend_flag);
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.2, 'd', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(-2.5, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');

% %% With distractor plotted
% %% No-lick Trials - Regular mice
% %--------------------------------------------------------------------------
% plot_r_flag=1;
% flag_normalize_modes=1;
% 
% key=[]; k=[];
% key.unit_quality = 'all';
% key.cell_type = 'Pyr';
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.training_type = 'regular';
% 
% mode_names = { 'Stimulus Orthog.111'};
% mode_names_titles = { 'Stimulus '};
% % Stimulus mode
% axes('position',[position_x1(1), position_y1(3), panel_width1, panel_height1]);
% outcome='hit';
% line_style='-';
% k=[];
% k=key;
% k.mode_weights_sign = 'all';
% k.session_flag_mini = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_mini = 1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% xlabel_flag=1;
% ylabel_flag=1;
% y_lims = [-0.25,1];
% stim_time_flag=1;
% [xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% 
% outcome='ignore';
% line_style=':';
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% stim_time_flag=0;
% [xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.2, 'd', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)/2, yl(1)+diff(yl)*1.15, 'No-lick trials', ...
%     'fontsize', 7,  'fontweight', 'bold', 'HorizontalAlignment','center');
% text(-2, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
% 
% % Choice mode
% mode_names = { 'ChoiceMatched'};
% mode_names_titles = { 'Choice'};
% axes('position',[position_x1(2), position_y1(3), panel_width1, panel_height1]);
% outcome='hit';
% line_style='-';
% k=[];
% k=key;
% k.mode_weights_sign = 'negative';
% k.trialtype_left_and_right_no_distractors=1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% xlabel_flag=1;
% ylabel_flag=1;
% y_lims = [-1,1];
% stim_time_flag=1;
% [~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% 
% outcome='ignore';
% k=[];
% k=key;
% k.mode_weights_sign = 'negative';
% k.session_flag_mini = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_mini = 1;
% line_style=':';
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% stim_time_flag=0;
% [~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% text(-2, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
% 
% 
% %% No-lick Trials - Distractor mice
% %--------------------------------------------------------------------------
% plot_r_flag=1;
% flag_normalize_modes=1;
% 
% key=[]; k=[];
% key.unit_quality = 'all';
% key.cell_type = 'Pyr';
% key.mode_weights_sign = 'all';
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.training_type = 'distractor';
% mode_names = { 'Stimulus Orthog.111'};
% mode_names_titles = { 'Stimulus '};
% 
% % Stimulus mode
% axes('position',[position_x1(3), position_y1(3), panel_width1, panel_height1]);
% outcome='hit';
% line_style='-';
% k=[];
% k=key;
% k.mode_weights_sign = 'all';
% k.session_flag_full = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_full = 1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% xlabel_flag=1;
% ylabel_flag=1;
% y_lims = [-0.25,1];
% stim_time_flag=1;
% [xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% 
% 
% outcome='ignore';
% line_style=':';
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% stim_time_flag=0;
% [xl, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.2, 'd', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)/2, yl(1)+diff(yl)*1.15, 'No-lick trials', ...
%     'fontsize', 7,  'fontweight', 'bold', 'HorizontalAlignment','center');
% text(-2, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
% 
% % Choice mode
% mode_names = { 'ChoiceMatched'};
% mode_names_titles = { 'Choice'};
% axes('position',[position_x1(4), position_y1(3), panel_width1, panel_height1]);
% outcome='hit';
% line_style='-';
% k=[];
% k=key;
% k.mode_weights_sign = 'negative';
% k.session_flag_full = 1;
% k.trialtype_left_and_right_no_distractors = 1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% xlabel_flag=1;
% ylabel_flag=1;
% y_lims = [-1,1];
% stim_time_flag=1;
% [~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% 
% outcome='ignore';
% line_style=':';
% k=[];
% k=key;
% k.mode_weights_sign = 'negative';
% k.session_flag_full = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_full = 1;
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% stim_time_flag=0;
% [~, yl] =figure_plotModes5 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names, mode_names_titles, y_lims,outcome, flag_normalize_modes,plot_r_flag,xl,line_style, stim_time_flag);
% text(-2, yl(1)+diff(yl)*1, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
% 
% 

if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




