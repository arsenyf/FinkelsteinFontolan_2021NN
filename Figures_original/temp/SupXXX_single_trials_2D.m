function SupXXX_single_trials_2D() % MATLAB R2017a
close all;
tic
dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'SupXXX_single_trials_2D';


Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};



min_num_units_projected = 5; %Param.parameter_value{(strcmp('min_num_units_projected',Param.parameter_name))};


% axes('position',[position_x1(1), position_y1(3), panel_width1, panel_height1]);
smooth_time = 0.4;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.mode_weights_sign='all';
% k.trial_type_name='l_-1.6Full';
%  key.subject_id=353938; key.session=4; %1,3,4,5,6 % 4 good; 1,5 ok
key.subject_id=353938; key.session=6; %1,3,4,5,6 % 4 good; 1,5 ok
% key.flag_outlier=0;
% key.subject_id=353936;

rel_Proj = (ANL.ProjTrialNormalizedMedianNormalized11 * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName & key & sprintf('num_units_projected>=%d', min_num_units_projected)) ;

flag_plot_errors=0;
k.trial_type_name='l';
fn_2D_single_trials (rel_Proj, k, smooth_bins,time, flag_plot_errors)

flag_plot_errors=0;
k.trial_type_name='r';
fn_2D_single_trials (rel_Proj, k, smooth_bins,time, flag_plot_errors)

flag_plot_errors=1;
k.trial_type_name='l_-1.6Full';
fn_2D_single_trials (rel_Proj, k, smooth_bins,time, flag_plot_errors)


xlabel('Choice (a.u.)');
ylabel('Ramping (a.u.)');
% axis equal
axis tight;
% set(gca,'FontSize',12,'XLim',[-1,2],'XTick',[0,1],'YLim',[-1,2],'YTick',[0,1]);


figure


%% Endpoints
smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.4;
t2=0;
tidx = time>t1 & time<=t2;



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
%key.subject_id=353936; %key.session=5; %1,4,5 %5 maybe
%key.subject_id=365939; %key.session=3; %1,2,3,4 %3 good
%key.subject_id=365938; %key.session=4; %1,2,3,4 % 4 good
%key.subject_id=353938; %.session=4; %1,3,4,5,6 % 4 good; 1,5 ok

key.flag_outlier=0;
key.mode_type_name = 'LateDelay';

numbins=linspace(-2,2,40);


rel = ( ANL.ProjTrialNormalizedMedianNormalized4 * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) ;
subplot(2,2,1)
hold on;
k.trial_type_name='l';
k.outcome='hit';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)



hold on;
k.trial_type_name='r';
k.outcome='hit';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)

subplot(2,2,2)

hold on;
k.trial_type_name='l';
k.outcome='miss';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)

hold on;
k.trial_type_name='r';
k.outcome='miss';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)

subplot(2,2,3)
hold on;
k.trial_type_name='l_-1.6Full';
k.outcome='hit';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)

hold on;
k.trial_type_name='l_-1.6Full';
k.outcome='miss';
all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs1_hit(:,tidx),2);
histogram(endpoints,numbins)

if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
savefig(figure_name_out)


end




