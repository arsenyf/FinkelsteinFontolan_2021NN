function [OUT, GP] = compute_stim_kinetics_modes (rel,Param, colr, flag_normalize_modes)

% key_mode.mode_type_name = 'Stimulus Orthog.';
key_mode.mode_type_name = 'LateDelay';

key_mode.outcome='hit';
min_num_trials_projected_correct =Param.parameter_value{(strcmp('min_num_trials_projected_correct',Param.parameter_name))};
min_num_trials_projected_error_or_ignore = Param.parameter_value{(strcmp('min_num_trials_projected_error_or_ignore',Param.parameter_name))};
min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};

if strcmp(key_mode.outcome,'hit')
    min_num_trials_projected = min_num_trials_projected_correct;
else
    min_num_trials_projected = min_num_trials_projected_error_or_ignore;
end

hold on;
len = 0.4;
sz = [-200 200];

xdat = [0 0 len len];
ydat = [sz(1) sz(2) sz(2) sz(1)];

plot([-5,5],[0,0],'-k','LineWidth',1);

time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);

Proj=struct2table(fetch(rel & key_mode,'*','ORDER BY session_uid DESC'));
trial_types = unique(Proj.trial_type_name,'stable');


counter=0;
STIM=[];
for itype= 1:1:numel(trial_types)
    kk.trial_type_name=trial_types{itype};
    if kk.trial_type_name =='l'
        continue;
    end
    if kk.trial_type_name(1) =='r'
        continue;
    end
    counter=counter+1;
    
    P = Proj(strcmp(trial_types{itype},Proj.trial_type_name),:);
    trialtype_rgb = P.trialtype_rgb(1,:);
    idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
    
    
    add_NaN = zeros(numel(idx_include), 1);
    add_NaN (idx_include==0) = NaN;
    Proj_Stim = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink');
    
    stim_onset=P.stim_onset{1,:};
 
    %Baseline
    P = Proj(strcmp('l',Proj.trial_type_name),:);
    idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
    add_NaN (idx_include==0) = NaN;
    Proj_Baseline = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink');
    
    if flag_normalize_modes==1
        %Normalization to right trial
        P = Proj(strcmp('r',Proj.trial_type_name),:);
        idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
        add_NaN (idx_include==0) = NaN;
        Proj_Right = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink') - Proj_Baseline;
%         Proj_Right_max = nanmax(Proj_Right(:,(time<0 & time>=-3)),[],2);
        Proj_Right_max = nanmax(nanmean(Proj_Right(:,time>-4 & time<2),1));
        S = (Proj_Stim-Proj_Baseline)/(Proj_Right_max) ;
%         S = (Proj_Stim-Proj_Baseline)./repmat(Proj_Right_max,1,length(time)) ;
        
        t_idx = time>=(stim_onset-0.5) & time<(stim_onset+4);
        add_NaN_aftert_go_cue = zeros(size(S,1) ,sum(t_idx));
        add_NaN_aftert_go_cue(:,time(t_idx)>=0)=NaN;
        idx = size(STIM,1);
        STIM ((idx+1):(idx+size(S,1)),:)  = S(:,t_idx) +add_NaN_aftert_go_cue +repmat(add_NaN,1,sum(t_idx));
        
    else
        S = Proj_Stim;
        t_idx = time>=(stim_onset-0.5) & time<(stim_onset+4);
        add_NaN_aftert_go_cue = zeros(size(S,1) ,sum(t_idx));
        add_NaN_aftert_go_cue(:,time(t_idx)>=0)=NaN;
        idx = size(STIM,1);
        STIM ((idx+1):(idx+size(S,1)),:)  = (S(:,t_idx)- Proj_Baseline(:,t_idx)) +add_NaN_aftert_go_cue +repmat(add_NaN,1,sum(t_idx));
        
    end
    
    
    stim_onset_vector (counter) = stim_onset;
    %         plot(time,nanmean(STIM,1),'Color',trialtype_rgb, 'LineWidth', 1.25);
    
end
% STIM = movmean(STIM ,[smooth_bins 0], 2, 'omitnan', 'Endpoints','shrink');

STIM_mean=nanmean(STIM,1);
STIM_std=nanstd(STIM,1,1)./sqrt(size(STIM,1));

% STIM=nanmean(STIM,3);
% a = STIM(:,:,3);
% STIM=nanmean(a,1);

relative_time = time(1:1:sum(t_idx));
relative_time = relative_time - relative_time(1) -0.5;
shadedErrorBar(relative_time,STIM_mean,STIM_std,'lineprops',{'-','Color',colr,'markeredgecolor',colr,'markerfacecolor',colr,'linewidth',1});

% plot(relative_time,STIM,'Color',colr)

% figure
% 
% plot(time,nanmean(Proj_Stim))
% plot(time,nanmean(Proj_Baseline))
