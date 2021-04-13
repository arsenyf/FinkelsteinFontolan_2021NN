function SupXXX_single_trials_endpoints2() % MATLAB R2017a
clf;
dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'SupXXX_single_trials_endpoints2';

mode_type_name='ChoiceMatched';
%% Endpoints
colr{1}=[1 0 0];
colr{2}=[0 0 1];


Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};

min_num_units_projected = Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};
min_num_trials=5;

smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.2
t2=0;
tidx = time>t1 & time<=t2;

numbins=linspace(-2,3,15);


key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.subject_id=353936; key.session=5; %1,4,5 %5 maybe
%key.subject_id=365939; %key.session=3; %1,2,3,4 %3 good
%key.subject_id=365938; %key.session=4; %1,2,3,4 % 4 good
%key.subject_id=353938; %.session=4; %1,3,4,5,6 % 4 good; 1,5 ok

% key.is_outlier=0;
key.mode_type_name = mode_type_name;



rel = ( ANL.ProjTrialNormalizedMedianNormalized101 * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;

session_uid=unique(fetchn(rel,'session_uid'));

subplot(2,2,1)
hold on;

k.trial_type_name='l';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',colr{1},'markeredgecolor',colr{1},'markerfacecolor',colr{1},'linewidth',1});


k.trial_type_name='r';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',colr{2},'markeredgecolor',colr{2},'markerfacecolor',colr{2},'linewidth',1});


ylim([0, nanmax([xmean1,xmean2])*1.2+eps]);
title('Distractor-trained, control trials')

% subplot(2,2,2)
% hold on;
% 
% k.trial_type_name='l';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-r');
% 
% k.trial_type_name='r';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-b');
dt = 0; % if we don't want to look at the end of delay
t1=t1 - dt;
t2=t2 - dt;
tidx = time>t1 & time<=t2;


% subplot(2,2,3)
hold on;

k.trial_type_name='l_-1.6Full';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',colr{1}*0.5,'markeredgecolor',colr{1}*0.5,'markerfacecolor',colr{1}*0.5,'linewidth',1});

k.trial_type_name='l_-1.6Full';
k.outcome='miss';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',colr{2}*0.5,'markeredgecolor',colr{2}*0.5,'markerfacecolor',colr{2}*0.5,'linewidth',1});

ylim([0, nanmax([xmean1,xmean2])*1.2+eps]);

title('Distractor-trained, Early-delay trials')


%% Distractor naive


key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'regular';
k.session_flag_mini = 1;
% key.session_flag_full = 1;
% key.subject_id=353936; key.session=5; %1,4,5 %5 maybe
%key.subject_id=365939; %key.session=3; %1,2,3,4 %3 good
%key.subject_id=365938; %key.session=4; %1,2,3,4 % 4 good
%key.subject_id=353938; %.session=4; %1,3,4,5,6 % 4 good; 1,5 ok

% key.is_outlier=0;
key.mode_type_name = mode_type_name;



rel = ( ANL.ProjTrialNormalizedMedianNormalized101 * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=6' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;

session_uid=unique(fetchn(rel,'session_uid'));

subplot(2,2,2)
hold on;

k.trial_type_name='l';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',colr{1},'markeredgecolor',colr{1},'markerfacecolor',colr{1},'linewidth',1});


k.trial_type_name='r';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',colr{2},'markeredgecolor',colr{2},'markerfacecolor',colr{2},'linewidth',1});


ylim([0, nanmax([xmean1,xmean2])*1.2+eps]);

title('Distractor-naive, Control trials')

% subplot(2,2,2)
% hold on;
% 
% k.trial_type_name='l';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-r');
% 
% k.trial_type_name='r';
% k.outcome='miss';
% x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
% x=nanmean(x);
% plot(numbins(1:end-1),x,'-b');
dt = 0; % if we don't want to look at the end of delay
t1=t1 - dt;
t2=t2 - dt;
tidx = time>t1 & time<=t2;


% subplot(2,2,4)
hold on;

k.trial_type_name='l_-1.6Mini';
k.outcome='hit';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean1=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean1,xstd,'lineprops',{'-','Color',colr{1}*0.75,'markeredgecolor',colr{1}*0.75,'markerfacecolor',colr{1}*0.75,'linewidth',1});

k.trial_type_name='l_-1.6Mini';
k.outcome='miss';
x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials);
xmean2=nanmean(x);
xstd=nanstd(x)./sqrt(size(x,2));
shadedErrorBar(numbins(1:end-1),xmean2,xstd,'lineprops',{'-','Color',colr{2}*0.75,'markeredgecolor',colr{2}*0.75,'markerfacecolor',colr{2}*0.75,'linewidth',1});

ylim([0, nanmax([xmean1,xmean2])*1.2+eps]);


title('Distractor-naive, Early-delay trials')

if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename mode_type_name key.training_type];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
savefig(figure_name_out)


end




