function  POUT = fn_plotProjection_for_figure3 (Param, rel, key, trial_type_substract, ylab, mode_names_titles, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag)
hold on;


min_num_trials_projected_correct = 10; %Param.parameter_value{(strcmp('min_num_trials_projected_correct',Param.parameter_name))};
min_num_trials_projected_error_or_ignore = Param.parameter_value{(strcmp('min_num_trials_projected_error_or_ignore',Param.parameter_name))};
min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};


min_num_trials_projected = min_num_trials_projected_correct;


hold on;
sz = [-200 200];


t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
t_presample_stim = Param.parameter_value{(strcmp('t_presample_stim',Param.parameter_name))};
t_sample_stim = Param.parameter_value{(strcmp('t_sample_stim',Param.parameter_name))};
t_earlydelay_stim = Param.parameter_value{(strcmp('t_earlydelay_stim',Param.parameter_name))};
t_latedelay_stim = Param.parameter_value{(strcmp('t_latedelay_stim',Param.parameter_name))};
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
mintrials_psth_typeoutcome= Param.parameter_value{(strcmp('mintrials_psth_typeoutcome',Param.parameter_name))};

time_idx_2plot = (time >=-4 & time<-3.8);


plot([t_go t_go], sz, 'k-','LineWidth',0.75);
plot([t_chirp1 t_chirp1], sz, 'k-','LineWidth',0.75);

% idx_few_trials = find(PSTH.num_trials_averaged <mintrials_psth_typeoutcome);
% blank=zeros(size(PSTH.trial_type_name));
% blank(idx_few_trials)=NaN;

% trialtype_uid = unique(PSTH.trialtype_uid,'stable');
% trialtype_name = unique(PSTH.trial_type_name,'stable');
% trialtype_plot_order = unique(PSTH.trialtype_plot_order,'stable');
% for itype = sort(trialtype_plot_order,'descend')'
%     ix=trialtype_plot_order==itype;
% end
%

proj_min = 0;
proj_max = 0;

rel_correct=rel & 'trial_type_name="r"' & 'outcome="hit"' & 'trialtype_flag_left_stim_full_nopresample=1'; % correct right trial
Proj1=(fetch(rel_correct,'*','ORDER BY trialtype_plot_order DESC'));

rel_error=rel & 'outcome="miss"' & 'trialtype_flag_left_stim_full_nopresample_no_right=1'; % error full distractor left trial
Proj2=(fetch(rel_error,'*','ORDER BY trialtype_plot_order DESC'));

Proj=struct2table([Proj1;Proj2]);
trial_types = unique(Proj.trial_type_name,'stable');

if sum(contains(trial_types,'r_-2.5FullX2'))>0
    min_num_trials_projected=5;
end

ydat = [sz(1) sz(2) sz(2) sz(1)];


% Plotting just the stimulation time (vertical bars)
if stim_time_flag==1
    for itype = 1:1:size(trial_types)
        trial_type_name=trial_types{itype};
        if plot_r_flag==0
            if trial_type_name =='r'
                continue;
            end
        end
        P = Proj(strcmp(trial_types{itype},Proj.trial_type_name),:);
        
        stim_onset=P.stim_onset{1,:};
        stim_duration=P.stim_duration{1,:};
        for istim=1:1:numel(stim_onset)
            xdat = [0 0 stim_duration(istim) stim_duration(istim)];
            if stim_duration<0.4
                fill([stim_onset(istim) + xdat], ydat, [0.5 0.75 0.9], 'LineStyle', 'None');
            else
                fill([stim_onset(istim) + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
            end
        end
    end
end

P=[];
for itype= 1:1:numel(trial_types)
    P = Proj(strcmp(trial_types{itype},Proj.trial_type_name),:);
%     idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
    idx_include =([1,   1,   1,   0,   0,   0,   1,   0,   1,   1,   1,   1,   0,   0,   0,   0]')>0;
    if size(P,1)>1 %average across sessions
        %         Proj_avg=nanmean(P.proj_average(idx_include,:)-nanmean(P.proj_average(idx_include,time_idx_2plot),2),1);
        Proj_avg=nanmean(P.proj_average(idx_include,:),1);
        
    else %single session
        Proj_avg=P.proj_average(idx_include,:);
    end
    Proj_smooth = movmean(Proj_avg ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
    
    Proj_smooth_substract=0;
    if ~isempty(trial_type_substract)
        P_substract = Proj(strcmp(trial_type_substract,Proj.trial_type_name),:);
        Proj_avg_substract=nanmean(P_substract.proj_average,1);
        Proj_smooth_substract = movmean(Proj_avg_substract ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
    end
    Proj_to_plot = Proj_smooth-Proj_smooth_substract;
    %         if ~isempty(Proj_to_plot)
    %         plot(time,Proj_to_plot,'Color',P.trialtype_rgb(1,:), 'LineWidth', 1.25);
    %         end
    %     baseline = mean(Proj_to_plot(time_idx_2plot));
    if ~isempty(Proj_to_plot)
        %         plot(time,Proj_to_plot,'Color',P.trialtype_rgb(1,:), 'LineWidth', 1.25);
        POUT.p(itype,:) = Proj_to_plot;
    end
    POUT.rgb(itype,:) = P.trialtype_rgb(1,:);
    POUT.trial_types{itype} = trial_types{itype};
    %     if isempty(stim_onset)
    %         POUT.stim_onset_time(itype,1) =  NaN;
    %         POUT.stim_onset_idx(itype,1) =NaN;
    %         POUT.stim_onset_time(itype,2) =  NaN;
    %         POUT.stim_onset_idx(itype,2) =NaN;
    %     else
    %         POUT.stim_onset_time(itype,1)  = stim_onset(1);
    %         POUT.stim_onset_idx(itype,1)  = find(time(tidx)>=stim_onset(1),1);
    %         POUT.stim_onset_time(itype,2)  = stim_onset(end);
    %         POUT.stim_onset_idx(itype,2)  = find(time(tidx)>=stim_onset(end),1);
    %     end
end

% key_trial.trial_type_name='r';
Proj_right=struct2table(fetch( rel_correct,'proj_average','*'));
% idx_include = (Proj_right.num_trials_projected >=min_num_trials_projected & Proj_right.num_units_projected >=min_num_units_projected);
Proj_right=nanmean(Proj_right.proj_average(idx_include,:),1);
Proj_right = movmean(Proj_right ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');


if flag_normalize_modes==1
    idx_pure_r = find(strcmp('r',POUT.trial_types));
    %     POUT.p = POUT.p./nanmax(POUT.p(idx_pure_r,:));
    POUT.p = POUT.p./nanmax(Proj_right(time>-4 & time<0));
    
    %         POUT.p = POUT.p./nanmax(POUT.p(:));
end

for itype= 1:1:numel(trial_types)
    if plot_r_flag==0
        if POUT.trial_types{itype} =='r'
            continue;
        end
    end
    if ~exist('line_style')
        line_style='-';
    end
    random_jitter=rand(1)/15;
    plot(time,POUT.p(itype,:)+random_jitter,'Color',POUT.rgb(itype,:) ,'LineWidth',0.75,'LineStyle',line_style);
end

plot([t_chirp2 t_chirp2], sz, 'k-','LineWidth',0.75);

