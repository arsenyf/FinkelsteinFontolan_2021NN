 function Fig2() % MATLAB R2017a
close all;

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Fig2_ramping';
flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

legends{1}.colr = [0 1 0.5]; % Distractor naive mice -mini
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

%Graphics
%---------------------------------
figure1=figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);
set(gcf,'color',[1 1 1]);

panel_width1=0.1;
panel_height1=0.08;
horizontal_distance1=0.15;
vertical_distance1=0.165;

position_x1(1)=0.07;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;
position_x1(7)=position_x1(6)+horizontal_distance1*0.6;

position_y1(1)=0.85;
position_y1(2)=position_y1(1)-vertical_distance1*1;
position_y1(3)=position_y1(2)-vertical_distance1;





panel_width3=0.1;
panel_height3=0.12;
horizontal_distance3=0.19;
vertical_distance3=0.105;

position_x3(1)=0.17;
position_x3(2)=position_x3(1)+horizontal_distance3;
position_x3(3)=position_x3(2)+horizontal_distance3;
position_x3(4)=position_x3(3)+horizontal_distance3;
position_x3(5)=position_x3(4)+horizontal_distance3;
position_x3(6)=position_x3(5)+horizontal_distance3;

position_y3(1)=0.3;
position_y3(2)=position_y3(1)-vertical_distance3;
position_y3(3)=position_y3(2)-vertical_distance3;
position_y3(4)=position_y3(3)-vertical_distance3*1.1;



panel_width4=0.12;
panel_height4=0.13;
horizontal_distance4=0.125;
vertical_distance4=0.09;

position_x4(1)=0.1;
position_x4(2)=position_x4(1)+horizontal_distance4;
position_x4(3)=position_x4(2)+horizontal_distance4;
position_x4(4)=position_x4(3)+horizontal_distance4;

position_y4(1)=0.45;


Param = struct2table(fetch (ANL.Parameters,'*'));


% Behavior




%Expert on Mini distractors
%--------------------------------------
axes('position',[position_x1(3), position_y1(1), panel_width1, panel_height1]);
% axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & EPHYS.Unit  & 'training_type="distractor"' );
b_query = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining * (EXP.SessionTask & 'task="s1 stim"') & 'training_type="distractor"'  & 'task_protocol in (2,5,7,8,9)' & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"'));
num_sessions_mini_distractor_trained = numel(unique(fetchn(b_query, 'session_uid')))

clear trial_type_names  b
[trial_type_names, b] = fn_fetch_behav(b_query);
names_right_trials = {'r', 'r_-3.8Mini', 'r_-1.6Mini', 'r_-0.8Mini'};
% names_left_trials = {'l', 'l_-3.8Full','r', 'l_-1.6Full', 'l_-0.8Full'};
names_left_trials = {'l','l_-2.5Mini', 'l_-1.6Mini', 'l_-0.8Mini'};
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
plot_signif_offset=-7;
[xl,yl]=figure_plot_behav_distractor_mini (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset, names_right_trials, names_left_trials, legends{2} );
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.6, 'b', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% 



% Regular on Mini distractors
%--------------------------------------
% b_query2= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & EPHYS.Unit  & 'training_type="regular"' );
b_query2 = EXP.SessionID * ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'task="s1 stim"' & 'training_type="regular"'  & 'task_protocol in (2,5,7,8,9)' & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"')) ;
num_sessions_mini_distractor_naive = numel(unique(fetchn(b_query2, 'session_uid')))

