function Sup1_PYR_clustering()
close all;

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Sup1_PYR_clustering';
set(gcf,'color',[1 1 1]);

%Graphics
%---------------------------------
figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 23 30]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 0 0 0]);
set(gcf,'color',[1 1 1]);

% panel_width=0.035;
% panel_height=0.065;
% horizontal_distance=0.057;
% vertical_distance=0.31;
panel_width=0.055;
panel_height=0.065;
horizontal_distance=0.08;
vertical_distance=0.4;

position_x(1)=0.13;

position_y(1)=0.8;
position_y(2)=position_y(1)-vertical_distance;


columns2plot=18;
min_cluster_percent=2;


% %% Recording locations vS1
% axes('position', [position_x(1)-0.115 position_y(1)+0.03 0.06 0.06]); hold on ;
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
% axes('position', [position_x(1)-0.115 position_y(2)+0.1 0.06 0.06]); hold on ;
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
% axes('position', [position_x(1)-0.115 position_y(2)+0.025 0.06 0.06]); hold on ;
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

%% vS1

% fetch Cluster
key.brain_area = 'vS1'
key.hemisphere = 'left'
key.training_type = 'all'
% key.unit_quality = 'ok or good' %'ok or good'
key.unit_quality = 'all' %'ok or good'
key.cell_type = 'Pyr'


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

time2plot = time(idx_time2plot);
%fetch Unit
Unit = struct2table(fetch((EPHYS.Unit * EPHYS.UnitPosition * EXP.SessionTraining * EXP.SessionID ) & key_cluster & ANL.IncludeUnit2 ,'*', 'ORDER BY unit_uid'));
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
% rel= ((ANL.PSTHAdaptiveAverage * EPHYS.Unit) & key_cluster) & 'outcome="ignore"';
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

axes('position',[position_x(1), 0.93, panel_width, panel_height]);
percent_of_all = sum(cluster_percent(clusters_2plot));
% text( 0,0 , sprintf('%s %s side   Training: %s    CellQuality: %s  Cell-type: %s    \n \n Includes: %d units,   %.1f %% in these clusters:' ,...
%     key.brain_area, key.hemisphere, key.training_type, key.unit_quality, key.cell_type, size(UnitCluster,1), percent_of_all),'HorizontalAlignment','Left','FontSize', 10);
axis off;
box off;

plot_counter=0;
for ii = cluster_order
    i = clusters_2plot(ii);
    idx2plot = find(cl_id==i);
    
    
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(1)+0.02, panel_width, panel_height*0.6]);
      if plot_counter==0
    title(sprintf('Cluster %d \n%.1f%% cells\n\n',plot_counter+1, cluster_percent(i) ),'FontSize',8);
    else
    title(sprintf('%d \n  %.1f%%\n\n',plot_counter+1, cluster_percent(i) ),'FontSize',8);
    end
    axis off; box off;
    xl=([0 3]);
    xlim(xl);
    yl=[0 1];
    ylim(yl);
    if mod(plot_counter,columns2plot)==0
        text(xl(1)-diff(xl)*0.75, yl(1)+diff(yl)*2.3, 'A', ...
            'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
        %         text(xl(1)-diff(xl)*1.05, yl(1)-diff(yl)*0.9, 'b', ...
        %             'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
%         text(xl(1)+diff(xl)*0.7, yl(1)+diff(yl)*1.1, 'Delay', ...
%             'fontsize', 6, 'fontname', 'helvetica','HorizontalAlignment','Center');
    end
    
    %% Cluster Pure L vs Pure R PSTH
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+1), panel_width, panel_height]);
    flag_xlabel=0;
    ylab='Correct trials'; num=1;
    legend_flag=1;
    [peak_FR] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+1)-0.1, panel_width, panel_height]);
    flag_xlabel=1;
    ylab='Error trials'; num=2;
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
key.cell_type = 'Pyr'


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

time2plot = time(idx_time2plot);

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
% rel= ((ANL.PSTHAdaptiveAverage * EPHYS.Unit) & key_cluster) & 'outcome="ignore"';
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

