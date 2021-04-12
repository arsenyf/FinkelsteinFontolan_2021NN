function Fig4_low_vs_high_ramping_v2_decoded_as_correct() % MATLAB R2017a
close all;
tic
dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Fig4_low_vs_high_ramping_decoded_as_correct';
flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

legends{1}.colr = [0 0.4 0.5]; % Distractor naive mice - mini
legends{2}.colr = [0.3 0.5 0.3]; % Distractor trained mice - mini
legends{1}.title_label='Distractor-naive';
legends{2}.title_label='Distractor-trained';
legends{1}.title_offset=10;
legends{2}.title_offset=0;

%Graphics
%---------------------------------
figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);
set(gcf,'color',[1 1 1]);

panel_width1=0.07;
panel_height1=0.08;
horizontal_distance1=0.14;
vertical_distance1=0.15;

position_x1(1)=0.1;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;


position_y1(1)=0.8;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1*0.9;
position_y1(4)=position_y1(3)-vertical_distance1;

Param = struct2table(fetch (ANL.Parameters,'*'));



%% Binned switch trials - distractor-naive
early_delay_colr=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.mode_type_name = 'Ramping Orthog.1';
key.trial_decoded_type='correct';

axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
k=[];
k=key;
k.training_type = 'regular';

condition = 'mini';
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

k.trial_type_name='l_-1.6Mini';
% rel_Switch = ( ANL.SwitchProbabilityHighvsLow555 * EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping *  ANL.IncludeSession - ANL.ExcludeSession ) & k & (EXP.SessionTask &'task="s1 stim"');
rel_Switch = ( ANL.SwitchProbabilityHighvsLow555* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping) & k & (EXP.SessionTask &'task="s1 stim"') & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');

switch_prob = cell2mat(fetchn(rel_Switch,'switch_prob' ,'ORDER BY session_uid'));
normalized_proj_bins =  cell2mat(fetchn(rel_Switch,'normalized_proj_bins' ,'ORDER BY session_uid'));
hold on;
switch_prob1 = switch_prob;
x=nanmedian(normalized_proj_bins);
y_mean=nanmedian(switch_prob1);
y_stem=nanstd(switch_prob1)./sqrt(size(switch_prob1,1));

shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',early_delay_colr,'markeredgecolor',early_delay_colr,'markerfacecolor',early_delay_colr,'linewidth',1});
xl=[0 1];
yl=[0 40];
xlim(xl);
ylim(yl);
set(gca,'FontSize',7,'Xtick',[0 0.5 1],'Ytick',yl);
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.3, sprintf('%s \n weak distractors    ', legends{1}.title_label),'FontSize',7,'Color',legends{1}.colr,'HorizontalAlignment','center','fontweight','bold');
text(xl(1)+diff(xl)*-0.45, yl(1)+diff(yl)*0.4,sprintf('\\Delta probability\n lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*-0.7, yl(1)+diff(yl)*1.4, 'i', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


[h,p]=ttest2(switch_prob(:,1),switch_prob(:,end))


%% Binned switch trials - distractor-trained
axes('position',[position_x1(2), position_y1(3), panel_width1, panel_height1]);
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
rel_Switch = ( ANL.SwitchProbabilityHighvsLow555* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping ) & k & (EXP.SessionTask &'task="s1 stim"') & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
switch_prob = cell2mat(fetchn(rel_Switch,'switch_prob' ,'ORDER BY session_uid'));
normalized_proj_bins =  cell2mat(fetchn(rel_Switch,'normalized_proj_bins' ,'ORDER BY session_uid'));
hold on;
switch_prob1 =  switch_prob;
x=nanmedian(normalized_proj_bins);
y_mean=nanmedian(switch_prob1);
y_stem=nanstd(switch_prob1)./sqrt(size(switch_prob1,1));

shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',early_delay_colr,'markeredgecolor',early_delay_colr,'markerfacecolor',early_delay_colr,'linewidth',1});
xl=[0 1];
yl=[0 45];
xlim(xl);
ylim(yl);
set(gca,'FontSize',7,'Xtick',[0 0.5 1],'Ytick',yl);
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.4,sprintf('Ramping before \n distractor (a.u.)', legends{2}.title_label),'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.6, sprintf('%s \n strong distractors    ', legends{2}.title_label),'FontSize',7,'Color',legends{2}.colr,'HorizontalAlignment','center','fontweight','bold');
text(xl(1)+diff(xl)*-0.4, yl(1)+diff(yl)*0.5,sprintf('\\Delta probability\n lick right (%%)'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');



[h,p]=ttest2(switch_prob(:,1),switch_prob(:,end))

% Cuzick's test
values=[switch_prob(:,1)',switch_prob(:,2)',switch_prob(:,3)'];
groups=[1*ones(1,length(switch_prob(:,1)')) ,2*ones(1,length(switch_prob(:,1)')) , 3*ones(1,length(switch_prob(:,1)'))];
idx_notNAN=~isnan(values);
     x=[values(idx_notNAN)' groups(idx_notNAN)'];
cuzick(x)




% %% Bar graph
% 
% axes('position',[position_x1(4), position_y1(2), panel_width1, panel_height1]);
% ym=[y_mean(1),y_mean(end)];
% ys=[y_stem(1),y_stem(end)];
% 
% hold on;
% xl=[0 5.5];
% yl=[0 50];
% bar([1],[ym(1)],'facecolor',[0.5 1 0.5])
% bar([2],[ym(2)],'facecolor',[0 0.4 0])
% errorbar([1 2],ym,  ys,'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',6);
% set(gca,'Xlim',xl,'Ylim',yl,'Xtick',[1 2],'XtickLabel',{'Weak     ','       Strong '},'FontSize',8);
% 
% % text(2, 40, '*', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold','HorizontalAlignment','center');
% text(xl(1)-diff(xl)*0.15,yl(1)+diff(yl)*0.6,sprintf('\\Delta probability\n lick right (%%)'),'FontSize',8,'Rotation',90,'HorizontalAlignment','center');
% xlim([0.5,2.5]);
% 
% 
% 
%% Weak versus Strong ramping trajectories
            min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};

axes('position',[position_x1(1), position_y1(3), panel_width1, panel_height1]);

key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.mode_type_name = 'Ramping Orthog.1';
k.trial_type_name='l_-1.6Full';

rel_Proj = ( ANL.ProjTrialNormalized22*EXP.SessionID & key) & (EXP.BehaviorTrial * EXP.TrialName & k & 'outcome!="ignore"' & key & sprintf('num_units_projected>=%d', min_num_units_projected) &  (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0'));


  Param = struct2table(fetch (ANL.Parameters,'*'));
            time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
            psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
            smooth_time = 0; %Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
            smooth_bins=ceil(smooth_time/psth_time_bin);

t1=-2;
t2=-1.6;
tidx = time>t1 & time<=t2;

all_projs=cell2mat(fetchn(rel_Proj,'proj_trial'));


all_projs_mean=nanmean(all_projs(:,tidx),2);

idx_low= all_projs_mean<=0.5;
idx_high= all_projs_mean>0.5;

 all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');



y_mean1=nanmedian(all_projs(idx_low,tidx));
y_stem1=nanstd(all_projs(idx_low,tidx))./sqrt(size(all_projs(idx_low,:),1));

y_mean2=nanmedian(all_projs(idx_high,tidx));
y_stem2=nanstd(all_projs(idx_high,tidx))./sqrt(size(all_projs(idx_high,:),1));

hold on;
% plot(time(tidx2),mean(all_projs(idx_low,tidx2),1),'-b');
% plot(time(tidx2),mean(all_projs(idx_high,tidx2),1),'-r');

yl=[0.25,0.65];
ylim(yl)
xl=[t1,t2];
xlim(xl);
shadedErrorBar(time(tidx),y_mean1,y_stem1,'lineprops',{'-','Color',[1 0 1],'markeredgecolor',[1 0 1],'markerfacecolor',[1 0 1],'linewidth',1});
shadedErrorBar(time(tidx),y_mean2,y_stem2,'lineprops',{'-','Color',early_delay_colr,'markeredgecolor',early_delay_colr,'markerfacecolor',early_delay_colr,'linewidth',1});
text ((xl(1)-diff(xl)*0.3), (yl(1) + diff(yl)*0.5), sprintf('Ramping mode \n (a.u.)'),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
set(gca,'FontSize',7,'Xtick',[-2.1 -1.6],'XtickLabel',[-0.5 0],'Ytick',yl);
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.4,sprintf('Time to Distractor \n onset (s)'),'FontSize',7,'HorizontalAlignment','center');




if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
savefig(figure_name_out)


end




