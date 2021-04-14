function [xl,yl]=figure_plot_behav_distractor_full_righttrials_bar(behav_param, behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials, plot_signif_offset,names_right_trials, names_left_trials, legends)
hold on;
plot_signif_offset=plot_signif_offset/100;
x_r = [-2.5, x_r];
% Right trials
if (flag_plot_left_right_trials ==0 || flag_plot_left_right_trials ==2)
    set(gca, 'Xtick', [(-3.8), (-2.5), (-1.6), (-0.8),0], 'Ytick',[0 25 50], 'TickLabelInterpreter', 'None', 'FontSize', 6, 'XTickLabelRotation', 0);
    counter=0;
    for i=1:1:numel(trn_r)
        counter =counter+1;
        values =  [behav_param(trn_r(i)).values]/100;
        values_stem(counter) = nanstd(values)/sqrt(numel(values));
        v_mean(counter) = nanmean(values);
        signif_stars{i} = behav_param_signif{trn_r(i)};
        
    end
    
    presample_colr=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-3.8Full"','trialtype_rgb');
    early_delay_colr=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-1.6Full"','trialtype_rgb');
    text(3, 0.95 ,sprintf('Early\nDelay'),'FontSize',6,'HorizontalAlignment','left','Color',early_delay_colr);
    text(2, 0.95 ,sprintf('Pre-\nSample'),'FontSize',6,'HorizontalAlignment','left','Color',presample_colr);
    text(1, 0.95 ,sprintf('Sample'),'FontSize',6,'HorizontalAlignment','left','Color',[0 0 1]);
    
    xl=[0.5 3.5];
    yl=[0.70 0.9];
    xxx=[1,2,3];
    xlim(xl);
    ylim(yl);
    bar(xxx(1),v_mean(1),'facecolor',[0 0 1])
    bar(xxx(2),v_mean(2),'facecolor',presample_colr)
    bar(xxx(3),v_mean(3),'facecolor',early_delay_colr)
    errorbar([1 2 3],v_mean(1:1:3),  values_stem(1:1:3),'.', 'Color',[0 0 0],'CapSize',4,'MarkerSize',6);
    set(gca,'FontSize',6);
    text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
        'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
    text(xl(1)-diff(xl)*0.25,yl(1)+diff(yl)*0.45,sprintf('Proportion  lick right'),'FontSize',7,'Rotation',90,'HorizontalAlignment','center');
    
    for i=1:1:3
        text(xxx(i),yl(2)*1.05,sprintf('%s',signif_stars{i}),'FontSize',7,'HorizontalAlignment','center');
    end
    set(gca,'YTick',yl)
end



box off;