function [selectivity_explained , trialavg_var_explained, time2plot]=fn_compute_varaince_single_trials(Param,rel_Proj,rel_PSTH , mode_names)

time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
baseline_idx_time = (time>= -4 & time<=-3);

time_window = 0.05;
time_start = -3.5;
time_end =0;

%% loop over sessions
session_uid = unique(fetchn(rel_Proj,'session_uid'));

for i_s = 1:1:numel(session_uid)
    k_s.session_uid=session_uid(i_s);

    %fetch selectivity

    avg_psth_left = movmean(cell2mat(fetchn(rel_PSTH & k_s & 'trial_type_name="l"','psth_avg')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
    avg_psth_right = movmean(cell2mat(fetchn(rel_PSTH & k_s & 'trial_type_name="r"','psth_avg')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
    
    unit_selectivity = abs(avg_psth_right - avg_psth_left);

    avg_psth_left = avg_psth_left - nanmean(avg_psth_left (:,baseline_idx_time),2);
    avg_psth_right = avg_psth_right - nanmean(avg_psth_right (:,baseline_idx_time),2);

    
    for i_m = 1:1:numel(mode_names)
        k_proj.mode_type_name = mode_names{i_m};
        proj_l(i_m,:) = movmean((fetch1(rel_Proj & k_s & k_proj & 'trial_type_name="l"','proj_average')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        proj_r(i_m,:) =  movmean((fetch1(rel_Proj & k_s & k_proj & 'trial_type_name="r"','proj_average')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        proj_select(i_m,:) = proj_r(i_m,:) - proj_l(i_m,:);
        
        proj_l(i_m,:) = proj_l(i_m,:) - nanmean(proj_l (i_m,baseline_idx_time));
        proj_r(i_m,:) = proj_r(i_m,:) - nanmean(proj_r (i_m,baseline_idx_time));

    end
    
    cnt=1;
    for i_t=time_start:time_window:time_end
        idx_time = (time>= (i_t-time_window) & time<=i_t);
        
        % selectivity explained
        total_selectivity(i_s,cnt) = sum(nanmean(unit_selectivity(:,idx_time),2).^2);
        total_proj_select(i_s,:,cnt) = nanmean(proj_select(:,idx_time),2).^2;
        s_explained(i_s,:,cnt) = total_proj_select(i_s,:,cnt)./total_selectivity(i_s,cnt)'; %selectivity explained
        
        % Trial-averaged variance explained
        total_var(i_s,cnt) = sum(nanmean(avg_psth_left(:,idx_time),2).^2)+sum(nanmean(avg_psth_right(:,idx_time),2).^2);
        total_proj_var(i_s,:,cnt) = nanmean(proj_l(:,idx_time),2).^2 + nanmean(proj_r(:,idx_time),2).^2;
        trialavg_v_explained(i_s,:,cnt) = total_proj_var(i_s,:,cnt)./total_var(i_s,cnt)'; %selectivity explained
        
%          % Across-trial (not averaged) variance explained
%         total_var(i_s,cnt) = sum(nanmean(avg_psth_left(:,idx_time),2).^2)+sum(nanmean(avg_psth_right(:,idx_time),2).^2);
%         total_proj_var(i_s,:,cnt) = nanmean(proj_l(:,idx_time),2).^2 + nanmean(proj_r(:,idx_time),2).^2;
%         trialavg_v_explained(i_s,:,cnt) = total_proj_var(i_s,:,cnt)./total_var(i_s,cnt)'; %selectivity explained

        
        cnt=cnt+1;
    end
end

selectivity_explained.m = squeeze(mean(s_explained,1));
selectivity_explained.stem = squeeze(std(s_explained,1,1))./sqrt(numel(session_uid));

trialavg_var_explained.m = squeeze(nanmean(trialavg_v_explained,1));
trialavg_var_explained.stem = squeeze(nanstd(trialavg_v_explained,1,1))./sqrt(numel(session_uid));

time2plot = time_start:time_window:time_end;

