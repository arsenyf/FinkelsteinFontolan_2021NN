function Sup_REV1_DetailedBehavior_Bars()
% clear all;
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_DetailedBehavior';
disp_offset=5.75; %for display only

% populate(ANL.SessionBehavPerformance);

%% Graphics
figure
set(gcf,'DefaultAxesFontSize',7);
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0.5 0 30 24]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[0 0 0 0]);

panel_width=0.15;
panel_height=0.13;
horizontal_distance=0.2;
vertical_distance=0.2;

position_x(1)=0.05;
position_x(2)=position_x(1)+horizontal_distance;
position_x(3)=position_x(2)+horizontal_distance;
position_x(4)=position_x(3)+horizontal_distance;
position_x(5)=position_x(4)+horizontal_distance;
position_x(6)=position_x(5)+horizontal_distance;

position_y(1)=0.8;
position_y(2)=position_y(1)-vertical_distance;
position_y(3)=position_y(2)-vertical_distance;
position_y(4)=position_y(3)-vertical_distance;
position_y(5)=position_y(4)-vertical_distance;


%% Regular versus expert mice - performance
%--------------------------------------

%regular mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="regular"'  & 'task_protocol in (2,4,5,6, 7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [1 2];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(1), position_y(1), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

%expert mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="distractor"' & 'task_protocol in (2,4,5,6,7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [3 4];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

% axes('position',[position_x(1), position_y(1), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



%% Regular versus expert mice - Reaction time hit
%--------------------------------------

%regular mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="regular"' & 'task_protocol in (2,4,5,6,7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [1 2];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(2), position_y(1), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,1];
ylabel('RT hit');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

%expert mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="distractor"' & 'task_protocol in (2,4,5,6,7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [3 4];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

% axes('position',[position_x(1), position_y(1), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,1];
ylabel('RT hit');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



%% Regular versus expert mice - Reaction time miss
%--------------------------------------

%regular mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="regular"' & 'task_protocol in (2,4,5,6,7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [1 2];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(3), position_y(1), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,1];
ylabel('RT error');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


%expert mice
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment & 'training_type="distractor"' & 'task_protocol in (2,4,5,6,7,8,9)');
names_trials = {'r','l'};
color_bars = [0 0 1; 1 0 0];
x = [3 4];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

% axes('position',[position_x(1), position_y(1), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,1];
ylabel('RT miss (%)');
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



%% Regular on Mini distractors
%--------------------------------------
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & 'training_type="regular"' );
names_trials = {'r','l','l_-2.5Mini', 'l_-1.6Mini', 'l_-0.8Mini'};
color_bars = [0 0 1; 1 0 0; 1 0 0; 1 0 0; 1 0 0];
x = [1 2 3 4 5];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(1), position_y(2), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(1), position_y(3), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Correct trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'b', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(1), position_y(4), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Error trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


%% Expert on Mini distractors
%--------------------------------------
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (2,5,7,8,9)' & 'training_type="distractor"' );
names_trials = {'r','l','l_-2.5Mini', 'l_-1.6Mini', 'l_-0.8Mini'};
color_bars = [0 0 1; 1 0 0; 1 0 0; 1 0 0; 1 0 0];
x = [1 2 3 4 5];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(2), position_y(2), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(2), position_y(3), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,0.5];
% ylabel(sprintf('Correct trials \n Reaction time (s)'));
% xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'b', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(2), position_y(4), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,0.5];
% ylabel(sprintf('Error trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'c', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');




%% Regular on Full distractors
%--------------------------------------
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (7,8,9)' & 'training_type="regular"' );
names_trials = {'r','l', 'l_-0.8Full'};
color_bars = [0 0 1; 1 0 0; 1 0 0];
x = [1 2 3];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(3), position_y(2), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(3), position_y(3), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Correct trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'b', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(3), position_y(4), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Error trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
% text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'c', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

set(gca, 'Ytick',[0 0.25 0.5], 'TickLabelInterpreter', 'None', 'FontSize', 7, 'XTickLabelRotation', 0);




%% Expert on Full distractors
% Fetching
%--------------------------------------
b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)' & 'training_type="distractor"' );
names_trials = {'r','l', 'l_-1.6Full', 'l_-0.8Full'};
color_bars = [0 0 1;  1 0 0; 1 0 0; 1 0 0];
x = [1 2 3 4];
xl = [min(x) - mean(diff(x))/2, max(x) + mean(diff(x))/2];

axes('position',[position_x(4), position_y(2), panel_width, panel_height]);
behav_param ='prcnt_hit_outof_noignore_noearly';
hold on
yl = [0,100];
ylabel('Performance (%)');
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'a', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(4), position_y(3), panel_width, panel_height]);
behav_param ='RT_hit_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Correct trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'b', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');

axes('position',[position_x(4), position_y(4), panel_width, panel_height]);
behav_param ='RT_miss_mean';
hold on
yl = [0,0.5];
ylabel(sprintf('Error trials \n Reaction time (s)'));
xlabel(sprintf('Time of distractors (s) \n relative to Go cue'));
fn_behav_bar_anova_rev(b_query,names_trials,color_bars,x, behav_param);
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.5, 'c', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');




% Saving Figure
%--------------------------------------------------------------------------
if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r200']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);

