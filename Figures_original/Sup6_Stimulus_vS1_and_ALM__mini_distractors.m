function SupX1_Stimulus_vS1_and_ALM__mini_distractors() % MATLAB R2018ba
close all;

dir_root = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\'
dir_embeded_graphics = 'Z:\users\Arseny\Projects\SensoryInput\SiProbeRecording\Graphic_for_figures\'
dir_save_figure = [dir_root 'Results\figures\v\'];
filename = 'SupX2_Stimulus_vS1_and_ALM__mini_distractors';

legends{1}.colr = [0 0 0]; % Distractor naive mice -mini
legends{2}.colr = [0 0 0]; % Distractor trained mice - mini
legends{3}.colr = [0 0 0]; % Distractor trained mice - full
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
set(gcf,'color',[1 1 1]);

panel_width1=0.1;
panel_height1=0.09;
horizontal_distance1=0.13;
vertical_distance1=0.18;

position_x1(1)=0.12;
position_x1(2)=position_x1(1)+horizontal_distance1*1.3;
position_x1(3)=position_x1(2)+horizontal_distance1*1.3;
position_x1(4)=position_x1(3)+horizontal_distance1*1.2;
position_x1(5)=position_x1(4)+horizontal_distance1*1.3;
position_x1(6)=position_x1(5)+horizontal_distance1*1.1;

position_y1(1)=0.8;
position_y1(2)=position_y1(1)-vertical_distance1;
position_y1(3)=position_y1(2)-vertical_distance1;
% position_y1(4)=position_y1(3)-vertical_distance1;
% position_y1(5)=position_y1(4)-vertical_distance1;


panel_width2=0.1;
panel_height2=0.09;
horizontal_distance2=0.16;
vertical_distance2=0.4;


position_x2(1)=0.12;
position_x2(2)=position_x2(1)+horizontal_distance2;
position_x2(3)=position_x2(2)+horizontal_distance2*1.2;
position_x2(4)=position_x2(3)+horizontal_distance2;

position_y2(1)=0.63;
position_y2(2)=position_y2(1)-vertical_distance2;
% position_y2(3)=position_y2(2)-vertical_distance2;
% position_y2(4)=position_y2(3)-vertical_distance2;

Param = struct2table(fetch (ANL.Parameters,'*'));

unit_counter=0;

% %% Recording locations
% axes('position', [position_x1(1)-0.11 position_y1(1)+0.01 0.07 0.07]); hold on ;
% xl = [0 342];
% yl = [0 428];
% fig1_a = imread([dir_embeded_graphics 'left_vS1.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)-diff(xl)*0.05, yl(1)+diff(yl)*1.3, 'd', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'vS1','FontSize',8,'FontWeight','bold','Color',[0 0 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;
% 
% axes('position', [position_x1(1)-0.11 position_y1(2)+0.01 0.07 0.07]); hold on ;
% xl = [0 342];
% yl = [0 431];
% fig1_a = imread([dir_embeded_graphics 'left_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)-diff(xl)*0.05, yl(1)+diff(yl)*1.25, 'f', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM','FontSize',8,'FontWeight','bold','Color',[0 0 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;

% axes('position', [position_x1(1)-0.11 position_y1(3)+0.01 0.07 0.07]); hold on ;
% xl = [0 342];
% yl = [0 428];
% fig1_a = imread([dir_embeded_graphics 'right_ALM.jpg']);
% fig1_a=flipdim(fig1_a,1);
% imagesc(fig1_a);
% set(gca,'Xlim',xl,'Ylim',yl);
% % text(xl(1)-diff(xl)*0.05, yl(1)+diff(yl)*1.35, 'h', ...
% %     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.1,'ALM right','FontSize',8,'FontWeight','bold','Color',[0 1 0],'HorizontalAlignment','center');
% axis off;
% axis tight;
% axis equal;


%% vS1, Distractor trained full stimuli
% Cell 1
key_u.unit_uid=2151; % 2249 %3165 %2096 %2100 %2151
axes('position',[position_x1(1), position_y1(1), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='A';
fn_plot_PSTH_Supp2 (Param, 'response', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);
text(-3,90,'Distractor-naive mice, weak distractors','HorizontalAlignment','Left','FontSize',9,'Color', legends{1}.colr,'fontweight','bold' )
text(-1.5,65,'Delay','FontSize',6);



axes('position',[position_x1(2), position_y1(1), panel_width1, panel_height1]);
% Full Stimuli
key=[]; k=[];
key.brain_area = 'vS1';
key.hemisphere = 'left';
key.training_type = 'regular';
% key.unit_quality = 'ok or good'  %'ok or good'
key.unit_quality = 'multi';
key.cell_type = 'Pyr';
k = key;
k.session_flag_mini = 1;
% k.trialtype_flag_left_stim_mini_nopresample = 1;
k.trialtype_flag_mini = 1;
if contains(key.unit_quality, 'ok or good')
    k= rmfield(k,'unit_quality');
    rel3=(EXP.SessionID *  EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'unit_quality!="multi"' & 'outcome="response"' & (ANL.IncludeSessionSelectivity2 & 'num_sample_selective_units>=0');
    key.unit_quality = 'ok';
elseif contains(key.unit_quality, 'multi')
    k= rmfield(k,'unit_quality');
    rel3=(EXP.SessionID * EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'outcome="response"'  & (ANL.IncludeSessionSelectivity2 & 'num_sample_selective_units>=0');
    key.unit_quality = 'multi';
else
    rel3=(EXP.SessionID * EPHYS.Unit * EXP.SessionTraining * EPHYS.UnitPosition * EPHYS.UnitCellType * ANL.PSTHAverage * ANL.TrialTypeGraphic  * ANL.SessionGrouping) & ANL.IncludeUnit2 & k & 'outcome="response"'   & (ANL.IncludeSessionSelectivity2 & 'num_sample_selective_units>=0');
end

rel4= rel3 & 'trialtype_flag_left_and_control_right_nopresample = 1';
rel5= rel3 & 'trialtype_flag_left_stim_mini_nopresample = 1';


% Plot
k3=k;
label_flag=0;
plot_r_flag=1;
[xl,yl] = figure_plot_vs1_stimulus_full(rel4, k3, label_flag, plot_r_flag);
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.55, sprintf('%s', legends{2}.title_label),'FontSize',7,'Color',legends{3}.colr,'HorizontalAlignment','center','fontweight','bold');
% text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35, sprintf('full stimuli'),'FontSize',7,'Color',legends{3}.colr,'HorizontalAlignment','center','fontweight','bold');
% 
% text(-1.8,ceil(yl(2))*0.93,'Delay','FontSize',6);
set(gca,'Xtick',[-2 0],'XtickLabel',[-2 0 ]);
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-3,yl(1)+diff(yl)*1.35,'Population response','FontSize',7);
    text(xl(1)-diff(xl)*0.35, yl(1)+diff(yl)*0.5,[' \Delta Firing ' sprintf('rate \n(Spikes s^{-1})')], 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'B', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


% vS1 Quantification
axes('position',[position_x1(3), position_y1(1), panel_width1*0.75, panel_height1]);

xl=[-2.9 0];
yl=[0,1];

text(xl(1)-diff(xl)*0.25, yl(1)+diff(yl)*0.5,['\Delta spikes'], 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',legends{1}.colr);
text(-1.8,yl(2)*0.9,'Delay','FontSize',6);
colr=legends{1}.colr;
fn_plot_stimulus_quantification_mini_rev_reg(rel5, k3,colr,yl)
ylim(yl);
xlim(xl);
set(gca,'Ytick',yl, 'YColor',colr,'Fontsize', 7,'XTick',[])
% xlabel ('Time (s)','Fontsize', 7);
% title(sprintf('Spike count in vS1\n  at stimulation'),'Fontsize', 7);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'C', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
set(gca,'Xtick',[-2 0], 'Ytick',[yl(1) yl(2)], 'YColor',colr,'Fontsize', 7)





%% Left Hemisphere, Distractor-naive
% Cell 1
key_u.unit_uid=4070;%2007; 3988, very good 4266; 1811 very good 2757; 2764 good; 4070 very good 4266, 4377, 4402 good
axes('position',[position_x1(1), position_y1(2), panel_width1, panel_height1]);
xlabel_flag=1; ylabel_flag=1; stim_legend_flag=1; unit_counter=unit_counter+1; cell_title=''; cell_label='';
fn_plot_PSTH_Supp2 (Param, 'response', 1, 1, 1, [], key_u, xlabel_flag, ylabel_flag, stim_legend_flag, unit_counter, cell_title, cell_label);




% Population
plot_r_flag=1;
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';

key.cell_type = 'Pyr';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='hit';
key.mode_type_name = 'Stimulus Orthog.111';
mode_names_titles = { 'Stimulus'};
key.training_type = 'regular';

% All Weights
axes('position',[position_x1(2), position_y1(2), panel_width1, panel_height1]);
k=key;
k.mode_weights_sign = 'all';
k.session_flag_mini = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_mini = 1;
title1 = '';
title2='';
title3=[];
% rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAdaptiveAverageBaseline5* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction *  ANL.IncludeSession * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"') - ANL.ExcludeSession) & k ;
rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11 * EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"') ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0');

stim_legend_flag=1;
ylabel_flag=1;
xlabel_flag=1;
y_lims = [-0.1,1];
[xl, yl] =figure_plotModes6 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
% text(xl(1)-diff(xl)*0.5, yl(1)+diff(yl)*1.3, 'j', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
set(gca,'Ytick',[ 0 1]);
text(-3,yl(1)+diff(yl)*1.35,'Population response','FontSize',7);



% Stimulus quantification
%-----------------------------------------------------------------------------
plot_r_flag=0;
flag_normalize_modes=1;
axes('position',[position_x1(3), position_y1(2), panel_width1*0.75, panel_height1]);
hold on;
colr = legends{3}.colr;
yl=[0,1];
ylim(yl);
signif_display_offset =-0.3;
compute_stim_amp_full_pairwise2_mini_rev_reg (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);
% compute_stim_amp_full (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);

xl=[-2.9 0];
xlim(xl);
set(gca,'Xtick',[-2 0], 'Ytick',yl, 'Fontsize', 7)
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5, sprintf('Stimulus mode \n response (a.u.)'), 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',colr);
xl=[-2.9 0];
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);
% text(-1.8,(yl(2))*0.9,'Delay','FontSize',6);
% text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'H', ...
%     'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');






if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);


end




