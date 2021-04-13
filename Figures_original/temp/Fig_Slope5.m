function Fig_Slope5() % MATLAB R2017a
close all;

mode_type_name ='LateDelay';

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Fig_Slope5';
flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

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

position_y1(1)=0.785;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1;





panel_width3=0.2;
panel_height3=0.2;
horizontal_distance3=0.3;
vertical_distance3=0.105;

position_x3(1)=0.07;
position_x3(2)=position_x3(1)+horizontal_distance3;
position_x3(3)=position_x3(2)+horizontal_distance3;
position_x3(4)=position_x3(3)+horizontal_distance3*1.5;
position_x3(5)=position_x3(4)+horizontal_distance3;
position_x3(6)=position_x3(5)+horizontal_distance3;

position_y3(1)=0.7;
position_y3(2)=position_y3(1)-vertical_distance3;
position_y3(3)=position_y3(2)-vertical_distance3;
position_y3(4)=position_y3(3)-vertical_distance3*1.1;




Param = struct2table(fetch (ANL.Parameters,'*'));




%% Choice mode
flag_normalize_modes=1;
axes('position',[position_x3(1), position_y3(1), panel_width3, panel_height3]);
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
% key.subject_id=353936; key.session=1; %1,4,5 %5 maybe
%key.subject_id=365939; key.session=3; %1,2,3,4 %3 good
% key.subject_id=365938; key.session=4; %1,2,3,4 % 4 good
% key.subject_id=353938; key.session=4; %1,3,4,5,6 % 4,5, good

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
% rel_choice_full =(((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverage3 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime ) )) & k &  (ANL.IncludeSession & 'good_session_flag=1') - ANL.ExcludeSession;
rel_choice_full =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline7 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') -  ANL.ExcludeSession;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.15,1];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
% [xl, yl] =figure_plotModes2 (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
%}
set(gca,'Ytick',[y_lims(1) y_lims(2)]);
% text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.25, 'g', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(-3,2,sprintf('Robustness of choice mode in ALM'),'HorizontalAlignment','Left','FontSize',7,'fontweight','bold' )


axes('position',[position_x3(2), position_y3(1), panel_width3, panel_height3]);
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_left_and_right_no_distractors = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
xlabel_flag=0;
ylabel_flag=0;
line_style='-';
% rel_temp =(((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverage3  * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime)  )) & k &   (ANL.IncludeSession & 'good_session_flag=1') - ANL.ExcludeSession;
rel_temp =(EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline7 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime)  & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') -  ANL.ExcludeSession;

