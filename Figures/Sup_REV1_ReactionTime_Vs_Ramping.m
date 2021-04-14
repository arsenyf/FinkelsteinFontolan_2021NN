function Sup_REV1_ReactionTime_Vs_Ramping()
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_ReactionTime_Vs_Ramping';


%% Graphics
figure
set(gcf,'DefaultAxesFontSize',7);
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 0 30 24]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[0 0 0 0]);

panel_width=0.15;
panel_height=0.13;
horizontal_distance=0.25;
vertical_distance=0.3;

position_x(1)=0.1;
position_x(2)=position_x(1)+horizontal_distance;
position_x(3)=position_x(2)+horizontal_distance;
position_x(4)=position_x(3)+horizontal_distance;
position_x(5)=position_x(4)+horizontal_distance;
position_x(6)=position_x(5)+horizontal_distance;

position_y(1)=0.7;
position_y(2)=position_y(1)-vertical_distance;
position_y(3)=position_y(2)-vertical_distance;
position_y(4)=position_y(3)-vertical_distance;
position_y(5)=position_y(4)-vertical_distance;


Param = struct2table(fetch (ANL.Parameters,'*'));
time = Param.parameter_value{(strcmp('psth_t_vector',Param.parameter_name))};
psth_time_bin = Param.parameter_value{(strcmp('psth_time_bin',Param.parameter_name))};
min_num_units_projected = 6;
smooth_time = 0;%Param.parameter_value{(strcmp('smooth_time_proj_single_trial_normalized',Param.parameter_name))};
smooth_bins=ceil(smooth_time/psth_time_bin);
t1=-0.1;
t2=0;
tidx = time>t1 & time<=t2;



%% Ramping endpoints vs RT
key=[];
k=[];
key.brain_area = 'ALM';
key.hemisphere = 'left';
key.cell_type = 'Pyr';
key.unit_quality = 'all';
key.mode_weights_sign='all';
key.training_type = 'regular';
k.trialtype_left_and_right_no_distractors = 1;
key.mode_type_name ='Ramping Orthog.111';

% key.is_outlier=0;

rel_Ramping_RT = ( EXP.TrialID*ANL.ProjTrialNormalizedMedianNormalized11Pyr*ANL.ReactionTimeElectric * EXP.SessionID * EXP.BehaviorTrial * EXP.TrialName* ANL.TrialTypeID * ANL.TrialTypeGraphic * EXP.SessionTraining  * ANL.SessionGrouping & key  & sprintf('num_units_projected>=%d', min_num_units_projected)) & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0')- ANL.ExcludeSession & k;

all_projs=cell2mat(fetchn(rel_Ramping_RT& k,'proj_trial', 'ORDER BY trial_uid'));
all_projs = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
endpoints = nanmean(all_projs(:,tidx),2);

reaction_time_electric=fetchn(rel_Ramping_RT& k,'reaction_time_electric', 'ORDER BY trial_uid');


outcome=fetchn(rel_Ramping_RT& k,'outcome', 'ORDER BY trial_uid');

idx_not_nan = ~isnan(endpoints+reaction_time_electric);
endpoints = endpoints (idx_not_nan);
reaction_time_electric = reaction_time_electric (idx_not_nan);
outcome = outcome (idx_not_nan);

idx_not_inf = ~(endpoints==inf | endpoints==-inf);
endpoints = endpoints (idx_not_inf);
reaction_time_electric = reaction_time_electric (idx_not_inf);
outcome = outcome (idx_not_inf);

isoutlier_endpoint = isoutlier(endpoints);
isoutlier_RT = isoutlier(reaction_time_electric);

endpoints = endpoints (~isoutlier_endpoint & ~isoutlier_RT);
reaction_time_electric = reaction_time_electric (~isoutlier_endpoint & ~isoutlier_RT);
outcome = outcome (~isoutlier_endpoint & ~isoutlier_RT);


axes('position',[position_x(1), position_y(1), panel_width, panel_height]);
hold on;
plot(rescale(endpoints), reaction_time_electric,'.')
r=corr([endpoints,reaction_time_electric]);
xlabel(sprintf('Ramping mode endpoints\n (normalized)'));
ylabel(sprintf('Reaction time (s)'));
title(sprintf('Single-trial \nRamping mode vs. reaction time r = %.2f',r(2)))


lm=fitlm(endpoints,reaction_time_electric)


correct_trials = strcmp(outcome,'hit');
endpoints_correct = endpoints(correct_trials);
RT_correct =  reaction_time_electric (correct_trials);

error_trials = strcmp(outcome,'miss');
endpoints_error = endpoints(error_trials);
RT_error =  reaction_time_electric (error_trials);


% Saving Figure
%--------------------------------------------------------------------------
if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r200']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);