axes('position',[position_x(1), 0.93, panel_width, panel_height]);
percent_of_all = sum(cluster_percent(clusters_2plot));
% text( 0,0 , sprintf('%s %s side   Training: %s    CellQuality: %s  Cell-type: %s    \n \n Includes: %d units,   %.1f %% in these clusters:' ,...
%     key.brain_area, key.hemisphere, key.training_type, key.unit_quality, key.cell_type, size(UnitCluster,1), percent_of_all),'HorizontalAlignment','Left','FontSize', 10);
axis off;
box off;

plot_counter=0;

clear cells_in_Session cluster_percent_in_session session_hemis

for ii = cluster_order
    i = clusters_2plot(ii);
    idx2plot = find(cl_id==i);
    
    %% Percent cells in different hemispheres, for each cluster (mean/stem across sessions)
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+2)+0.1, panel_width, panel_height*0.6]);
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
    if (~isempty (L_percent) && ~isempty (R_percent)) %i.e. if there are recordings from both left and right hemispheres
        HemisR.mean=mean(R_percent);
        HemisR.stem=std(R_percent)/sqrt(numel(R_percent));
        pvalue_HemisLR = ranksum(L_percent,R_percent); %Wilcoxon rank sum test (non paired-samples)
%             [~, pvalue_HemisLR]= ttest2(L_percent,R_percent); %t-test (non paired-samples)
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
        
         
        hold on;
        bar(1,HemisL.mean,'facecolor',[1 0 1],'edgecolor', [1 0 1], 'BarWidth', 0.7);
        bar(2,HemisR.mean,'facecolor',[0.4 0 0.4],'edgecolor', [0.4 0 0.4], 'BarWidth', 0.7);
        errorbar( [1 2], [HemisL.mean HemisR.mean], [HemisL.stem HemisR.stem],'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',6);
        xl=([0 3]);
        yl=([0 max([HemisL.mean+HemisL.stem, HemisR.mean+ HemisR.stem,eps])]);
        xlim(xl);
        ylim(yl);
        text(2,max([(HemisR.mean+ HemisR.stem)*1.2, 1]),sprintf('%.4f',pvalue_star),'FontSize',12,'FontWeight','bold','HorizontalAlignment','center');
        set(gca,'xtick',[1,2],'xticklabels',{'L','R'},'ytick',[0 floor(yl(2))],'FontSize',8);
        if mod(plot_counter,columns2plot)==0
            ylabel(sprintf('%% cells in\n   hemisphere'),'FontSize',7);
            text(xl(1)-diff(xl)*0.75, yl(1)+diff(yl)*1.7, 'B', ...
                'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
            %             text(xl(1)-diff(xl)*1.05, yl(1)-diff(yl)*0.8, 'd', ...
            %                 'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
            %             text(xl(1)-diff(xl)*1.05, yl(1)-diff(yl)*3.3, 'e', ...
            %                 'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
              end
    end
    if plot_counter==0
    title(sprintf('Cluster %d \n',plot_counter+1),'FontSize',8);
    else
            title(sprintf('%d \n',plot_counter+1),'FontSize',8);
    end
    %% Cluster Pure L vs Pure R PSTH
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+2), panel_width, panel_height]);
    flag_xlabel=0;
    ylab='Correct trials'; num=1;
    legend_flag=1;
    [peak_FR] = fn_plotCluster (plot_counter, columns2plot, Param,time2plot, idx2plot, idx_time2plot,  L, R, num, [], flag_xlabel, peak_LR_hit_units,ylab, legend_flag);
    
    axes('position',[position_x(1)+horizontal_distance*(mod(plot_counter,columns2plot)), position_y(floor(plot_counter/columns2plot)+2)-0.1, panel_width, panel_height]);
    flag_xlabel=1;
    ylab='Error trials'; num=2;
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
set(gcf,'color','w')
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);

% eval(['print ', figure_name_out, ' -f', num2str(gcf), ' -dpdf -cmyk']);
% eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end