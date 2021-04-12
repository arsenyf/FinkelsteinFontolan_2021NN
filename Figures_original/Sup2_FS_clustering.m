function Sup2_FS_clustering()
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup2_FS_clustering';
set(gcf,'color',[1 1 1]);

%Graphics
%---------------------------------
figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 23 30]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 0 0 0]);


panel_width1=0.055;
panel_height1=0.06;
horizontal_distance1=0.07;
vertical_distance1=0.082;

position_x1(1)=0.02;
position_x1(2)=position_x1(1)+horizontal_distance1*5;

position_y1(1)=0.84;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1;
position_y1(4)=position_y1(3)-vertical_distance1;


panel_width2=0.055;
panel_height2=0.065;
horizontal_distance2=0.08;
vertical_distance2=0.29;

position_x2(1)=0.13;

position_y2(1)=0.60;
position_y2(2)=position_y2(1)-vertical_distance2;

position_x3(1)=0.13;

position_y3(1)=0.57;
position_y3(2)=position_y3(1)-vertical_distance2;

columns2plot=10;
min_cluster_percent=2;

Param = struct2table(fetch (ANL.Parameters,'*'));


% %% Recording locations
% axes('position', [position_x1(1) position_y1(1) 0.06 0.06]); hold on ;
% xl = [0 342];
% yl = [0 428];
% fig1_a = imread([dir_embeded_graphics 'left_vS1.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% text(xl(1)+diff(xl)*1.2, yl(1)+diff(yl)*1.05, 'A', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'vS1 left','FontSize',8,'FontWeight','bold','Color',[0 1 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
% 
% 
% axes('position', [position_x1(1) position_y1(2) 0.06 0.06]); hold on ;
% xl = [0 342];
% yl = [0 431];
% fig1_a = imread([dir_embeded_graphics 'left_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM left','FontSize',8,'FontWeight','bold','Color',[1 0 1],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
% 
% % axes('position', [position_x1(1) position_y1(3)-0.01 0.06 0.06]); hold on ;
% % xl = [0 342];
% % yl = [0 428];
% % fig1_a = imread([dir_embeded_graphics 'right_ALM.jpg']);
% % fig1_a=flipdim(fig1_a,1);
% % imagesc(fig1_a);
% % set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM right','FontSize',8,'FontWeight','bold','Color',[0.4 0 0.4],'HorizontalAlignment','center');
% % axis off;
% % axis tight;
% % axis equal;

%% Raster plots and PSTHs
rel.PSTH_l = (EPHYS.Unit * EPHYS.UnitCellType * ANL.PSTHAverage & ANL.IncludeUnit2 & 'outcome="hit"' & 'trial_type_name="l"');
rel.PSTH_r = (EPHYS.Unit * EPHYS.UnitCellType * ANL.PSTHAverage & ANL.IncludeUnit2 & 'outcome="hit"' & 'trial_type_name="r"');

rel.spikes_l = ANL.TrialSpikesGoAligned * EPHYS.Unit * EPHYS.UnitPosition * EXP.BehaviorTrial * EXP.TrialName & ANL.IncludeUnit2 &  'outcome="hit"' & 'early_lick="no early"' & 'trial_type_name="l"' ;
rel.spikes_r = ANL.TrialSpikesGoAligned * EPHYS.Unit * EPHYS.UnitPosition  * EXP.BehaviorTrial * EXP.TrialName & ANL.IncludeUnit2 & 'outcome="hit"' & 'early_lick="no early"' & 'trial_type_name="r"';


%%vS1
k.unit_uid=2253; x=1; y=1; flag_xlable=0; flag_xlable2=1; flag_ylable=1; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 1) % 2111
k.unit_uid=2111; x=2; y=1; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 2) %3187
k.unit_uid=2066; x=3; y=1; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 3)

%%Left ALM
k.unit_uid=3916; x=1; y=2; flag_xlable=1; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 5) %3974
k.unit_uid=2588; x=2; y=2; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 6) 
k.unit_uid=56; x=3; y=2; flag_xlable=0; flag_xlable2=0; flag_ylable=0; figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, 7) 


