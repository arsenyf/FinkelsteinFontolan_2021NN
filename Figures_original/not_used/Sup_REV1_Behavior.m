 function Sup_REV1_Behavior() % MATLAB R2017a
close all;

dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_Behavior';

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
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);
set(gcf,'color',[1 1 1]);

panel_width1=0.1;
panel_height1=0.08;
horizontal_distance1=0.15;
vertical_distance1=0.165;

position_x1(1)=0.07;
position_x1(2)=position_x1(1)+horizontal_distance1;
position_x1(3)=position_x1(2)+horizontal_distance1;
position_x1(4)=position_x1(3)+horizontal_distance1;
position_x1(5)=position_x1(4)+horizontal_distance1;
position_x1(6)=position_x1(5)+horizontal_distance1;
position_x1(7)=position_x1(6)+horizontal_distance1*0.6;

position_y1(1)=0.85;
position_y1(2)=position_y1(1)-vertical_distance1*1;
position_y1(3)=position_y1(2)-vertical_distance1;



Param = struct2table(fetch (ANL.Parameters,'*'));


% Behavior


mintrials_behav_typeoutcome =fetch1(ANL.Parameters & 'parameter_name="mintrials_behav_typeoutcome"','parameter_value');



% %Expert on Full distractors
% %--------------------------------------
% axes('position',[position_x1(3), position_y1(2), panel_width1, panel_height1]);
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6,3,2,5,7,8,9)' & 'training_type="distractor"' & 'session_comment="good behavior"');
% % b_query= (EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'task_protocol in (4,6)'  & 'training_type="distractor"' );
% b_query = EXP.SessionID *ANL.SessionBehavPerformance  & (EXP.SessionTraining*EXP.SessionTask & 'training_type="distractor"'   & 'task="s1 stim"' & 'task_protocol in (4,6)'   & (ANL.SessionBehavPerformance & 'trial_type_name="l"' & sprintf('total_noignore_noearly>=%d',mintrials_behav_typeoutcome) ));
% num_sessions_strong_distractor_trained = numel(unique(fetchn(b_query, 'session_uid')))
% 
% clear trial_type_names  b
% [trial_type_names, b] = fn_fetch_behav(b_query);
% names_right_trials = {'r', 'r_-3.8Full', 'r_-1.6Full', 'r_-0.8Full'};
% % names_left_trials = {'l', 'l_-3.8Full','r', 'l_-1.6Full', 'l_-0.8Full'};
% names_left_trials = {'l', 'r', 'l_-1.6Full', 'l_-0.8Full'};
% x_r = [(-3.8), (-1.6), (-0.8)];
% % x_l = [(-3.8),(-2.5), (-1.6), (-0.8)];
% x_l = [(-2.5), (-1.6), (-0.8)];
% % Choosing which trial-types to display
% %--------------------------------------
% clear behav_param behav_param_mean behav_param_signif trn_r trn_l y_r y_l
% behav_param = b.prcnt_hit_outof_noignore_noearly;
% [behav_param_mean, behav_param_signif, trn_r, trn_l, y_r, y_l ] = fn_choose_behav_trials(behav_param,trial_type_names, names_right_trials, names_left_trials);
% % Plotting Performance
% %-------------------------------------------
% plot_signif_offset=+7;
% [xl,yl]=figure_plot_behav_distractor_full (behav_param,behav_param_mean, behav_param_signif,  x_r, x_l, y_r, y_l, trn_r, trn_l, flag_plot_left_right_trials,plot_signif_offset, names_right_trials, names_left_trials, legends{3} );
% % text(xl(1)-diff(xl)/3.2, yl(1)+diff(yl)*1.6, 'c', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');



%distractor trained, 
%pure r performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="r"' & 'task_protocol in (4,6,2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="l"' & 'task_protocol in (4,6,2,5,7,8,9)','prcnt_hit_outof_noignore_noearly');
mean(x)
std(x)/sqrt(numel(x))


%pure r performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="r"' & 'task_protocol in (4,6,2,5,7,8,9)','mean_reaction_time_hit');
mean(x)
% std(x)/sqrt(numel(x))
%pure l performance
x= fetchn(EXP.SessionID * ANL.SessionBehavPerformance * EXP.SessionTraining * EXP.SessionTask * EXP.SessionComment  & 'training_type="distractor"' & 'trial_type_name="l"' & 'task_protocol in (4,6,2,5,7,8,9)','mean_reaction_time_hit');
mean(x)
% std(x)/sqrt(numel(x))


if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




