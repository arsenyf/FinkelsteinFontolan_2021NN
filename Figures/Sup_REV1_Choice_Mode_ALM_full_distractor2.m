function Sup_REV1_Choice_Mode_ALM_full_distractor2() % MATLAB R2017a
close all;

mode_type_name ='ChoiceMatched';

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Sup5_Choice_Mode_ALM_full_distractor';
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
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);

panel_width1=0.1;
panel_height1=0.09;
horizontal_distance1=0.13;
vertical_distance1=0.4;

position_x1(1)=0.12;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;

position_y1(1)=0.8;
position_y1(2)=position_y1(1)-vertical_distance1;
% position_y1(3)=position_y1(2)-vertical_distance1;
% position_y1(4)=position_y1(3)-vertical_distance1;
% position_y1(5)=position_y1(4)-vertical_distance1;


panel_width2=0.1;
panel_height2=0.09;
horizontal_distance2=0.15;
vertical_distance2=0.2;


position_x2(1)=0.05;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2*1.1;
position_x2(4)=position_x2(3)+horizontal_distance2;

position_y2(1)=0.6;
position_y2(2)=position_y2(1)-vertical_distance2;
% position_y2(3)=position_y2(2)-vertical_distance2;
% position_y2(4)=position_y2(3)-vertical_distance2;

Param = struct2table(fetch (ANL.Parameters,'*'));

unit_counter=0;








%% Left Hemisphere, Distractor-trained, Full Stimuli

