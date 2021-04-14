function  figure_fn_plot_projection_2D (proj2D, plot_r_flag, outcome)

for itype= 1:1:size([proj2D.p],1)
    if plot_r_flag==0
        if proj2D(1).trial_types{itype} =='r'
            continue;
        end
    end
    hold on;
%     stim_onset_idx(1) = proj2D(1).stim_onset_idx(itype,1);
%     stim_onset_idx(2) = proj2D(1).stim_onset_idx(itype,end);
    if strcmp(outcome,'hit')
    plot(proj2D(1).p(itype,:), proj2D(2).p(itype,:),'-',  'Color', proj2D(1).rgb(itype,:),'LineWidth',0.75)
    else
            plot(proj2D(1).p(itype,:), proj2D(2).p(itype,:),'--',  'Color', proj2D(1).rgb(itype,:),'LineWidth',0.75)
    end
%     plot(proj2D(1).p(itype,:), proj2D(2).p(itype,:), 'o',  'Color', proj2D(1).rgb(itype,:),'MarkerSize',3,'LineWidth',0.75)
end
