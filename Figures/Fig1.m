function Fig1() % MATLAB R2017a
close all;



%Graphics
%---------------------------------
figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 -5 23*1.2 25*1.4]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 0 0 0]);
set(gcf,'color',[1 1 1]);


panel_width1=0.11;
panel_height1=0.09;
horizontal_distance1=0.14;
vertical_distance1=0.11;

panel_width2=0.055;
panel_height2=0.06;
horizontal_distance2=0.07;
vertical_distance2=0.082;

position_x1(1)=0.06;
position_x1(2)=position_x1(1)+horizontal_distance1*1.2;
position_x1(3)=position_x1(2)+horizontal_distance1*1.1;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;
position_x1(7)=position_x1(6)+horizontal_distance1*0.6;

position_y1(1)=0.85;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1;

position_x2(1)=0.07;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2*1.2;
position_x2(4)=position_x2(3)+horizontal_distance2;
position_x2(5)=position_x2(4)+horizontal_distance2;
position_x2(6)=position_x2(5)+horizontal_distance2*0.6;

position_y2(1)=0.63;
position_y2(2)=position_y2(1)-vertical_distance2;
position_y2(3)=position_y2(2)-vertical_distance2*1.3;
position_y2(4)=position_y2(3)-vertical_distance2;


horizontal_distance3=0.065;
position_x3(1)=0.51;
position_x3(2)=position_x3(1)+horizontal_distance3;
position_x3(3)=position_x3(2)+horizontal_distance3;
position_x3(4)=position_x3(3)+horizontal_distance3*1.1;
position_x3(5)=position_x3(4)+horizontal_distance3*1.3;


Param = struct2table(fetch (ANL.Parameters,'*'));


%% Performance basic task



% Distractor Naive
rel = EXP.Session & (EXP.SessionTraining * (EXP.SessionTask & 'task="s1 stim"') & 'training_type="regular"'  & 'task_protocol in (2,5,7,8,9)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"');
%pure r performance
x= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="r"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
mean(x)
std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="l"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
x=100-x;
mean(x)
std(x)/sqrt(numel(x))

% Distractor trained
rel = EXP.Session & (EXP.SessionTraining * (EXP.SessionTask & 'task="s1 stim"') & 'training_type="distractor"'  & 'task_protocol in (4,6,2,5,7,8,9)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"');
%pure r performance
x= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="r"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
mean(x)
std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="l"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
x=100-x;
mean(x)
std(x)/sqrt(numel(x))


axes('position',[position_x2(1), position_y2(3), panel_width2*0.8, panel_height2*0.75]);
%% Distractor Naive beyavior
rel = EXP.Session & ((EXP.SessionTraining &'training_type="distractor"') * (EXP.SessionTask & 'task="s1 stim"')  & 'task_protocol in (4,6,2,5,7,8,9)') & (ANL.SessionBehavPerformance   & 'trial_type_name="r"') & (ANL.SessionBehavPerformance & 'trial_type_name="l"');
%pure r performance
x1= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="r"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
bmean(1)=mean(x1)
bstem(1)=std(x1)/sqrt(numel(x))
%pure l performance
x2= fetchn(ANL.SessionBehavPerformance*EXP.SessionID  & rel & 'trial_type_name="l"','prcnt_hit_outof_noignore_noearly','ORDER BY session_uid');
x2=100-x2;
bmean(2)=mean(x2)
bstem(2)=std(x2)/sqrt(numel(x2))

