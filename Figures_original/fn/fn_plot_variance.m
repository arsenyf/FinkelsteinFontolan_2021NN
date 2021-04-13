function xl=fn_plot_variance(Param, time2plot, variance_explained, colr)
set(gca, 'FontSize',7);

t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
t_sample_stim = Param.parameter_value{(strcmp('t_sample_stim',Param.parameter_name))};

hold on;
fill(t_sample_stim + [0 0 0.4 0.4], [0 100 100 0], [0.6 0.85 1], 'LineStyle', 'None');
plot([t_go t_go], [0 200], 'k-','LineWidth',0.5);
plot([t_chirp1 t_chirp1], [0 200], 'k-','LineWidth',0.5);
plot([t_chirp2 t_chirp2], [0 200], 'k-','LineWidth',0.5);


hold on
shadedErrorBar(time2plot,variance_explained.m(1,:),variance_explained.stem(1,:),'lineprops',{'-','Color',colr{1},'markerfacecolor',colr{1},'linewidth',1});
shadedErrorBar(time2plot,variance_explained.m(2,:),variance_explained.stem(2,:),'lineprops',{'-','Color',colr{2},'markerfacecolor',colr{2},'linewidth',1});
shadedErrorBar(time2plot,variance_explained.m(3,:),variance_explained.stem(3,:),'lineprops',{'-','Color',colr{3},'markerfacecolor',colr{3},'linewidth',1});
% plot(time2plot,sum(variance_explained.m(:,:)),'-k','linewidth',1);
xl=[-3.5 0];
xlim(xl);