key=[];


%% Selectivity

% Left vS1
key.brain_area = 'vS1';
key.hemisphere = 'left';
key.training = 'all';
key.cell_type = 'FS';
axes('position',[position_x1(2), position_y1(1), panel_width1*1.1, panel_height1]);
labels_flag=0;
[xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);
yl = [0 60];
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*1.25, ['{\color[rgb]{0.75 0.75 0}Selectivity ' ...
    '\color{black}= '...
    '\color{blue}Right'...
        '\color{black} - '...
    '\color{red}Left}'],'FontSize',7);
text(-0.9, yl(1)+diff(yl)*1.05, 'Delay', ...
    'fontsize', 6,'HorizontalAlignment','center');
% text(xl(1)-diff(xl)*0.5, yl(1)+diff(yl)*1.05, 'd', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'Ylim',yl,'Ytick',yl);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*0.4,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
% Trial label
x_sin = 0:0.01:pi;
y_mini = repmat(sin(x_sin),1); % mini
y_full = repmat(sin(x_sin),4); % full
factor=diff(yl)/8;
colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
plot(linspace(-2.5, -2.1, 4*numel(x_sin)),y_full*(factor)+yl(2)*1.02,'Color',colr{1},'LineWidth',0.5,'Clipping','off')

% Left ALM
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.training = 'regular';
key.cell_type = 'FS';
axes('position',[position_x1(2), position_y1(2), panel_width1*1.1, panel_height1]);
labels_flag=0;
[xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);
yl = [0 18];
set(gca,'Ylim',yl,'Ytick',yl);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*0.4,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.25,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');


% Trial label
x_sin = 0:0.01:pi;
y_mini = repmat(sin(x_sin),1); % mini
y_full = repmat(sin(x_sin),4); % full
factor=diff(yl)/8;
colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
plot(linspace(-2.5, -2.1, 4*numel(x_sin)),y_full*(factor)+yl(2)*1.02,'Color',colr{1},'LineWidth',0.5,'Clipping','off')

% %% Right ALM
% key.brain_area = 'ALM';
% key.hemisphere = 'right';
% key.training = 'regular';
% key.cell_type = 'FS';
% axes('position',[position_x1(2), position_y1(3), panel_width1*1.1, panel_height1]);
% labels_flag=1;
% [xl,yl]=figure_plotSpikeCount (Param, rel, labels_flag, key);
% yl = [0 15];
% set(gca,'Ylim',yl,'Ytick',yl);
% text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.3,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
% text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);







