function fn_2D_single_trials(rel, k, smooth_bins, time, flag_plot_errors)
t1=-1.5;
t2=0;
tidx = time>t1 & time<=t2;

k.mode_type_name = 'ChoiceMatched';
k.outcome='hit';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');

k.outcome='miss';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_miss = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');


k.mode_type_name = 'Ramping Orthog.111';

% k.mode_type_name = 'Ramping Orthog.1';
k.outcome='hit';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs2_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');

k.outcome='miss';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs2_miss = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');


colr=fetch1(ANL.TrialTypeGraphic & k ,'trialtype_rgb');

hold on;
for i_tr=1:1:size(all_projs1_hit,1)
    plot_temp=plot(all_projs1_hit(i_tr,tidx),all_projs2_hit(i_tr,tidx),'Color',colr,'LineWidth',2);
%      plot_temp.Color(4) = 0.5;
end

if flag_plot_errors==1
colr=colr*0.6;
% colr=colr + [0 0.5 0];
% colr=colr/max(colr);

% colr=colr+1;
% colr=colr/max(colr);
for i_tr=1:1:size(all_projs1_miss,1)
    plot_temp=    plot(all_projs1_miss(i_tr,tidx),all_projs2_miss(i_tr,tidx),'Color',colr,'LineWidth',2);
%      plot_temp.Color(4) = 0.5;

end
end