stim_legend_flag=0;
sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
xdat = [0 0 0.4 0.4];
fill([-1.6 + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
[~, ~] =figure_plotModes_correct_or_error (rel_temp ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);

xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-1.6Full';
line_style=':';
[~, ~] =figure_plotModes_correct_or_error (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[ y_lims(1) y_lims(2)]);
% text(xl(1)-diff(xl)*0.4 , yl(1)+diff(yl)*1.25, 'h', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
                text(-0.5, yl(2)*1.6, sprintf('....\nError\ntrials'), 'Color', [1 0.5 0.3], 'FontSize',7,'HorizontalAlignment','center')
box off;

xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-0.8Full';
line_style=':';
[~, ~] =figure_plotModes_correct_or_error (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[ y_lims(1) y_lims(2)]);
% text(xl(1)-diff(xl)*0.4 , yl(1)+diff(yl)*1.25, 'h', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
%                 text(-0.5, yl(2)*1.6, sprintf('....\nError\ntrials'), 'Color', [1 0.5 0.3], 'FontSize',7,'HorizontalAlignment','center')
box off;



y_lims = [-0.15,1];

axes('position',[position_x3(3), position_y3(1), panel_width3, panel_height3*1.25]);
outcome='hit';
key_trial_type.trial_type_name=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_left_and_right_no_distractors = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
xlabel_flag=0;
ylabel_flag=0;
line_style='-';
% rel_temp =(((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverage3  * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime)  )) & k &   (ANL.IncludeSession & 'good_session_flag=1') - ANL.ExcludeSession;
rel_temp =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline7 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime)) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') -  ANL.ExcludeSession;

stim_legend_flag=0;
% sz = [-200 200];
% ydat = [sz(1) sz(2) sz(2) sz(1)];
% xdat = [0 0 0.4 0.4];
% fill([-1.6 + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
[~, ~] =figure_plotModes_correct_or_error_timeshifted (rel_temp ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);

xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-1.6Full';
line_style=':';
[xl, yl] =figure_plotModes_correct_or_error_timeshifted (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[0 1]);
% text(xl(1)-diff(xl)*0.4 , yl(1)+diff(yl)*1.25, 'h', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
                text(-1.5, y_lims(2)*1.5, sprintf('....  Early Delay\n     Error trials'), 'Color', [1 0.5 0.3], 'FontSize',7,'HorizontalAlignment','center')
box off;



    xlabel_flag=1;
ylabel_flag=1;
stim_legend_flag=0;
outcome='miss';
key_trial_type.trial_type_name='l_-0.8Full';
line_style=':';
[xl, yl] =figure_plotModes_correct_or_error_timeshifted (rel_choice_full ,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k,[],line_style,0);
set(gca,'Ytick',[0 1]);

    
   set(gca,'XLim',[ -2.5 -1],'Xtick',[ -2.5 -1],'XtickLabel',[ 0 1.5],'FontSize',6);
% xlabel('Time from stimulus (s)');
    text(xl(1)+diff(xl)*0.35, yl(1)-diff(yl)*0.25,'Time from stimulus onset (s)', 'FontSize',7,'HorizontalAlignment','center');
 
% %% Slopes
%     
% % Choice mode
% % axes('position',[position_x3(2), position_y3(1), panel_width3, panel_height3]);
% key=[]; k=[];
% % key.unit_quality = 'ok or good';
% key.unit_quality = 'all';
% key.cell_type = 'Pyr';
% key.mode_weights_sign = 'all';
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% % key.outcome='hit';
% key.mode_type_name = mode_type_name;
% 
% mode_names_titles = { 'Choice'};
% % key.subject_id=353936;
% % key.subject_id=365939;
% % key.subject_id=365938;
% % key.subject_id=353938;
% 
% %Distractor full
% plot_r_flag=1;
% k=[];
% k=key;
% k.training_type = 'distractor';
% 
% k.session_flag_full = 1;
% 
% 
% k.trial_type_name='r';
% k.outcome='hit';
% 
% 
% time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
% psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
% smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
% smooth_bins=ceil(smooth_time/psth_time_bin);
% 
% 
% % rel  = (ANL.ProjTrialAdaptiveAverageBaseline*EXP.SessionTraining* ANL.SessionGrouping *EXP.SessionID  & k)- ANL.ExcludeSession &  (ANL.IncludeSession & 'good_session_flag=1') ;
% rel  = (ANL.ProjTrialAverageBaseline3*EXP.SessionTraining* ANL.SessionGrouping *EXP.SessionID  & k)& (ANL.IncludeSessionSelectivity2 & 'num_sample_selective_units>=0') ;
% 
% proj = cell2mat(fetchn(rel,'proj_average','ORDER BY session_uid'));
% 
% axes('position',[position_x3(1), position_y3(3), panel_width3, panel_height3]);
% t1=-2.5;
% t2=-1.5;
% twind=0.25;
% for i_p = 1:1:size(proj,1)
%     hold on
%     y=smooth(proj(i_p,:),smooth_bins);
% %     y=y - mean(y(time>=-4.5 & time<-3));
%     y1_max(i_p) = max(y(time>=-4.5 & time<0));
%         y=y/ y1_max(i_p);
%     y1_all(i_p,:)=y;
%     y1= mean(y(time>=t1 & time<t1+twind));
%     y2= mean(y(time>=t2 & time<t2+twind));
%     slope1(i_p)=y2-y1;
%     plot(time +2.5,y,'-b','LineWidth',2)
% %     xlim([0,2.5]);
% end
% 
% k.trial_type_name='l_-1.6Full';
% k.outcome='miss';
% rel  = (ANL.ProjTrialAverageBaseline3*EXP.SessionTraining* ANL.SessionGrouping *EXP.SessionID  & k) & (ANL.IncludeSessionSelectivity2 & 'num_sample_selective_units>=0') ;
% % trials = cell2mat(fetchn(rel & 'outcome !="ignore"','proj_trial'));
% 
% tshift=0.9;
% 
% proj = cell2mat(fetchn(rel,'proj_average','ORDER BY session_uid'));
% for i_p = 1:1:size(proj,1)
%     hold on
%     y=smooth(proj(i_p,:),smooth_bins);
% %     y=y - mean(y(time>=-4.5 & time<-3));
%         y=y/ y1_max(i_p);
%     y2_all(i_p,:)=y;
% 
%     y1= mean(y(time>=(t1+tshift) & time<(t1+twind+tshift)));
%     y2= mean(y(time>=(t2+tshift) & time<(t2+twind+tshift)));
%         slope2(i_p)=y2-y1;
%     plot(time-tshift  +2.5,y,'-r', 'Color', [1 0.5 0.3],'LineWidth',2)
% %     xlim([0,2.5]);
% end
% 
%     plot(time +2.5,mean(y1_all,1),'-c','LineWidth',5)
% 
%     plot(time-tshift +2.5,mean(y2_all,1),'-m','LineWidth',5)
% 
% [h,~]=ttest(slope1,slope2)
% 
% % mean(slope1)
% % mean(slope2)
% 
% % xlim([0 1.6])
% set(gca,'XLim',[0 1.5],'Xtick',[ 0 0.5 1 1.5], 'FontSize',7);
% 
% xlabel('Time from stimulus (s)', 'FontSize',18,'HorizontalAlignment','center', 'FontSize',7);
% ylabel('Choice Mode (a.u.)', 'FontSize',18,'HorizontalAlignment','center', 'FontSize',7)
% 
% 
% 
% axes('position',[position_x3(4), position_y3(3), panel_width3, panel_height3]);
% y_mean(1)=nanmean(slope1);
% y_stem(1)=nanstd(slope1)./sqrt(numel(slope1));
% 
% y_mean(2)=nanmean(slope2);
% y_stem(2)=nanstd(slope2)./sqrt(numel(slope2));
% 
% % 
% % ym=[y_mean(1),y_mean(end)];
% % ys=[y_stem(1),y_stem(end)];
% 
% hold on;
% xl=[0 5.5];
% yl=[0 0.5];
% bar([1],[y_mean(1)],'facecolor',[ 0 0 1])
% bar([2],[y_mean(2)],'facecolor',[1 0.5 0.3])
% errorbar([1 2],y_mean,  y_stem,'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',12,'clipping','off');
% set(gca,'Xlim',xl,'Ylim',yl,'Xtick',[1 2],'XtickLabel',{'Sample     ','  EarlyDelay'},'FontSize',7,'Ytick',[0 0.5]);
% 
% text(2, 0.57, '**', ...
%     'fontname', 'helvetica', 'fontweight', 'bold','HorizontalAlignment','center','FontSize',12);
% xlim([0.5,2.5]);
% % ylim([0,0.6]);
% ylabel('Slope (a.u.)', 'FontSize',18,'HorizontalAlignment','center','FontSize',7)
% 
%     
%     
%     
%     
%     
%     
%     
%     
if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename mode_type_name];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
savefig(figure_name_out)


end




