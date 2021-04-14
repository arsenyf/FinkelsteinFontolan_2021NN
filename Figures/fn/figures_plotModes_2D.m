function [xl, yl] = figures_plotModes_2D (rel,Param, mode_names, mode_names_titles, xlabel_flag, ylabel_flag, flag_normalize_modes, xl_normalized, yl_normalized,outcome, plot_r_flag)


for imod = 1:1:numel(mode_names)
    key_mode.mode_type_name = mode_names{imod};
    key_mode.mode_title = mode_names_titles{imod};
    key_mode.outcome = outcome; 
    %     trial_type_substract='l';
    trial_type_substract=[];
    rel_current=rel{imod};
    PROJ2D_hit(imod) = fn_getProjection_2D(Param, rel_current, key_mode, trial_type_substract,  flag_normalize_modes);
end
if flag_normalize_modes==1

    ax_lims(1,:)= xl_normalized; %[-0.05,1.05];
    ax_lims(2,:)= yl_normalized; %[-0.05, 1.05];
    set(gca,'Xtick',[ -1:1:1],'Ytick',[ 0 1],'Fontsize',6);

else
    ax_lims(1,:) = [-2,25];
    ax_lims(2,:) = [-5,25];
    set(gca,'Xtick',ax_lims(1,:),'Ytick',ax_lims(2,:),'Fontsize',6);
end


xl=ax_lims(1,:);
yl=ax_lims(2,:);
xlim(xl);
ylim(yl);

figure_fn_plot_projection_2D (PROJ2D_hit, plot_r_flag, outcome);

if xlabel_flag==1
    text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.4), sprintf('%s mode\n   (a.u.)',mode_names_titles{1}),'Fontsize', 7,'HorizontalAlignment','center');
end
if ylabel_flag==1
    text ((xl(1)-diff(xl)*0.2), (yl(1) + diff(yl)*0.5), sprintf('%s mode\n (a.u.)',mode_names_titles{2}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
end
box off;