hold on;
xl=[0.5 2.5];
yl=[0 100];
bar([1],[bmean(2)],'facecolor','None','edgecolor',[ 1 0 0])
errorbar([1 ],[bmean(2)],  [bstem(2)],'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',8);
bar([2],[bmean(1)],'facecolor','None','edgecolor',[ 0 0 1]);
errorbar([2 ],[bmean(1)],  [bstem(1)],'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',8);
set(gca,'Xlim',xl,'Ylim',yl,'Xtick',[1 2],'XtickLabel',{'No stimulus','Stimulus '},'Ytick',yl,'FontSize',6);
xtickangle(30)
plot([1+(0.5-rand(numel(x2),1))/2],x2,'.r','MarkerSize',1)
plot([2+(0.5-rand(numel(x1),1))/2],x1,'.b','MarkerSize',1)
    text(xl(1)-diff(xl)*0.3,yl(1)+diff(yl)/2,sprintf('Lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.2, 'C', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

% text(xl(1)+diff(xl)*0.2, yl(1)-diff(yl)*0.3,sprintf('Distractor\nnaive'),'Color', legends{1}.colr,'FontSize',7,'HorizontalAlignment','center');
% text(xl(1)+diff(xl)*0.8, yl(1)-diff(yl)*0.3,sprintf('Distractor\ntrained'),'Color', legends{3}.colr,'FontSize',7,'HorizontalAlignment','center');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'Distractors at Late Delay','FontSize',7,'HorizontalAlignment','center','Color',late_delay_colr);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.2, 'F', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(2, 47, '***', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold','HorizontalAlignment','center');
% text(xl(1)-diff(xl)*0.25,yl(1)+diff(yl)*0.45,sprintf('\\Delta response  lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');



rel=[];

%% Raster plots and PSTHs
rel.PSTH_l = (EPHYS.Unit * EPHYS.UnitCellType * ANL.PSTHAverage & ANL.IncludeUnit2 & 'outcome="hit"' & 'trial_type_name="l"') ;
rel.PSTH_r = (EPHYS.Unit * EPHYS.UnitCellType * ANL.PSTHAverage & ANL.IncludeUnit2 & 'outcome="hit"' & 'trial_type_name="r"');

rel.spikes_l = ANL.TrialSpikesGoAligned * EPHYS.Unit * EPHYS.UnitPosition * EXP.BehaviorTrial * EXP.TrialName & ANL.IncludeUnit2 &  'outcome="hit"' & 'early_lick="no early"' & 'trial_type_name="l"' ;
rel.spikes_r = ANL.TrialSpikesGoAligned * EPHYS.Unit * EPHYS.UnitPosition  * EXP.BehaviorTrial * EXP.TrialName & ANL.IncludeUnit2 & 'outcome="hit"' & 'early_lick="no early"' & 'trial_type_name="r"';


%%vS1
k.unit_uid=1688; x=1; y=1; flag_xlable=0; flag_xlable2=1; flag_ylable=1; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 1) %1001 3172 975
k.unit_uid=4915; x=2; y=1; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 2) %2122, 2097
k.unit_uid=2124; x=3; y=1; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 3)
k.unit_uid=2143; x=4; y=1; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 4) %2260, 4879

%%Left ALM
k.unit_uid=1811; x=1; y=2; flag_xlable=1; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 5)
k.unit_uid=2018; x=2; y=2; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 6) %1915, 2644, 4020, 2018
k.unit_uid=3690; x=3; y=2; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 7) %3987 2717 2015, 2723
k.unit_uid=1314; x=4; y=2; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 8) %   204, 1125, 1309           2402, 2733, 2695, 2655, 2331,2695, 4526, 4457, 2750, 2043, 1945, 1871, 1844



key=[];


%% Selectivity

% Left vS1
key.brain_area = 'vS1';
key.hemisphere = 'left';
% key.training_type = 'all';
key.cell_type = 'Pyr';
axes('position',[position_x2(6), position_y2(1), panel_width2*1.2, panel_height2]);
labels_flag=0;
[xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);

% text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.25, ['{\color[rgb]{0.75 0.75 0}Selectivity ' ...
%     '\color{black}= '...
%     '\color{blue}Right'...
%         '\color{black} - '...
%     '\color{red}Left}'],'FontSize',7);
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.25, [
    '\color{black}= '...
    '\color{blue}Right'...
        '\color{black} - '...
    '\color{red}Left}'],'FontSize',7);

