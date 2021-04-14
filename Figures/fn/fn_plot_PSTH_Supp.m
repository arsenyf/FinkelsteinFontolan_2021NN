function  fn_plot_PSTH_Supp (Param, outcome, trialtype_flag_standard, trialtype_flag_left_and_control_right_nopresample,trialtype_flag_mini, trialtype_flag_full, key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label )

rel1 = (EXP.Session * EXP.SessionID * EPHYS.Unit * EPHYS.UnitCellType * EPHYS.UnitPosition * ANL.UnitFiringRate * ANL.UnitISI * EPHYS.UnitWaveform) & key_u;
Unit = fetch(rel1,'*');
rel2 = (EXP.SessionID * EPHYS.Unit* ANL.PSTHAverage * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction * ANL.TrialTypeStimTime) & key_u;
PSTH = struct2table(fetch(rel2,'*', 'ORDER BY trialtype_plot_order DESC'));


xl=[-2.8 0];

PSTH = PSTH((strcmp(outcome, PSTH.outcome)),:);
% if ~isempty(trial_instruction)
%     PSTH = PSTH((strcmp(trial_instruction, PSTH.trial_instruction)),:);
% end
if ~isempty(trialtype_flag_standard)
    PSTH = PSTH((trialtype_flag_standard== PSTH.trialtype_flag_standard),:);
end
if ~isempty(trialtype_flag_left_and_control_right_nopresample)
    PSTH = PSTH((trialtype_flag_left_and_control_right_nopresample== PSTH.trialtype_flag_left_and_control_right_nopresample),:);
end
if ~isempty(trialtype_flag_mini)
    PSTH = PSTH((trialtype_flag_mini== PSTH.trialtype_flag_mini),:);
end
if ~isempty(trialtype_flag_full)
    PSTH = PSTH((trialtype_flag_full== PSTH.trialtype_flag_full),:);
end



hold on;

t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
t_presample_stim = Param.parameter_value{(strcmp('t_presample_stim',Param.parameter_name))};
t_sample_stim = Param.parameter_value{(strcmp('t_sample_stim',Param.parameter_name))};
t_earlydelay_stim = Param.parameter_value{(strcmp('t_earlydelay_stim',Param.parameter_name))};
t_latedelay_stim = Param.parameter_value{(strcmp('t_latedelay_stim',Param.parameter_name))};
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_cell_psth_choice',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
mintrials_psth_typeoutcome= 1; %Param.parameter_value{(strcmp('mintrials_psth_typeoutcome',Param.parameter_name))};

idx_few_trials = find(PSTH.num_trials_averaged <mintrials_psth_typeoutcome);


%     fill(t_presample_stim+xdat, ydat, [0 0 0], 'FaceAlpha', 0.12, 'LineStyle', 'None');
%     fill(t_sample_stim+xdat, ydat, [0 0 0], 'FaceAlpha', 0.12, 'LineStyle', 'None');
%     fill(t_earlydelay_stim+xdat, ydat, [0 0 0], 'FaceAlpha', 0.12, 'LineStyle', 'None');
%     fill(t_latedelay_stim+xdat, ydat, [0 0 0], 'FaceAlpha', 0.12, 'LineStyle', 'None');


sz = [0 200];
ydat = [sz(1) sz(2) sz(2) sz(1)];
for itype = 1:1:size(PSTH.trial_type_name,1)
    stim_onset=PSTH.stim_onset{itype,:};
    stim_duration=PSTH.stim_duration{itype,:};
    for istim=1:1:numel(stim_onset)
        xdat = [0 0 stim_duration(istim) stim_duration(istim)];
        if stim_duration<0.4
            fill([stim_onset(istim) + xdat], ydat, [0.5 0.75 0.9], 'LineStyle', 'None');
        else
            fill([stim_onset(istim) + xdat], ydat, [0.6 0.85 1], 'LineStyle', 'None');
        end
    end
end


