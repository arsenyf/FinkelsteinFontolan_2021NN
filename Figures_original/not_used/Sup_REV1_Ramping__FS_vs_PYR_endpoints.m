function Sup_REV1_Ramping__FS_vs_PYR_endpoints() % MATLAB R2017a
close all;

mode_type_name ='Ramping Orthog.111';
% mode_type_name ='ChoiceMatched';

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'Sup5_Choice_Mode_ALM_full_distractor';
flag_plot_left_right_trials =1 % (0 both), (1 left), (2 right)

legends{1}.colr = [0 1 0.5]; % Distractor naive mice -mini
legends{2}.colr = [0.5 0 0.5]; % Distractor trained mice - mini
legends{3}.colr = [0.5 0 0.5]; % Distractor trained mice - full
legends{1}.title_label='Distractor-naive';
legends{1}.stimuli_label='weak';
legends{2}.title_label='Distractor-trained';
legends{2}.stimuli_label='weak';
legends{3}.title_label='Distractor-trained';
legends{3}.stimuli_label='strong';
legends{1}.title_offset=30;
legends{2}.title_offset=30;
legends{3}.title_offset=30;
legends{1}.title_xoffset=-0.1;
legends{2}.title_xoffset=-0.1;
legends{3}.title_xoffset=-0.1;

%Graphics
%---------------------------------
figure1=figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);

panel_width1=0.1;
panel_height1=0.09;
horizontal_distance1=0.13;
vertical_distance1=0.4;

position_x1(1)=0.12;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;

position_y1(1)=0.8;
position_y1(2)=position_y1(1)-vertical_distance1;
% position_y1(3)=position_y1(2)-vertical_distance1;
% position_y1(4)=position_y1(3)-vertical_distance1;
% position_y1(5)=position_y1(4)-vertical_distance1;


panel_width2=0.1;
panel_height2=0.09;
horizontal_distance2=0.15;
vertical_distance2=0.2;


position_x2(1)=0.05;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2*1.1;
position_x2(4)=position_x2(3)+horizontal_distance2;

position_y2(1)=0.6;
position_y2(2)=position_y2(1)-vertical_distance2;
% position_y2(3)=position_y2(2)-vertical_distance2;
% position_y2(4)=position_y2(3)-vertical_distance2;

Param = struct2table(fetch (ANL.Parameters,'*'));



colr=[];
colr{1}=[1 0 0];
colr{2}=[0 0 1];
numbins=linspace(-1.25,2.25,16);


Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};

min_num_units_projected = 6;

smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.1;
t2=0;
tidx = time>t1 & time<=t2;



%% Endpoints PYR


key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'PYR';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.is_outlier=0;
key.mode_type_name = mode_type_name;
% key.trial_type_name='r';

rel_PYR = ( ANL.ProjTrialNormalizedMedianNormalized11Pyr * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;

    
%% Endpoints FS

key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'FS';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'distractor';
key.session_flag_full = 1;
% key.is_outlier=0;
key.mode_type_name = mode_type_name;
% key.trial_type_name='r';

rel_FS = ( ANL.ProjTrialNormalizedMedianNormalized11FS * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* EXP.SessionTraining  * ANL.SessionGrouping & key & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession;


rel_trials = (EXP.TrialID & rel_PYR & rel_FS);

rel_PYR = rel_PYR & rel_trials;
rel_FS = rel_FS & rel_trials;


all_projs=cell2mat(fetchn(rel_PYR*EXP.TrialID & k,'proj_trial', 'ORDER BY trial_uid'));
all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints_PYR = nanmean(all_projs(:,tidx),2);


all_projs=cell2mat(fetchn(rel_FS*EXP.TrialID & k,'proj_trial', 'ORDER BY trial_uid'));
all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints_FS = nanmean(all_projs(:,tidx),2);

idx_not_nan = ~isnan(endpoints_PYR+endpoints_FS);


endpoints_PYR = endpoints_PYR (idx_not_nan);
endpoints_FS = endpoints_FS (idx_not_nan);

idx_not_inf = ~((endpoints_PYR+endpoints_FS)==inf | (endpoints_PYR+endpoints_FS)==-inf);

endpoints_PYR = endpoints_PYR (idx_not_inf);
endpoints_FS = endpoints_FS (idx_not_inf);

% isoutlier_PYR = isoutlier(endpoints_PYR)
% isoutlier_FS = isoutlier(endpoints_FS);
% 
% endpoints_PYR = endpoints_PYR (~isoutlier_PYR & ~isoutlier_FS);
% endpoints_FS = endpoints_FS (~isoutlier_PYR & ~isoutlier_FS);



axes('position',[position_x2(3), position_y2(2), panel_width2, panel_height2]);
hold on;
plot(rescale(endpoints_PYR), rescale(endpoints_FS),'.')
r=corr([endpoints_PYR,endpoints_FS]);
xlabel(sprintf('Putative Pyramidal cells,\nRamping mode \n (normalized)'));
ylabel(sprintf('Putative F.S. interneurons,\nRamping mode\n (normalized)'));
title(sprintf('Single-trial \nendpoints r = %.2f',r(2)))

if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




