function [delta_spikes] = compute_stim_amp_full_pairwise2_mini (rel,Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, key)


min_num_trials_projected_correct = Param.parameter_value{(strcmp('min_num_trials_projected_correct',Param.parameter_name))};
min_num_trials_projected_error_or_ignore = Param.parameter_value{(strcmp('min_num_trials_projected_error_or_ignore',Param.parameter_name))};
min_num_trials_projected_response = Param.parameter_value{(strcmp('min_num_trials_projected_error_or_ignore',Param.parameter_name))};

min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};

if isfield(key,'outcome')
    if strcmp(key.outcome,'hit')
        min_num_trials_projected = min_num_trials_projected_correct;
    elseif strcmp(key.outcome,'response')
                min_num_trials_projected = min_num_trials_projected_response;
    else
        min_num_trials_projected = min_num_trials_projected_error_or_ignore;
    end
else
    min_num_trials_projected = min_num_trials_projected_correct;
end

hold on;
len = 0.4;
sz = [-200 200];

xdat = [0 0 len len];
ydat = [sz(1) sz(2) sz(2) sz(1)];


t_go = Param.parameter_value{(strcmp('t_go',Param.parameter_name))};
t_chirp1 = Param.parameter_value{(strcmp('t_chirp1',Param.parameter_name))};
t_chirp2 = Param.parameter_value{(strcmp('t_chirp2',Param.parameter_name))};
t_presample_stim = Param.parameter_value{(strcmp('t_presample_stim',Param.parameter_name))};
t_sample_stim = Param.parameter_value{(strcmp('t_sample_stim',Param.parameter_name))};
t_earlydelay_stim = Param.parameter_value{(strcmp('t_earlydelay_stim',Param.parameter_name))};
t_latedelay_stim = Param.parameter_value{(strcmp('t_latedelay_stim',Param.parameter_name))};
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
smooth_time = Param.parameter_value{(strcmp('smooth_time_proj_stimulus',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
mintrials_psth_typeoutcome= Param.parameter_value{(strcmp('mintrials_psth_typeoutcome',Param.parameter_name))};

time_idx_2plot = (time >=-4 & time<0.5);


plot([t_go t_go], sz, 'k-','LineWidth',0.75);
plot([t_chirp1 t_chirp1], sz, 'k-','LineWidth',0.75);
plot([t_chirp2 t_chirp2], sz, 'k-','LineWidth',0.75);

session_uid = unique(fetchn(rel,'session_uid'));

Proj=struct2table(fetch(rel,'*','ORDER BY session_uid DESC'));
trial_types = unique(Proj.trial_type_name,'stable');


counter=0;
for itype= 1:1:numel(trial_types)
    kk.trial_type_name=trial_types{itype};
    if kk.trial_type_name =='l'
        continue;
    end
%     if plot_r_flag==0
%         if kk.trial_type_name =='r'
%             continue;
%         end
%     end
    counter=counter+1;
    
        P = Proj(strcmp(trial_types{itype},Proj.trial_type_name),:);
    idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
        P=P(idx_include,:);
    
     if size(P,1)>0 %average across sessions
        %         Proj_avg=nanmean(P.proj_average(idx_include,:)-nanmean(P.proj_average(idx_include,time_idx_2plot),2),1);
                Proj_x=[];
        Proj_right=[];
        Proj_left=[];
        for is=1:1:size(P,1)
            
            kkk.session_uid=P.session_uid(is);
            
            Proj_right_temp=fetch1(rel & kkk & 'trial_type_name="r"' & 'outcome="response"','proj_average');
            Proj_right_temp = movmean(Proj_right_temp ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
            max_r=nanmax(Proj_right_temp(time>-4 & time<0));
            
            Proj_x(is,:) = movmean(P.proj_average(is,:) ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink')./max_r; %normalization
            Proj_right(is,:) = Proj_right_temp./max_r;
            
           Proj_left_temp=fetch1(rel & kkk & 'trial_type_name="l"' & 'outcome="response"','proj_average');
           Proj_left_temp = movmean(Proj_left_temp ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
           Proj_left(is,:) = Proj_left_temp./max_r;
 
        end
  
    else
        return
     end
    
     
     
     
    
%     
%     P = Proj(strcmp(trial_types{itype},Proj.trial_type_name),:);
%     trialtype_rgb = P.trialtype_rgb(1,:);
%     idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
%     add_NaN = zeros(numel(idx_include), 1);
%     add_NaN (idx_include==0) = NaN;
%     Proj_Stim = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink');
    
    stim_onset=P.stim_onset{1,:};
%     stim_duration=0.4;%P.stim_duration{1,:}+0.3;
        stim_duration=0.1;%P.stim_duration{1,:};

    
%     P = Proj(strcmp('l',Proj.trial_type_name),:);
%     idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
%     add_NaN (idx_include==0) = NaN;
%     %     Proj_Baseline=P.proj_average(idx_include,:);
%     Proj_Baseline = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink');
    
    STIM=(Proj_x-Proj_left);
    t_idx = (time>=stim_onset & time<stim_onset+stim_duration);
    delta_spikes(:,counter) = (nansum(STIM(:,t_idx),2)./sum(t_idx))*stim_duration;
    
    stim_onset_vector (counter) = stim_onset;
    %         plot(time,nanmean(STIM,1),'Color',trialtype_rgb, 'LineWidth', 1.25);
    
end


% % compute the amplitude for right trials, to normalize the activity to it
% P = Proj(strcmp('r',Proj.trial_type_name),:);
% stim_onset=P.stim_onset{1,:}+0.1;
% % stim_duration=0.4;
% stim_duration=P.stim_duration{1,:};
% 
% idx_include = (P.num_trials_projected >=min_num_trials_projected & P.num_units_projected >=min_num_units_projected);
% add_NaN = zeros(numel(idx_include), 1);
% add_NaN (idx_include==0) = NaN;
% Proj_right = movmean(P.proj_average ,[smooth_bins 0], 2, 'Endpoints','shrink');
% STIM_right=(Proj_right-Proj_Baseline);
% t_idx = (time>=stim_onset & time<stim_onset+stim_duration);
% delta_spikes_right = (nansum(STIM_right(:,t_idx),2)./sum(t_idx))*stim_duration + add_NaN;


[~,onset_order]=sort(stim_onset_vector);

delta_spikes = delta_spikes(:,onset_order);
stim_onset_vector = stim_onset_vector(onset_order);
if flag_normalize_modes==1
    mean_right=mean(delta_spikes(:,2));
    for i_types=1:1:size(delta_spikes,2)
    delta_spikes(:,i_types)=delta_spikes(:,i_types)./mean_right;
    end
%         delta_spikes(:,1)=delta_spikes(:,1)/mean(delta_spikes_right);
end
if plot_r_flag==0
    idx = [1,3,4];
    stim_onset_vector = stim_onset_vector(idx);
        delta_spikes = delta_spikes(:,idx);

end
ds_mean = nanmean(delta_spikes,1);
ds_stem = nanstd(delta_spikes,1)./sqrt(size(delta_spikes,1));

hold on
plot(stim_onset_vector, ds_mean,'.-','linewidth',2,'Color', colr);
errorbar(stim_onset_vector, ds_mean, ds_stem, '-', 'Color',colr,'CapSize',4,'MarkerSize',6);

% set(gca,'FontSize',12);
% delta_spikes(isnan(delta_spikes))=0;
% [p,~,stats] = anova1(delta_spikes,[],'off')
% [c,~,~,gnames] = multcompare(stats,'CType','lsd');

if numel(stim_onset_vector) ==3
    t = table( delta_spikes(:,1),delta_spikes(:,2),delta_spikes(:,3),...
        'VariableNames',{'meas1','meas2','meas3'});
    Time = stim_onset_vector';
    rm = fitrm(t,'meas1-meas3 ~ 1','WithinDesign',Time);
else numel(stim_onset_vector) ==4
    t = table( delta_spikes(:,1),delta_spikes(:,2),delta_spikes(:,3),delta_spikes(:,4),...
        'VariableNames',{'meas1','meas2','meas3','meas4'});
    Time = stim_onset_vector';
    rm = fitrm(t,'meas1-meas4 ~ 1','WithinDesign',Time);
end

ranovatbl = ranova(rm);
ranovatbl.pValue
if ranovatbl.pValue(1)<=0.05
    tbl = multcompare(rm,'Time','ComparisonType','bonferroni')
    text(-2.5,yl(2)+signif_display_offset,'*','FontSize',14,'Color',colr,'HorizontalAlignment','center');
end


% colr=[];
% if isfield(key,'trialtype_flag_full')
%     factor1=1+0.2*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
%     
%     colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
%     colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
%     colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');
%     
%     time1=[-2.5,-1.6,-0.8];
%     time2=[-2.1,-1.2,-0.4];
%     
%     for i_ss= 1:1:numel(time1)
%         plot([time1(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time1(i_ss), time1(i_ss)],[yl(2)*factor2,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time2(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor2],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%     end
%     
% else
%        
%     factor1=1+0.1*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
%     
%     colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-2.5Mini"','trialtype_rgb');
%     colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Mini"','trialtype_rgb');
%     colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Mini"','trialtype_rgb');
%     
%     time1=[-2.5,-1.6,-0.8];
%     time2=[-2.4,-1.5,-0.7];
%     
%     for i_ss= 1:1:numel(time1)
%         plot([time1(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time1(i_ss), time1(i_ss)],[yl(2)*factor2,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         plot([time2(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor2],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%     end
%     
% end
% 
% 

% Plot waves - full stimuli
colr=[];
x = 0:0.01:pi;
y_mini = repmat(sin(x),1); % mini
y_full = repmat(sin(x),4); % full

if  isfield(key,'trialtype_flag_full')
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
    
%     plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
    plot(linspace(-1.6, -1.5, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
    plot(linspace(-0.8, -0.7, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
    plot(linspace(-2.5, -2.4,  numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
end