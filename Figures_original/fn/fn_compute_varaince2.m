function [trialavg_var_explained, time2plot]=fn_compute_varaince2(Param,rel_Proj,rel_PSTH , mode_names)

time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
baseline_idx_time = (time>= -4 & time<=-3);



time_window = 0.5;
time_start = -4;
time_end =2;
time_bins=  time_start:0.1:time_end;

%% loop over sessions
session_uid = unique(fetchn(rel_Proj,'session_uid'));

for i_s = 1:1:numel(session_uid)
    k_s.session_uid=session_uid(i_s);
    
    
    
    for i_m = 1:1:numel(mode_names)
        k_proj.mode_type_name = mode_names{i_m};
        
        if contains(mode_names{i_m},'Choice')
            k.outcome='hit';
        else
            k.outcome='response';
        end
        
        %fetch selectivity
        
        avg_psth_left = movmean(cell2mat(fetchn(rel_PSTH & k_s & k & 'trial_type_name="l"','psth_avg')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        avg_psth_right = movmean(cell2mat(fetchn(rel_PSTH & k_s & k & 'trial_type_name="r"','psth_avg')) ,[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        
               
        
        proj_l = movmean((fetch1(rel_Proj & k_s & k_proj & k & 'trial_type_name="l"','proj_average')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        proj_r =  movmean((fetch1(rel_Proj & k_s & k_proj & k & 'trial_type_name="r"','proj_average')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        
          
        for i_t=1:1:numel(time_bins)
            idx_time = (time>= (time_bins(i_t)-time_window) & time<=time_bins(i_t));
            
                   
            % Trial-averaged variance explained
            total_var = sum(mean(avg_psth_left(:,idx_time),2).^2)+sum(mean(avg_psth_right(:,idx_time),2).^2);
            total_proj_var = mean(proj_l(:,idx_time),2).^2 + mean(proj_r(:,idx_time),2).^2;
            trialavg_v_explained(i_s,i_m,i_t) = total_proj_var./total_var; 
            
            
        end
    end
end

trialavg_var_explained.m = squeeze(mean(trialavg_v_explained,1));
trialavg_var_explained.stem = squeeze(std(trialavg_v_explained,1,1))./sqrt(numel(session_uid));

time2plot = time_bins;