clear trial_type_names  b
[trial_type_names, b] = fn_fetch_behav(b_query2);
names_right_trials = {'r', 'r_-3.8Mini', 'r_-1.6Mini', 'r_-0.8Mini'};
% names_left_trials = {'l', 'l_-3.8Mini','l_-2.5Mini', 'l_-1.6Mini', 'l_-0.8Mini'};
names_left_trials = {'l','l_-2.5Mini', 'l_-1.6Mini', 'l_-0.8Mini'};
x_r = [(-3.8), (-1.6), (-0.8)];
% x_l = [(-3.8),(-2.5), (-1.6), (-0.8)];
x_l = [(-2.5), (-1.6), (-0.8)];
%Performance
% Choosing which trial-types to display
%--------------------------------------
clear behav_param behav_param_mean behav_param_signif trn_r trn_l y_r y_l
behav_param = b.prcnt_hit_outof_noignore_noearly;
[behav_param_mean, behav_param_signif, trn_r, trn_l, y_r, y_l ] = fn_choose_behav_trials(behav_param,trial_type_names, names_right_trials, names_left_trials);
% Plotting Performance
%-------------------------------------------
plot_signif_offset=+5;
[xl,yl]=figure_plot_behav_regular_mini (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset,['             '],['          '], legends{1} );
% text(xl(1)-diff(xl)*0.37, yl(1)+diff(yl)*1.6, 'a', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% 

%Expert on Full distractors
%--------------------------------------
axes('position',[position_x1(3), position_y1(2), panel_width1, panel_height1]);
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6,3,2,5,7,8,9)' & 'training_type="distractor"' & 'session_comment="good behavior"');
% b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)'  & 'training_type="distractor"' );
b_query = EXP.SessionID *ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'training_type="distractor"'   & 'task="s1 stim"' & 'task_protocol in (4,6)'   & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"')) ;
num_sessions_strong_distractor_trained = numel(unique(fetchn(b_query, 'session_uid')))

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
plot_signif_offset=+7;
[xl,yl]=figure_plot_behav_distractor_full (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset, names_right_trials, names_left_trials, legends{3} );
% text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.6, 'c', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



%distractor trained, 
%pure r performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="r"' & 'task_protocol in (4,6,2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="l"' & 'task_protocol in (4,6,2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))


%distractor naive, 
%pure r performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="r"' & 'task_protocol in (2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="l"' & 'task_protocol in (2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))


%% Inputs to ALM
axes('position',[position_x3(1), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='miss';
key.mode_type_name = 'Stimulus Orthog.111';
mode_names_titles = { 'Stimulus'};
% key.subject_id=353936; key.session=5; %1,4,5 %5 maybe
% key.subject_id=365939; key.session=3; %1,2,3,4 %3 good
%  key.subject_id=365938; key.session=4; %1,2,3,4 % 4 good
% key.subject_id=353938; key.session=4; %1,3,4,5,6 % 4 good; 1,5 ok
% key.subject_id=353938;

plot_r_flag=1;
%Distractor full
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_input_full =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"' ) ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.2,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes2 (rel_input_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
set(gca,'Xtick',[-2 0],'Ytick',[0 1]);
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('No distractor \nsuppression in ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'E', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


%% Choice mode
flag_normalize_modes=1;
axes('position',[position_x3(2), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = 'Ramping Orthog.111';
mode_names_titles = { 'Ramping'};
% key.subject_id=353936; key.session=5; %1,4,5 %5 maybe
% key.subject_id=365939; key.session=3; %1,2,3,4 %3 good
%  key.subject_id=365938; key.session=4; %1,2,3,4 % 4 good
% key.subject_id=353938; key.session=4; %1,3,4,5,6 % 4 good; 1,5 ok
% key.subject_id=353938; 
 
%Distractor full
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
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;


xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.4,1];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
% [xl, yl] =figure_plotModes2 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
%}
set(gca,'Ytick',[0 y_lims(2)]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'F', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Motor plan \nrobustness in ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )


% axes('position',[position_x3(3), position_y3(1), panel_width3, panel_height3]);
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_left_and_right_no_distractors = 1;
title1 = '';
title2='';
% title3=[];
xlabel_flag=0;
ylabel_flag=0;
line_style='-';
rel_temp =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime)  & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;
stim_legend_flag=0;
sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
xdat = [0 0 0.4 0.4];
% fill([-1.6 + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
% [~, ~] =figure_plotModes_correct_or_error (rel_temp ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);

xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-1.6Full';
line_style=':';
[~, ~] =figure_plotModes_correct_or_error (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[0 y_lims(2)]);
% text(xl(1)-diff(xl)*0.4 , yl(1)+diff(yl)*1.25, 'h', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
%                 text(-0.5, yl(2)*1.6, sprintf('....\nError\ntrials'), 'Color', [1 0.5 0.3], 'FontSize',7,'HorizontalAlignment','center')
box off;




if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