% Cell 1
key_u.unit_uid=3719; %very good 324 % 1327 not good %3719 great
axes('position',[position_x1(1), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='A';
fn_plot_PSTH_Supp (Param, 'hit', 1, 1, [], 1, key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);
text(-1,50,'Distractor-trained mice, strong distractors','HorizontalAlignment','Left','FontSize',9,'fontweight','bold' )
text(-1.5,38,'Delay','FontSize',6);

% Cell 2
key_u.unit_uid=320; %367 %306 %320 good
axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='';
fn_plot_PSTH_Supp (Param, 'hit', 1, 1, [], 1, key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);


% Cell 3
key_u.unit_uid=296; %271 not good because it is not selective in the end
axes('position',[position_x1(3), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=0; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='';
fn_plot_PSTH_Supp (Param, 'hit', 1, 1, [], 1, key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);



%% Population

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


axes('position',[position_x2(1), position_y2(1), panel_width2, panel_height2]);
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
rel_choice_full =(EXP.Session * EXP.SessionID * (ANL.ProjTrialAverageBaseline11 & 'num_units_projected>0') * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.6,1];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error (rel_choice_full,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.2, 'B', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'FontSize',7,'Ytick',[ 0 1]);
text(-3,yl(1)+diff(yl)*1.45,sprintf('Population response,\n all cells'),'HorizontalAlignment','Left','FontSize',7)


% Negative weights
key.mode_weights_sign = 'negative';
axes('position',[position_x2(2), position_y2(1), panel_width2, panel_height2]);
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
rel_choice_full_negative =(EXP.Session * EXP.SessionID * (ANL.ProjTrialAverageBaseline11 & 'num_units_projected>0') * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
xlabel_flag=1;
ylabel_flag=1;
% y_lims = [-2.5,4];
y_lims = [-	1.4,2.2];
stim_legend_flag=1;
outcome='hit';
key_trial_type.trial_type_name=[];
line_style='-';
[xl, yl] =figure_plotModes_correct_or_error (rel_choice_full_negative,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, k, [],line_style,1);
% text(xl(1)-diff(xl)*0.6, yl(1)+diff(yl)*1.2, 'C', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'FontSize',7,'Ytick',[-1  0 1 2]);
% text(xl(1)-diff(xl)*0.6, yl(1)+diff(yl)*1.2, 'C', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



text(-3,yl(1)+diff(yl)*1.45,sprintf('Population response,\n left-preferring cells'),'HorizontalAlignment','left','FontSize',7)


%% Stim kinetics early delay
% Choice mode
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = mode_type_name;

k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_right_pure_and_early_delay_full_left = 1;
% k.trialtype_flag_left_right_pure_and_late_delay_full_left = 1;

k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel_choice_full =(EXP.Session * EXP.SessionID * (ANL.ProjTrialAverageBaseline11 & 'num_units_projected>0') * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.SessionGrouping * ANL.TrialTypeStimTime) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');




axes('position',[position_x2(3)*1.05, position_y2(1), panel_width2, panel_height2]);
hold on;
flag_normalize_modes=1;
% Regular mini

% Distractor full
%Trained
colr = legends{3}.colr;
% compute_stim_kinetics_modes4 ((rel_choice_trained & 'outcome="hit"'),  Param, colr, flag_normalize_modes, key);
outcome='miss';
 xdat = [0 0 0.4 0.4];
 sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
fill([0 + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
compute_stim_kinetics_modes5__revision_earlydelay (rel_choice_full, outcome, Param, colr, flag_normalize_modes, key);

xl=[0 0.8];
xlim(xl);
yl = [-0.12 0.12];
ylim(yl);
set(gca,'FontSize',7,'Ytick',[-0.1 0 0.1], 'Xtick',[0 xl(2)], 'XtickLabel',[0 xl(2)]);
text(xl(1)+diff(xl)*-0.5, yl(1)+diff(yl)*1.2, 'C', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time relative \n to distractor onset (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text ((xl(1)-diff(xl)*0.4), (yl(1) + diff(yl)*0.4), sprintf('Impact on\nChoice mode  (a.u.)'),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*1.15), sprintf('Distractor impact'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
% text(xl(1)+diff(xl)*1.3, yl(1)+diff(yl)*0.8,sprintf('Distractor\nnaive'),'Color', legends{1}.colr,'FontSize',7,'HorizontalAlignment','center');
% text(xl(1)+diff(xl)*1.3, yl(1)+diff(yl)*0.4,sprintf('Distractor\ntrained'),'Color', legends{3}.colr,'FontSize',7,'HorizontalAlignment','center');




%% Endpoints
colr=[];
colr{1}=[1 0 0];
colr{2}=[0 0 1];
numbins=linspace(-1.25,2.25,16);


Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};

min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};
min_num_trials=5;

smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.2;
t2=0;
tidx = time>t1 & time<=t2;



key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
key.unit_quality = 'ok or good';
% key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.subject_id=353936; key.session=5; %1,4,5 %5 maybe
%key.subject_id=365939; %key.session=3; %1,2,3,4 %3 good
%key.subject_id=365938; %key.session=4; %1,2,3,4 % 4 good
%key.subject_id=353938; %.session=4; %1,3,4,5,6 % 4 good; 1,5 ok

% key.is_outlier=0;
key.mode_type_name = mode_type_name;



rel = ( ANL.ProjTrialNormalizedMedianNormalized11Revision * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;

session_uid=unique(fetchn(rel,'session_uid'));

%  Control trials
%------------------------------------------
axes('position',[position_x2(1), position_y2(2), panel_width2, panel_height2]);
hold on;

k.trial_type_name='l';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',colr{1},'markeredgecolor',colr{1},'markerfacecolor',colr{1},'linewidth',1});

k.trial_type_name='r';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',colr{2},'markeredgecolor',colr{2},'markerfacecolor',colr{2},'linewidth',1});
xl = [numbins(1),numbins(end-1)];
xlim(xl);
yl=[0, nanmax([xmean1,xmean2])*1.2+eps];
ylim(yl);
% title ( (yl(1) + diff(yl)*1.15),(xl(1)+diff(xl)*0.5), sprintf('No distractor trials, \nEnd-delay points'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
view([90 -90])
xlabel('Choice mode (a.u.)','Fontsize', 7);
ylabel('Proportion of trials','Fontsize', 7);
title (sprintf('No-distractor trials\n\nEnd-delay points\n\n\n'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
% set(gca,'XTick',[0,1])

% subplot(2,2,2)
% hold on;
% 
% k.trial_type_name='l';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-r');
% 
% k.trial_type_name='r';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-b');


% Early Delay trials  - endpoints at mid delay
%------------------------------------------

dt = 0.8; % if we don't want to look at the end of delay
t1_temp=t1 - dt;
t2_temp=t2 - dt;
tidx = time>t1_temp & time<=t2_temp;

axes('position',[position_x2(2), position_y2(2), panel_width2, panel_height2]);
hold on;

k.trial_type_name='l_-1.6Full';
current_color = fetch1(ANL.TrialTypeGraphic & k,'trialtype_rgb');
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',current_color,'markeredgecolor',current_color,'markerfacecolor',current_color,'linewidth',1});

k.trial_type_name='l_-1.6Full';
current_color = [0.5 0.5 0.75];
k.outcome='miss';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',current_color,'markeredgecolor',current_color,'markerfacecolor',current_color,'linewidth',1});
xl = [numbins(1),numbins(end-1)];
xlim(xl);
yl=[0, nanmax([xmean1,xmean2])*1.2+eps];
ylim(yl);
title (sprintf('                                        Early-delay distractors trials\n\nMid-delay points\n\n\n'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
% xlabel('Choice mode (a.u.)','Fontsize', 7);
ylabel('Proportion of trials','Fontsize', 7);
view([90 -90]);
% set(gca,'XTick',[0,1])

% Early Delay trials  - endpoints at endpoint
%------------------------------------------

dt = 0; % if we don't want to look at the end of delay
t1_temp=t1 - dt;
t2_temp=t2 - dt;
tidx = time>t1_temp & time<=t2_temp;

axes('position',[position_x2(3), position_y2(2), panel_width2, panel_height2]);
hold on;

k.trial_type_name='l_-1.6Full';
current_color = fetch1(ANL.TrialTypeGraphic & k,'trialtype_rgb');
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',current_color,'markeredgecolor',current_color,'markerfacecolor',current_color,'linewidth',1});

k.trial_type_name='l_-1.6Full';
current_color = [0.5 0.5 0.75];
k.outcome='miss';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',current_color,'markeredgecolor',current_color,'markerfacecolor',current_color,'linewidth',1});
xl = [numbins(1),numbins(end-1)];
xlim(xl);
yl=[0, nanmax([xmean1,xmean2])*1.2+eps];
ylim(yl);
% xlabel('Choice mode (a.u.)','Fontsize', 7);
ylabel('Proportion of trials','Fontsize', 7);
title ( sprintf('\n\nEnd-delay points\n\n\n'),'Fontsize', 7,'VerticalAlignment','middle','HorizontalAlignment','center');
view([90 -90])
% set(gca,'XTick',[0,1])


annotation(figure1,'arrow',[0.310423280423281 0.341501322751323],...
    [0.449277777777778 0.448597883597884],'LineWidth',2,'HeadStyle','plain');



if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




