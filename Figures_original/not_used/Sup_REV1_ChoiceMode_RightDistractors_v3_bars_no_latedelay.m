function Sup_REV1_ChoiceMode_RightDistractors_v3_bars_no_latedelay() % MATLAB R2017a
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_ChoiceMode_RightDistractors_v3_bars_no_latedelay';

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
mintrials_behav_typeoutcome =fetch1(ANL.Parameters & 'parameter_name="mintrials_behav_typeoutcome"','parameter_value');

%%{
%% Behavior
axes('position',[position_x1(1), position_y1(1), panel_width1, panel_height1]);
flag_plot_left_right_trials =2 % (0 both), (1 left), (2 right) (3 right with left as baseline)

%Expert on Full distractors
%--------------------------------------
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6,3,2,5,7,8,9)' & 'training_type="distractor"' & 'session_comment="good behavior"');
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)' & 'training_type="distractor"' & 'session_comment="good behavior"');
b_query = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining * (EXP.SessionTask & 'task="s1 stim"') & 'training_type="distractor"'  & 'task_protocol in (4,6)' & (ANL.SessionBehavPerformance   & 'trial_type_name="r"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome)) & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) )) ;

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
[xl,yl]=figure_plot_behav_distractor_full_righttrials_bar (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset, names_right_trials, names_left_trials, legends{2} );

% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.55, 'a', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.27,'Time (s)', 'FontSize',7,'HorizontalAlignment','center');




%% Choice mode
flag_normalize_modes=1;
axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
hold on;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
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
k.trialtype_flag_right_full_nopresample_and_control_left=1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;

y_lims = [-0.6,1];
key_trial_type.trial_type_name='l_-1.6Full';

xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error_double_distractor (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,0);
% [xl, yl] =figure_plotModes2 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
%}
set(gca,'Ytick',[0 y_lims(2)]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'b', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Motor plan \nrobustness in ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
box off;
ylim([-0.4, 1]);
    


% %% Choice mode - right trial
% plot_r_flag=1;
% flag_normalize_modes=1;
% 
% key=[]; k=[];
% key.unit_quality = 'all';
% key.cell_type = 'Pyr';
% key.mode_weights_sign = 'all';
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.outcome='hit';
% key.mode_type_name = 'ChoiceMatched';
% % key.mode_type_name = 'Ramping Orthog.111';
% 
% mode_names_titles = { 'Choice'};
% 
% axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
% %Distractor full
% k=key;
% k.training_type = 'distractor';
% k.session_flag_full = 1;
% % k.trialtype_flag_left_and_control_right_nopresample = 1;
% k.trialtype_flag_right_full_nopresample_and_control_left=1;
% title1 = '';
% title2='';
% title3=[];
% rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11Revision * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
% xlabel_flag=1;
% ylabel_flag=1;
% y_lims = [-0.13,1.05];
% stim_legend_flag=1;
% [xl, yl] =figure_plotModes_double_distractors (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'b', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
%     'fontsize', 7, 'HorizontalAlignment','left');
% set(gca,'YLim',[-0.2 1.2], 'YTick',[0 1]);
% 
%     xlim([-2.8 0]);
    
    
    
    


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
rel_choice_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11Revision * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.13,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes_double_distractors (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca,'YLim',[-0.2 1.2], 'YTick',[0 1]);

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



%% Choice mode - right trial, presample

%% Choice mode - right trial
plot_r_flag=1;
flag_normalize_modes=1;

key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.outcome='response';
key.mode_type_name = 'Ramping';
% key.mode_type_name = 'Ramping Orthog.111';

mode_names_titles = { 'Ramping'};


plot_r_flag=1;
flag_normalize_modes=1;
k=[];
axes('position',[position_x1(4), position_y1(1), panel_width1, panel_height1]);
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
[xl, yl] =figure_plotModes_double_distractors (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca,'YLim',[-0.2 1.2], 'YTick',[0 1]);



%% Choice mode - right trial without sensory cue


key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.outcome='hit';
key.mode_type_name = 'ChoiceMatched';
% % key.mode_type_name = 'Ramping Orthog.111';
% key.mode_type_name = 'Ramping';

mode_names_titles = { 'Choice'};


plot_r_flag=1;
flag_normalize_modes=1;
k=[];
axes('position',[position_x1(5), position_y1(1), panel_width1, panel_height1]);
%Distractor full
k=key;
% k.training_type = 'distractor';
% k.session_flag_full = 1;
% k.session_flag_mini = 1;

k.trialtype_flag_control_left_and_right_and_no_audio_cue=1;
title1 = '';
title2='';
title3=[];
rel_choice_full = ( ((EXP.Session * EXP.SessionID) & (EXP.TrialName & 'trial_type_name="r_NoAudCue"')) * (ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphicRevision * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime) - ANL.ExcludeSession) & k ;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.13,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes_double_distractors (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims,  flag_normalize_modes, plot_r_flag, stim_legend_flag);
text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-2, yl(1)+diff(yl)*0.95, 'Delay', ...
    'fontsize', 7, 'HorizontalAlignment','left');
set(gca,'YLim',[-0.2 1.2], 'YTick',[0 1]);



if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);

end




