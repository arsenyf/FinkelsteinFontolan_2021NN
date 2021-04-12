function [ trialavg_var_explained, time2plot]=fn_compute_varaince(Param,rel_Proj,rel_PSTH , mode_names)

time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
baseline_idx_time = (time>= -4 & time<=-3);

time_window = 0.05;
time_start = -4.5;
time_end =0;

%% loop over sessions
session_uid = unique(fetchn(rel_Proj,'session_uid'));

for i_s = 1:1:numel(session_uid)
    k_s.session_uid=session_uid(i_s);
    
    %fetch selectivity
    
    psth_trial = movmean(cell2mat(fetchn(rel_PSTH & k_s ,'psth_trial')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
    psth_trial = psth_trial - nanmean(psth_trial (:,baseline_idx_time),2);
    
    proj_trial=[];
    for i_m = 1:1:numel(mode_names)
        k_proj.mode_type_name = mode_names{i_m};
        proj_trial = movmean(cell2mat(fetchn(rel_Proj & k_s & k_proj ,'proj_trial')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        proj_trial = proj_trial - nanmean(proj_trial (:,baseline_idx_time),2);
        
        t_bin=1;
        for i_t=time_start:time_window:time_end
            idx_time = (time>= (i_t-time_window) & time<=i_t);
            
            
            % Trial-averaged variance explained
            total_var = sum(nanmean(psth_trial(:,idx_time),2).^2);
            total_proj_var = sum(nanmean(proj_trial(:,idx_time),2).^2);
            trialavg_v_explained(i_s,i_m,t_bin) = total_proj_var/total_var; %selectivity explained
            
            %          % Across-trial (not averaged) variance explained
            %         total_var(i_s,cnt) = sum(nanmean(avg_psth_left(:,idx_time),2).^2)+sum(nanmean(avg_psth_right(:,idx_time),2).^2);
            %         total_proj_var(i_s,:,cnt) = nanmean(proj_l(:,idx_time),2).^2 + nanmean(proj_r(:,idx_time),2).^2;
            %         trialavg_v_explained(i_s,:,cnt) = total_proj_var(i_s,:,cnt)./total_var(i_s,cnt)'; %selectivity explained
            
            
            t_bin=t_bin+1;
        end
    end
end

trialavg_var_explained.m = squeeze(nanmean(trialavg_v_explained,1));
trialavg_var_explained.stem = squeeze(nanstd(trialavg_v_explained,1,1))./sqrt(numel(session_uid));

time2plot = time_start:time_window:time_end;