% %% Recording locations vS1
% axes('position', [position_x2(1)-0.115 position_y2(1)+0.015 0.06, 0.06]); hold on ;
% xl = [0 134];
% yl = [0 135];
% fig1_a = imread([dir_embeded_graphics 'left_vS1.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'vS1 left','FontSize',7,'FontWeight','bold','Color',[0 0 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
%
% %Recording locations in ALM
% axes('position', [position_x3(1)-0.115 position_y3(2)+0.09 0.06 0.06]); hold on ;
% xl = [0 121];
% yl = [0 115];
% fig1_a = imread([dir_embeded_graphics 'left_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.4,sprintf('ALM \nleft & right'),'FontSize',7,'FontWeight','bold','Color',[0 0 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;


% %% Recording locations vS1
% axes('position', [position_x2(1)-0.11 position_y2(1) 0.06 0.06]); hold on ;
% xl = [0 342];
% yl = [0 428];
% fig1_a = imread([dir_embeded_graphics 'left_vS1.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)-diff(xl)*0.05, yl(1)+diff(yl)*1.3, 'd', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'vS1 left','FontSize',8,'FontWeight','bold','Color',[0 1 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
% 
% %Recording locations in ALM
% axes('position', [position_x3(1)-0.115 position_y3(2)+0.1 0.06 0.06]); hold on ;
% xl = [0 342];
% yl = [0 431];
% fig1_a = imread([dir_embeded_graphics 'left_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)-diff(xl)*0.05, yl(1)+diff(yl)*1.25, 'f', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM left','FontSize',8,'FontWeight','bold','Color',[1 0 1],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
% 
% axes('position', [position_x3(1)-0.115 position_y3(2)+0.025 0.06 0.06]); hold on ;
% xl = [0 342];
% yl = [0 428];
% fig1_a = imread([dir_embeded_graphics 'right_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM right','FontSize',8,'FontWeight','bold','Color',[0.4 0 0.4],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;


% fetch Param
Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_cell_psth_for_clustering',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);


idx_time2plot = (time>= -3.5 & (time<=0.05));
time2plot = time(idx_time2plot);

%% vS1

% fetch Cluster
key.brain_area = 'vS1'
key.hemisphere = 'left'
key.training_type = 'all'
key.unit_quality = 'all' 
% key.unit_quality = 'ok or good' %'ok or good'
key.cell_type = 'FS'


k = key;
if contains(k.unit_quality,'all')
    k = rmfield(k,'unit_quality');
end

rel_unit=(EPHYS.Unit);
rel_cluster = (ANL.UnitHierarCluster6 * rel_unit.proj('unit_quality->temp','unit_uid')) & k;
key_cluster = fetch(rel_cluster);
UnitCluster  = struct2table(fetch(rel_cluster,'*', 'ORDER BY unit_uid'));
key_cluster = rmfield(key_cluster,{'hemisphere','brain_area','cell_type','unit_quality','training_type','heirar_cluster_time_st','heirar_cluster_time_end'});
% idx_time2plot = (time>= UnitCluster.heirar_cluster_time_st(1)) & (time<=UnitCluster.heirar_cluster_time_end(1));

%fetch Unit
Unit = struct2table(fetch((EPHYS.Unit * EPHYS.UnitPosition * EXP.SessionTraining * EXP.SessionID) & key_cluster & ANL.IncludeUnit2 ,'*', 'ORDER BY unit_uid'));
session_uid = unique(Unit.session_uid);

L.labels = {'hit','miss','ignore'};
R.labels = {'hit','miss','ignore'};

%% Hit
% fetch and smooth PSTH
rel= ((ANL.PSTHAverage * EPHYS.Unit) & key_cluster & ANL.IncludeUnit2) & 'outcome="hit"' ;
L.PSTH{1} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
R.PSTH{1} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');

L.num_trials{1} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
R.num_trials{1} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));

peak_LR_hit_units = nanmax([L.PSTH{1},R.PSTH{1}],[],2);

%% Miss
% fetch and smooth PSTH
rel= ((ANL.PSTHAverageLR * EPHYS.Unit) & key_cluster & ANL.IncludeUnit2) & 'outcome="miss"';
L.PSTH{2} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
R.PSTH{2} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
L.num_trials{2} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
R.num_trials{2} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));


% %% Ignore
% % fetch and smooth PSTH
% rel= ((ANL.PSTHAverage * EPHYS.Unit) & key_cluster) & 'outcome="ignore"';
% L.PSTH{3} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
% R.PSTH{3} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
% L.num_trials{3} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
% R.num_trials{3} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));



% Select cluster to plot
cl_id=UnitCluster.heirar_cluster_id;
cluster_percent=100*histcounts(cl_id,1:1:numel(unique(cl_id))+1)/numel(cl_id);
clusters_2plot = find(cluster_percent>=min_cluster_percent);
[~,cluster_order] = sort (cluster_percent(clusters_2plot),'descend');
cluster_order=cluster_order(1:min([numel(clusters_2plot),columns2plot*2]));

axes('position',[position_x2(1), 0.93, panel_width2, panel_height2]);
percent_of_all = sum(cluster_percent(clusters_2plot));
% text( 0,0 , sprintf('%s %s side   Training: %s    CellQuality: %s  Cell-type: %s    \n \n Includes: %d units,   %.1f %% in these clusters:' ,...
%     key.brain_area, key.hemisphere, key.training_type, key.unit_quality, key.cell_type, size(UnitCluster,1), percent_of_all),'HorizontalAlignment','Left','FontSize', 10);
axis off;
box off;

plot_counter=0;
for ii = cluster_order
    i = clusters_2plot(ii);
    idx2plot = find(cl_id==i);
    
    
    axes('position',[position_x2(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y2(1)+0.02, panel_width2, panel_height2*0.6]);
    title(sprintf('Cluster %d \n %.1f %% cells\n\n',plot_counter+1, cluster_percent(i) ),'FontSize',8);
    axis off; box off;
    xl=([0 3]);
    xlim(xl);
    yl=[0 1];
    ylim(yl);
    if mod(plot_counter,columns2plot)==0
        text(xl(1)-diff(xl)*0.75, yl(1)+diff(yl)*2.1, 'B', ...
            'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
        
        %         text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35, 'Delay', ...
        %             'fontsize', 6, 'fontname', 'helvetica','HorizontalAlignment','Center');
    end
    
    %% Cluster Pure L vs Pure R PSTH
    axes('position',[position_x2(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y2(floor(plot_counter/columns2plot)+1), panel_width2, panel_height2]);
    flag_xlabel=0;
    ylab='Correct'; num=1;
    legend_flag=1;
    [peak_FR] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    axes('position',[position_x2(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y2(floor(plot_counter/columns2plot)+1)-0.1, panel_width2, panel_height2]);
    flag_xlabel=1;
    ylab='Error'; num=2;
    legend_flag=1;
    [~] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    %     axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+1)-0.2, panel_width, panel_height]);
    %     flag_xlabel=1;
    %     ylab='No lick'; num=3;
    %     legend_flag=1;
    %     [~] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, peak_FR,flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    plot_counter = plot_counter +1;
    
end






%% ALM
% fetch Cluster
key.brain_area = 'ALM'
key.hemisphere = 'both'
key.training_type = 'all'
key.unit_quality = 'ok or good' %'ok or good'
key.cell_type = 'FS'


k = key;
if contains(k.unit_quality,'all')
    k = rmfield(k,'unit_quality');
end

rel_unit=(EPHYS.Unit);
rel_cluster = (ANL.UnitHierarCluster6 * rel_unit.proj('unit_quality->temp','unit_uid')) & k;
key_cluster = fetch(rel_cluster);
UnitCluster  = struct2table(fetch(rel_cluster,'*', 'ORDER BY unit_uid'));
key_cluster = rmfield(key_cluster,{'hemisphere','brain_area','cell_type','unit_quality','training_type','heirar_cluster_time_st','heirar_cluster_time_end'});
% idx_time2plot = (time>= UnitCluster.heirar_cluster_time_st(1)) & (time<=UnitCluster.heirar_cluster_time_end(1));
% idx_time2plot = (time>= -3.5 & (time<=2));


%fetch Unit
Unit = struct2table(fetch((EPHYS.Unit * EPHYS.UnitPosition * EXP.SessionTraining * EXP.SessionID) & key_cluster & ANL.IncludeUnit2,'*', 'ORDER BY unit_uid'));
session_uid = unique(Unit.session_uid);

L.labels = {'hit','miss','ignore'};
R.labels = {'hit','miss','ignore'};

%% Hit
% fetch and smooth PSTH
rel= ((ANL.PSTHAverage * EPHYS.Unit) & key_cluster & ANL.IncludeUnit2) & 'outcome="hit"';
L.PSTH{1} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
R.PSTH{1} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');

L.num_trials{1} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
R.num_trials{1} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));

peak_LR_hit_units = nanmax([L.PSTH{1},R.PSTH{1}],[],2);

%% Miss
% fetch and smooth PSTH
rel= ((ANL.PSTHAverageLR * EPHYS.Unit) & key_cluster & ANL.IncludeUnit2) & 'outcome="miss"';
L.PSTH{2} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
R.PSTH{2} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
L.num_trials{2} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
R.num_trials{2} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));


