 function Sup_REV1_RightHemisphere() % MATLAB R2017a
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_RightHemisphere';


flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

legends{1}.colr = [0 1 0.5]; % Distractor naive mice -mini
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




%% Choice mode
flag_normalize_modes=1;
axes('position',[position_x3(1), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
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
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;

y_lims = [-0.6,1];
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
set(gca,'Ytick',[0 y_lims(2)]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Left ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
box off;

    




%% Choice mode

flag_normalize_modes=1;
axes('position',[position_x3(2), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
hold on;
key=[]; k=[];
% key.subject_id=353936; 
% key.subject_id=365935; 
% key.subject_id=365938; 
% key.subject_id=353938; 


% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'right';
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
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;

y_lims = [-2.05,1.05];
xlabel_flag=0;
ylabel_flag=0;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-1.6Full';
line_style='-';
[~, ~] =figure_plotModes_correct_or_error_right_hemisphere (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
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
[xl, yl] =figure_plotModes_correct_or_error_right_hemisphere (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,0);
% [xl, yl] =figure_plotModes2 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
%}
set(gca,'Ytick',[-1 0 1]);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'b', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Right ALM'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
box off;

    



if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




