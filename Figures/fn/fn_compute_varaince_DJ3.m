function [ trial_var_explained]=fn_compute_varaince_DJ3(rel_Proj,rel_PSTH, time_bins,time_window, kkk)
trial_var_explained=[];
Param = struct2table(fetch (ANL.Parameters,'*'));

time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
% baseline_idx_time = (time>= -4 & time<=-3);

psth_trial = movmean(cell2mat(fetchn(rel_PSTH & kkk ,'psth_trial')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
if isempty(psth_trial)
    return
end
% psth_trial = psth_trial - nanmean(nanmean(psth_trial (:,baseline_idx_time),2));

proj_trial = movmean(cell2mat(fetchn(rel_Proj & kkk ,'proj_trial')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
% proj_trial = proj_trial - nanmean(nanmean(proj_trial (:,baseline_idx_time),2));

for i_t=1:1:numel(time_bins)
    idx_time = (time>= (time_bins(i_t)-time_window) & time<=time_bins(i_t));
    % Trial-averaged variance explained
    total_var = sum(nanmean(psth_trial(:,idx_time),2).^2);
    total_proj_var = sum(nanmean(proj_trial(:,idx_time),2).^2);
    trial_var_explained(i_t) = total_proj_var/total_var; %selectivity explained
end