% %% Ignore
% % fetch and smooth PSTH
% rel= ((ANL.PSTHAverage * EPHYS.Unit) & key_cluster) & 'outcome="ignore"';
% L.PSTH{3} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="l"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
% R.PSTH{3} = movmean(cell2mat(fetchn(rel  & 'trial_type_name="r"', 'psth_avg', 'ORDER BY unit_uid')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
% L.num_trials{3} = (fetchn(rel  & 'trial_type_name="l"', 'num_trials_averaged', 'ORDER BY unit_uid'));
% R.num_trials{3} = (fetchn(rel  & 'trial_type_name="r"', 'num_trials_averaged', 'ORDER BY unit_uid'));



% Select cluster to plot
cl_id=UnitCluster.heirar_cluster_id;
cluster_percent=100*histcounts(cl_id,1:1:numel(unique(cl_id))+1)/numel(cl_id);
clusters_2plot = find(cluster_percent>=min_cluster_percent);
[~,cluster_order] = sort (cluster_percent(clusters_2plot),'descend');
cluster_order=cluster_order(1:min([numel(clusters_2plot),columns2plot*2]));

% axes('position',[position_x2(1), 0.93, panel_width2, panel_height2]);
% percent_of_all = sum(cluster_percent(clusters_2plot));
% % text( 0,0 , sprintf('%s %s side   Training: %s    CellQuality: %s  Cell-type: %s    \n \n Includes: %d units,   %.1f %% in these clusters:' ,...
% %     key.brain_area, key.hemisphere, key.training_type, key.unit_quality, key.cell_type, size(UnitCluster,1), percent_of_all),'HorizontalAlignment','Left','FontSize', 10);
% axis off;
% box off;
clear cells_in_Session cluster_percent_in_session session_hemis


plot_counter=0;
for ii = cluster_order
    i = clusters_2plot(ii);
    idx2plot = find(cl_id==i);
    
    %% Percent cells in different hemispheres, for each cluster (mean/stem across sessions)
    axes('position',[position_x3(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y3(floor(plot_counter/columns2plot)+2)+0.1, panel_width2, panel_height2*0.6]);
    for i_suid = 1:1:numel(session_uid)
        idx_in_session = find(Unit.session_uid == session_uid(i_suid));
        cells_in_Session (i_suid) = numel(idx_in_session);
        cluster_percent_in_session(i_suid) =     100*sum(ismember(idx_in_session,idx2plot))/numel(idx_in_session);
        session_hemis(i_suid) = Unit.hemisphere(idx_in_session(1));
    end
    L_percent = cluster_percent_in_session(contains(session_hemis,'left') & cells_in_Session>=0);
    HemisL.mean=mean(L_percent);
    HemisL.stem=std(L_percent)/sqrt(numel(L_percent));
    
    R_percent = cluster_percent_in_session(contains(session_hemis,'right') & cells_in_Session>=0);
    
        L_percent_all_clusters{ii} = L_percent;
    R_percent_all_clusters{ii} = R_percent;
    if (~isempty (L_percent) && ~isempty (R_percent)) %i.e. if there are recordings from both left and right hemispheres
        HemisR.mean=mean(R_percent);
        HemisR.stem=std(R_percent)/sqrt(numel(R_percent));
        pvalue_HemisLR = ranksum(L_percent,R_percent); %Wilcoxon rank sum test (non paired-samples)
        %     [~, pvalue_HemisLR]= ttest2(L_percent,R_percent); %Wilcoxon rank sum test (non paired-samples)
%         if pvalue_HemisLR<=0.001
%             pvalue_star='***';
%         elseif pvalue_HemisLR<=0.01
%             pvalue_star='**';
%         elseif pvalue_HemisLR <=0.05
%             pvalue_star='*';
%         else
%             pvalue_star='';
%         end

        if pvalue_HemisLR <=0.05
            pvalue_star=pvalue_HemisLR;
        else
            pvalue_star=[];
         end
        
%         hold on;
%         bar(1,HemisL.mean,'facecolor',[1 0 1],'edgecolor', [1 0 1], 'BarWidth', 0.7);
%         bar(2,HemisR.mean,'facecolor',[0.4 0 0.4],'edgecolor', [0.4 0 0.4], 'BarWidth', 0.7);
%         errorbar( [1 2], [HemisL.mean HemisR.mean], [HemisL.stem HemisR.stem],'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',6);
       
hold on;
        bar(1,HemisL.mean,'facecolor',[1 0 1],'edgecolor', [1 0 1], 'BarWidth', 0.7);
        lll_length = numel(L_percent_all_clusters{ii});
        plot(ones(1,lll_length)+0.1*(rand(lll_length,1)-0.5),L_percent_all_clusters{ii},'.','Color', [0 0 0]);
        bar(2,HemisR.mean,'facecolor',[0.4 0 0.4],'edgecolor', [0.4 0 0.4], 'BarWidth', 0.7);
        rrr_length = numel(R_percent_all_clusters{ii});
        plot(ones(1,rrr_length)+1+0.1*(rand(rrr_length,1)-0.5),R_percent_all_clusters{ii},'.','Color', [0 0 0]);



xl=([0 3]);
%         yl=([0 max([HemisL.mean+HemisL.stem, HemisR.mean+ HemisR.stem,eps])]);
        yl=([0 max([L_percent_all_clusters{ii},R_percent_all_clusters{ii}])]);

        xlim(xl);
        ylim(yl);
        text(2,max([(HemisR.mean+ HemisR.stem)*1.2, 1]),sprintf('%.4f',pvalue_star),'FontSize',12,'FontWeight','bold','HorizontalAlignment','center');
        set(gca,'xtick',[1,2],'xticklabels',{'L','R'},'ytick',[0 floor(yl(2))],'FontSize',7);
        if mod(plot_counter,columns2plot)==0
            ylabel(sprintf('%% cells in\n   hemisphere'),'FontSize',8);
            text(xl(1)-diff(xl)*0.75, yl(1)+diff(yl)*1.7, 'C', ...
                'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
            %             text(xl(1)-diff(xl)*1.05, yl(1)-diff(yl)*0.8, 'h', ...
            %                 'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
            %             text(xl(1)-diff(xl)*1.05, yl(1)-diff(yl)*3.3, 'i', ...
            %                 'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
            %             text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.77, 'Delay', ...
            %                 'fontsize', 6, 'fontname', 'helvetica','HorizontalAlignment','Center');
        end
    end
    title(sprintf('Cluster %d\n',plot_counter+1),'FontSize',8);
    
    %% Cluster Pure L vs Pure R PSTH
    axes('position',[position_x3(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y3(floor(plot_counter/columns2plot)+2), panel_width2, panel_height2]);
    flag_xlabel=0;
    ylab='Correct'; num=1;
    legend_flag=1;
    [peak_FR] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    axes('position',[position_x3(1)+horizontal_distance2*(mod(plot_counter,columns2plot)), position_y3(floor(plot_counter/columns2plot)+2)-0.1, panel_width2, panel_height2]);
    flag_xlabel=1;
    ylab='Error'; num=2;
    legend_flag=1;
    [~] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    %     axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+1)-0.2, panel_width, panel_height]);
    %     flag_xlabel=1;
    %     ylab='No lick'; num=3;
    %     legend_flag=1;
    %     [~] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, peak_FR,flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    plot_counter = plot_counter +1;
    
end





if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
% eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end