% Trial label
x_sin = 0:0.01:pi;
y_mini = repmat(sin(x_sin),1); % mini
y_full = repmat(sin(x_sin),4); % full
factor=diff(yl)/8;
colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
plot(linspace(-2.5, -2.1, 4*numel(x_sin)),y_full*(factor)+yl(2)*1.02,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
% factor1=1+0.1*(diff(yl)/yl(2));
% factor2=1+0.025*(diff(yl)/yl(2));
% time1=-2.5;
% time2=-2.1;
% colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
% plot([time1, time2],[yl(2)*factor1,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
% plot([time1, time1],[yl(2)*factor2,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
% plot([time2, time2],[yl(2)*factor1,yl(2)*factor2],'Color',colr{1},'LineWidth',1,'Clipping','off')


% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.2, ['Selectivity {\color(blue)R \color(red) L'], ...
%     'fontsize', 7,'HorizontalAlignment','center','Color',[0.5 1 0],'FontWeight','bold');
text(-1, yl(1)+diff(yl)*1.0, 'Delay', ...
    'fontsize', 6,'HorizontalAlignment','center');
text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*1.1, 'E', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)-diff(xl)*0.2, yl(1)+diff(yl)*0.4,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);

key=[];
% Left ALM
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.training_type = 'regular';
key.cell_type = 'Pyr';
axes('position',[position_x2(6), position_y2(2), panel_width2*1.2, panel_height2]);
labels_flag=1;
[xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);
text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*1.05, 'F', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.25,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
text(xl(1)-diff(xl)*0.2, yl(1)+diff(yl)*0.4,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);

% % Right ALM
% key.brain_area = 'ALM';
% key.hemisphere = 'right';
% key.training = 'regular';
% key.cell_type = 'Pyr';
% axes('position',[position_x2(6), position_y2(3), panel_width2*1.1, panel_height2]);
% labels_flag=1;
% [xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);
% text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.3,'Time (s)', 'FontSize',7,'HorizontalAlignment','center');
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*0.4,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
% text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*1.05, 'i', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

%% SVM Decoder
key=[]; k=[];

key.flag_include_distractor_trials=1;
% key.training_type ='regular';
rel=ANL.SVMdecoderSensoryMotor2 * ANL.SessionPosition * EXP.SessionTraining & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
t = fetch1(rel,'time_vector_svm', 'LIMIT 1');

% Sensory only
key.sensory_or_motor='sensory';
smooth_flag=1;
legend_flag=0;
panel_label='G';
axes('position',[position_x3(1), position_y2(1), panel_width2*1.2, panel_height2]);
svm_performance = fn_fetch_svm_performance(key,rel, smooth_flag);
yl=[50 100];
figure_plot_svm(svm_performance,t,legend_flag,key,panel_label,yl);

% % Sensory only
% key.sensory_or_motor='sensory';
% smooth_flag=1;
% legend_flag=0;
% axes('position',[position_x3(2)+0.005, position_y2(3)+0.015, panel_width2*0.6, panel_height2*0.8]);
% svm_performance = fn_fetch_svm_performance(key,rel, smooth_flag);
% figure_plot_svm_normalized(svm_performance,t,legend_flag,key);

% Motor only
key.sensory_or_motor='motor';
smooth_flag=1;
legend_flag=1;
panel_label='';
axes('position',[position_x3(1), position_y2(2), panel_width2*1.2, panel_height2]);
svm_performance = fn_fetch_svm_performance(key,rel, smooth_flag);
yl=[50 75];
figure_plot_svm(svm_performance,t,legend_flag,key, panel_label,yl);

% rel=ANL.SVMdecoder * ANL.SessionPosition * EXP.SessionTraining * ANL.IncludeSession - ANL.ExcludeSession;
% % All trials
% key.sensory_or_motor=[];
% smooth_flag=0;
% t = fetch1(rel,'time_vector_svm', 'LIMIT 1');
% legend_flag=1;
% axes('position',[position_x2(1), position_y2(4), panel_width2, panel_height2]);
% svm_performance = fn_fetch_svm_performance(key,rel, smooth_flag);
% figure_plot_svm(svm_performance,t,legend_flag,key);

% rel=ANL.SVMdecoderSensoryMotor * ANL.SessionPosition * EXP.SessionTraining * ANL.IncludeSession - ANL.ExcludeSession;




%% SVM Decoder Time
key=[]; k=[];
% key.flag_include_distractor_trials=1;
% rel=ANL.SVMdecoderTime * ANL.SessionPosition * EXP.SessionTraining * ANL.IncludeSession - ANL.ExcludeSession;
% t = fetch1(rel,'time_vector_svm', 'LIMIT 1');
% % key.training_type ='regular';
% 
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.sensory_or_motor = '';
% label_flag=1;
% last_label=0;
% c_lims=[50 100];
% axes('position',[position_x2(3)+0.03, position_y2(4), panel_width2, panel_height2]);
% svm_performance_mat = (fetchn(rel & key,'svm_performance_mean_time_mat'));
% time_mat=[];
% for i=1:1:size(svm_performance_mat,1)
%     time_mat(i,:,:)=svm_performance_mat{i};
% end
% time_mat = 100*squeeze(mean(time_mat,1));
% figure_plot_svm_time_rotation(t, time_mat, position_x2(4)+0.03, position_y2(4), panel_width2, panel_height2, label_flag, c_lims, last_label, key);
% xl=[-3.2 1.5];
% yl=[-3.2 1.5];
% text(xl(2)+diff(xl)*1, yl(2)+diff(yl)*0.25,'ALM left','FontSize',7,'Color',[1 0 1] );
% 
% % freezeColors;


% key=[]; k=[];
% key.flag_include_distractor_trials=1;
% rel=ANL.SVMdecoderSensoryMotorTime * ANL.SessionPosition * EXP.SessionTraining;
% t = fetch1(rel,'time_vector_svm', 'LIMIT 1');
% % key.training_type ='all';
% 
% key.brain_area = 'ALM';
% key.hemisphere = 'left';
% key.sensory_or_motor = 'sensory';
% label_flag=1;
% last_label=0;
% c_lims=[50 75];
% axes('position',[position_x3(4)+0.03, position_y2(3), panel_width2*1.25, panel_height2*1.25]);
% svm_performance_mat = (fetchn(rel & key,'svm_performance_mean_time_mat'));
% time_mat=[];
% for i=1:1:size(svm_performance_mat,1)
%     time_mat(i,:,:)=svm_performance_mat{i};
% end
% time_mat = 100*squeeze(mean(time_mat,1));
% figure_plot_svm_time_rotation(t, time_mat, position_x3(4)+0.035, position_y2(3), panel_width2*1.15, panel_height2*1.15, label_flag, c_lims, last_label, key);
% % freezeColors;
% 
% key.sensory_or_motor = 'motor';
% label_flag=0;
% last_label=1;
% c_lims=[50 75];
% axes('position',[position_x3(5)+0.04, position_y2(3), panel_width2*1.25, panel_height2*1.25]);
% svm_performance_mat = (fetchn(rel & key,'svm_performance_mean_time_mat'));
% time_mat=[];
% for i=1:1:size(svm_performance_mat,1)
%     time_mat(i,:,:)=svm_performance_mat{i};
% end
% time_mat = 100*squeeze(mean(time_mat,1));
% figure_plot_svm_time_rotation(t, time_mat, position_x3(5)+0.046, position_y2(3), panel_width2*1.15, panel_height2*1.16, label_flag, c_lims, last_label, key);
% % freezeColors;

toc
if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end

figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end



