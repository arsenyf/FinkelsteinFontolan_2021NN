function Sup_REV1_Ramping__FS() % MATLAB R2017a
close all;
tic
dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Fig4_low_vs_high_ramping_together';
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



early_delay_colr=[0 0 0];
key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'FS';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.mode_type_name = 'Ramping Orthog.111';
key.trial_decoded_type='all';



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
rel_Switch = (ANL.SwitchProbabilityHighvsLow11FS* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping ) & k & (EXP.SessionTask &'task="s1 stim"') & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
switch_prob = cell2mat(fetchn(rel_Switch,'switch_prob' ,'ORDER BY session_uid'));
normalized_proj_bins =  cell2mat(fetchn(rel_Switch,'normalized_proj_bins' ,'ORDER BY session_uid'));
hold on;
switch_prob1 =  switch_prob;
x=nanmedian(normalized_proj_bins);
y_mean=nanmedian(switch_prob1);
y_stem=nanstd(switch_prob1)./sqrt(size(switch_prob1,1));
% shadedErrorBar(x,y_mean,y_stem,'lineprops',{'-','Color',colr,'markeredgecolor',colr,'markerfacecolor',colr,'linewidth',1});

k.trial_type_name='l';
rel_Switch = (ANL.SwitchProbabilityHighvsLow11FS* EXP.SessionID * EXP.SessionTraining *ANL.SessionGrouping) & k & (EXP.SessionTask &'task="s1 stim"') &  (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');
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
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.4,sprintf('Ramping before \n distractor (a.u.)', legends{2}.title_label),'FontSize',7,'HorizontalAlignment','center');
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.6, sprintf('%s \n strong distractors    ', legends{2}.title_label),'FontSize',7,'Color',legends{2}.colr,'HorizontalAlignment','center','fontweight','bold');
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



if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
savefig(figure_name_out)


end




