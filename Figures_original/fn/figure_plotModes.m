function [xl, yl] = figure_plotModes (rel,Param, xlabel_flag, title1, title2,title3, ylabel_flag, mode_names,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, xl, line_style, stim_time_flag)


if ~exist('line_style')
    line_style='-';
end

if ~exist('stim_time_flag')
    stim_time_flag=1;
end

%
% y_lims(1,:) = [-4,20];
% y_lims(2,:) = [-4,30];
% y_lims(3,:) = [-4,30];


for imod = 1:1:numel(mode_names)
    key_mode.mode_type_name = mode_names{imod};
    
    hold on
    key_mode.outcome = outcome; ylab='';
    %     trial_type_substract='l';
    trial_type_substract=[];
    PROJ(imod) = fn_plotProjection_for_figure(Param, rel, key_mode, trial_type_substract, ylab,mode_names_titles{imod}, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag);
    %     title(sprintf('%s',mode_names_titles{imod}));
    %     xl=[-3.5 1];
    if ~exist('xl')
    xl=[-2.9 0.2];
    end
    xlim(xl);
    %     yl = yx_lims (imod, :);
    yl = y_lims ;
    ylim(yl);
    if ylabel_flag==1
        text ((xl(1)-diff(xl)*0.23), (yl(1) + diff(yl)*0.5), sprintf('%s mode\n         (a.u.)',mode_names_titles{imod}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
    end
    
    set(gca,'FontSize',6,'YTick',[0,y_lims(2)]);
    
    %     set(gca,'FontSize',10,'YTick',[0,ax_lims(imod, 2)]);
    %     set(gca,'FontSize',10,'YTick',[-15, 5]);
    
end
    
text (-2, (yl(2) + diff(yl)*0.6), sprintf('%s\n%s\n%s',title3,title1, title2),'Fontsize', 7,'HorizontalAlignment','center','FontWeight','bold');

if xlabel_flag==1
    xlabel ('Time (s)','Fontsize', 7);
    set(gca,'Xtick',[-2 0],'TickDir','out');
else
    set(gca,'Xtick',[-2 0],'XtickLabel',[],'TickDir','out');
end
