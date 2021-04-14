function figure_plot_PSTH_FS(k,x,y,Param, rel, flag_xlable,flag_xlable2, flag_ylable, cell_num)

panel_width=0.05;
panel_height=0.03;
horizontal_distance=0.08;
vertical_distance=0.084;

position_x(1)=0.12;
position_x(2)=position_x(1)+horizontal_distance;
position_x(3)=position_x(2)+horizontal_distance;
position_x(4)=position_x(3)+horizontal_distance;
position_x(5)=position_x(4)+horizontal_distance;
position_x(6)=position_x(5)+horizontal_distance;
position_x(7)=position_x(6)+horizontal_distance;
position_x(8)=position_x(7)+horizontal_distance;

position_y(1)=0.84;
position_y(2)=position_y(1)-vertical_distance;
position_y(3)=position_y(2)-vertical_distance;
position_y(4)=position_y(3)-vertical_distance;
position_y(5)=position_y(4)-vertical_distance;



t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
t_sample_stim = Param.parameter_value{(strcmp('t_sample_stim',Param.parameter_name))};
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_cell_psth',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);

xl=([-3.5  0]);
x_idx = (time>=xl(1) & time<=xl(2));
%% Raster
axes('position',[position_x(x), position_y(y)+0.03, panel_width, panel_height*0.8]);
hold on;

% fill(t_sample_stim + [0 0 0.4 0.4], [0 100 100 0], [0.6 0.85 1], 'LineStyle', 'None');

spikes_l=  fetchn(rel.spikes_l & k,'spike_times_go');

spikes_r=  fetchn(rel.spikes_r & k,'spike_times_go');
count = 0;
for i=1:1:numel(spikes_l)
    count=count+1;
    if numel(spikes_l{i})>0
        plot(spikes_l{i},count, '.','MarkerSize',0.1,'Color',[1 0 0]);
    end
end
for i=1:1:numel(spikes_r)
    count=count+1;
    if numel(spikes_r{i})>0
        plot(spikes_r{i},count, '.','MarkerSize',0.1,'Color',[0 0 1]);
    end
end
xlim(xl);
yl=[0 count];
ylim(yl);
set(gca,'YTick',[],'XTick',[-4 -2 0 2],'XTickLabel',[],'FontSize',6);
axis off;
box off;
text(-1.8,yl(2)+diff(yl)*0.35,sprintf('Cell %d', cell_num), 'FontSize',7,'HorizontalAlignment','left');

% % Trial label
% factor1=1+0.4*(diff(yl)/yl(2));
% factor2=1+0.1*(diff(yl)/yl(2));
% time1=-2.5;
% time2=-2.1;
% colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
% plot([time1, time2],[yl(2)*factor1,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
% plot([time1, time1],[yl(2)*factor2,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
% plot([time2, time2],[yl(2)*factor1,yl(2)*factor2],'Color',colr{1},'LineWidth',1,'Clipping','off')

stim_legend_flag=1;
if stim_legend_flag==1
    % Plot waves - full stimuli
    x_sin = 0:0.01:pi;
    y_mini = repmat(sin(x_sin),1); % mini
    y_full = repmat(sin(x_sin),4); % full
    
        factor=diff(yl)/3;
        
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
              
        plot(linspace(-2.5, -2.1, 4*numel(x_sin)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
end




%% PSTH
axes('position',[position_x(x), position_y(y), panel_width, panel_height]);
hold on;

psth_l=  movmean(fetch1(rel.PSTH_l & k,'psth_avg'),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
psth_r=  movmean(fetch1(rel.PSTH_r & k,'psth_avg'),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
yl=([0  ceil(nanmax([psth_l(x_idx),psth_r(x_idx)]))]);

% fill(t_sample_stim + [0 0 0.4 0.4], [0 100 100 0], [0.75 0.75 0.75], 'LineStyle', 'None');
fill(t_sample_stim + [0 0 0.4 0.4], [0 100 100 0], [0.6 0.85 1], 'LineStyle', 'None');
plot([t_go t_go], [yl(1) yl(2)*1.8], 'k-','LineWidth',0.5,'clipping','off');
plot([t_chirp1 t_chirp1], [yl(1) yl(2)*1.8], 'k-','LineWidth',0.5,'clipping','off');
plot([t_chirp2 t_chirp2], [yl(1) yl(2)*1.8], 'k-','LineWidth',0.5,'clipping','off');

plot(time,psth_r, 'Color', [0 0 1] , 'LineWidth', 0.7);
plot(time,psth_l, 'Color', [1 0 0] , 'LineWidth', 0.7);
xlim(xl);
ylim(yl);

if x==1
        text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*0.75,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
end

if flag_xlable==1
    set(gca,'YTick',yl,'XTick',[-4 -2 0 2],'FontSize',6);
    if x==1
        text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.5,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
    end
else
    set(gca,'YTick',yl,'XTick',[-4 -2 0 2],'FontSize',6);
end

if flag_xlable2==1
    set(gca,'YTick',yl,'XTick',[-4 -2 0 2],'FontSize',6);
    if x==1
%         text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*0.75,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
%         text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.5,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
        text(-1.8,yl(2)*0.9,'Delay','FontSize',6);
    end
else
    set(gca,'YTick',yl,'XTick',[-4 -2 0 2],'FontSize',6);
end

if flag_ylable==1
    
    text(xl(1)+diff(xl)*1.45, yl(1)+diff(yl)*2.5,'Lick Left','FontSize',7,'Color',[1 0 0]);
    plot([xl(1)+diff(xl)*1.05 xl(1)+diff(xl)*1.05+1], [yl(1)+diff(yl)*2.5 yl(1)+diff(yl)*2.5],'-','LineWidth',1,'Color',[1 0 0],'Clipping','off');
    text(xl(1)+diff(xl)*2.9,yl(1)+diff(yl)*2.5,'Lick Right','FontSize',7,'Color',[0 0 1]);
    plot([xl(1)+diff(xl)*2.5 xl(1)+diff(xl)*2.5+1], [yl(1)+diff(yl)*2.5 yl(1)+diff(yl)*2.5],'-','LineWidth',1,'Color',[0 0 1],'Clipping','off');
    %     text(xl(1)+diff(xl)*5.5,yl(1)-diff(yl)*0.9,'Selectivity','FontSize',7,'Color',[0.5 1 0]);
    %     plot([xl(1)+diff(xl)*5.3 xl(1)+diff(xl)*5.3+1], [yl(1)-diff(yl)*0.9 yl(1)-diff(yl)*0.9],'-','LineWidth',1,'Color',[0.5 1 0],'Clipping','off');
    
end


   
