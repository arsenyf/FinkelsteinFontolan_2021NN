function  [xl,yl]=figure_plot_vs1_stimulus(rel, k, label_flag,plot_r_flag)

% fetch Param
Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_cell_psth_stimulus',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
hold on
trial_types =unique(fetchn(rel,'trial_type_name'));
sz = [-200 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
for itype = 1:1:size(trial_types)
    kk.trial_type_name=trial_types{itype};
    if plot_r_flag==0
        if kk.trial_type_name =='r'
            continue;
        end
    end
    stim_duration = fetch1(ANL.TrialTypeStimTime & kk, 'stim_duration');
    stim_onset = fetch1(ANL.TrialTypeStimTime & kk, 'stim_onset');
    for istim=1:1:numel(stim_onset)
        xdat = [0 0 stim_duration(istim) stim_duration(istim)];
        fill([stim_onset(istim) + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
    end
end
plot([t_go t_go], sz, 'k-','LineWidth',0.75);
plot([-5 5], [0 0], 'k-','LineWidth',0.75);
plot([t_chirp1 t_chirp1], sz, 'k-','LineWidth',0.75);
plot([t_chirp2 t_chirp2], sz, 'k-','LineWidth',0.75);


yl=0;
session_uid =unique(fetchn(rel,'session_uid'));

for itype = 1:1:size(trial_types)
    kk.trial_type_name=trial_types{itype};
    if kk.trial_type_name =='l'
        continue;
    end
    if plot_r_flag==0
        if kk.trial_type_name =='r'
            continue;
        end
    end
    for i_s = 1:1:numel(session_uid)
        kk.trial_type_name=trial_types{itype};
        kk.session_uid = session_uid (i_s);
        trialtype_rgb = fetch1(ANL.TrialTypeGraphic & kk, 'trialtype_rgb');
        PSTH_Stim = movmean( cell2mat(fetchn((rel & k) & kk, 'psth_avg', 'ORDER BY unit_uid')),[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
        
        kk.trial_type_name='l';
        PSTH_Baseline = movmean(cell2mat(fetchn((rel & k) & kk, 'psth_avg', 'ORDER BY unit_uid')),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink');
        STIM_sess(i_s,:)=nanmean((PSTH_Stim-PSTH_Baseline),1);
    end
    STIM=nanmean(STIM_sess,1);
    plot(time,STIM,'Color',trialtype_rgb, 'LineWidth',0.75);
    yl = [nanmin([STIM,yl]) nanmax([STIM,yl])];
end


xl=[-2.9 1];
xlim(xl);
ylim([floor(yl(1)),ceil(yl(2))]);
set(gca,'XTick',[-2 0],'XtickLabel',[],'FontSize',6,'TickDir','out');


factor=5;
% Plot waves - full stimuli
x = 0:0.01:pi;
y = repmat(sin(x),4);
plot(linspace(-2.5, -2.1, 4*numel(x)),y*(factor)+20,'Color',[0.6 0.85 1],'LineWidth',0.5,'Clipping','off')
plot(linspace(-1.6, -1.2, 4*numel(x)),y*(factor)+20,'Color',[0.6 0.85 1],'LineWidth',0.5,'Clipping','off')
plot(linspace(-0.8, -0.4, 4*numel(x)),y*(factor)+20,'Color',[0.6 0.85 1],'LineWidth',0.5,'Clipping','off')