plot([t_go t_go], sz, 'k-','LineWidth',0.75);
plot([t_chirp1 t_chirp1], sz, 'k-','LineWidth',0.75);
plot([t_chirp2 t_chirp2], sz, 'k-','LineWidth',0.75);


blank=zeros(size(PSTH.trial_type_name));
blank(idx_few_trials)=NaN;
for itype = 1:1:size(PSTH.trial_type_name,1)
    psth_smooth=  movmean(PSTH.psth_avg(itype,:),[smooth_bins 0], 2, 'omitnan','Endpoints','shrink') + blank(itype);
    temp_max(itype)=nanmax(psth_smooth(time>xl(1) & time<=0));
    rand_jitter=(Unit.peak_fr_sample_delay*rand(1))/25;
    plot(time,psth_smooth+rand_jitter, 'Color', PSTH.trialtype_rgb(itype,:), 'LineWidth', 1);
end
yl=[0 ceil(nanmax(temp_max))];
xlim(xl);
ylim(yl);

if xlabel_flag==1
    set(gca,'FontSize',7,'Xtick',[-2 0],'TickDir','out');
    text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.25,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
else
    set(gca,'FontSize',7,'Xtick',[-2 0],'XtickLabel',[],'TickDir','out');
end

if ylabel_flag==1
    text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*0.5,'Spikes s^{-1}', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
end


if isempty(cell_title)
    text(xl(1)+diff(xl)*0.2, yl(1)+diff(yl)*1.35,sprintf('Cell %d %s', unit_counter, cell_title), 'FontSize',7,'HorizontalAlignment','center');
else
    text(xl(1)+diff(xl)*0.2, yl(1)+diff(yl)*1.35,sprintf('Cell %d \n%s', unit_counter, cell_title), 'FontSize',7,'HorizontalAlignment','center');
end
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.3, cell_label, ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

% if stim_legend_flag==1
%     
%     if ~isempty(trialtype_flag_full)
%     factor1=1+0.2*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
% 
%         colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
%         colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
%         colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');
%         
%         time1=[-2.5,-1.6,-0.8];
%         time2=[-2.1,-1.2,-0.4];
% 
%         for i_ss= 1:1:numel(time1)
%             plot([time1(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%             plot([time1(i_ss), time1(i_ss)],[yl(2)*factor2,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%             plot([time2(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor2],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         end
%     
%     else
%     factor1=1+0.2*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
%         time1=-2.5;
%         time2=-2.1;
%         colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
%         plot([time1, time2],[yl(2)*factor1,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
%         plot([time1, time1],[yl(2)*factor2,yl(2)*factor1],'Color',colr{1},'LineWidth',1,'Clipping','off')
%         plot([time2, time2],[yl(2)*factor1,yl(2)*factor2],'Color',colr{1},'LineWidth',1,'Clipping','off')
%         
%     factor1=1+0.1*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
%         
%         colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-2.5Mini"','trialtype_rgb');
%         colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Mini"','trialtype_rgb');
%         colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Mini"','trialtype_rgb');
% 
%         time1=[-2.5,-1.6,-0.8];
%         time2=[-2.4,-1.5,-0.7];
% 
%         for i_ss= 1:1:numel(time1)
%              plot([time1(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time1(i_ss), time1(i_ss)],[yl(2)*factor2,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time2(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor2],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         end
% 
%     end
% end
if stim_legend_flag==1
    % Plot waves - full stimuli
    x = 0:0.01:pi;
    y_mini = repmat(sin(x),1); % mini
    y_full = repmat(sin(x),4); % full
    
    if ~isempty(trialtype_flag_full)
        factor=diff(yl)/6;
        
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
        colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-1.6, -1.2, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-0.8, -0.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
    else
        factor=diff(yl)/6;
        
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Mini"','trialtype_rgb');
        colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Mini"','trialtype_rgb');
        colr{4}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-2.5Mini"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-1.6, -1.5, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-0.8, -0.7, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-2.5, -2.4,  numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
    end
end