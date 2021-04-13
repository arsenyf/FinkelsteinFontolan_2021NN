function Sup_REV1_StimulusMode_Rotation() % MATLAB R2018b
close all;


dir_save_figure = ['D:\Arseny\S1ALM_revision_figures\'];
filename = 'Sup_REV1_StimulusMode_Rotation';

%Graphics
%---------------------------------
figure1=figure;
set(gcf,'DefaultAxesFontName','helvetica');
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 7 21 21]);
set(gcf,'PaperOrientation','portrait');
set(gcf,'Units','centimeters','Position',get(gcf,'paperPosition')+[3 -10 0 0]);
set(gcf,'color',[1 1 1]);

panel_width1=0.1;
panel_height1=0.09;

panel_width3=0.1;
panel_height3=0.12;
horizontal_distance3=0.19;
vertical_distance3=0.2;

position_x3(1)=0.05;
position_x3(2)=position_x3(1)+horizontal_distance3;
position_x3(3)=position_x3(2)+horizontal_distance3;
position_x3(4)=position_x3(3)+horizontal_distance3*1.3;

position_y3(1)=0.7;
position_y3(2)=position_y3(1)-vertical_distance3;
position_y3(3)=position_y3(2)-vertical_distance3;


Param = struct2table(fetch (ANL.Parameters,'*'));

legends{1}.colr = [0 0 0]; % Distractor naive mice -mini
legends{2}.colr = [0 0 0]; % Distractor trained mice - mini
legends{3}.colr = [0 0 0]; % Distractor trained mice - full


%% Stimulus mode computed using Sample
axes('position',[position_x3(1), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='miss';
key.mode_type_name = 'Stimulus Orthog.111';
mode_names_titles = { 'Stimulus'};

plot_r_flag=1;
%Distractor full
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11StimulusRotation* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"' ) ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.2,1.05];
stim_legend_flag=1;
[xl, yl] =figure_plotModes2 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
set(gca,'Xtick',[-2 0],'Ytick',[0 1]);
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Mode computed based\non sample-period stimulation'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )
text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*1.4, 'f', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');


% Stimulus quantification
%-----------------------------------------------------------------------------
plot_r_flag=1;
flag_normalize_modes=1;
axes('position',[position_x3(1), position_y3(2), panel_width1*0.75, panel_height1]);
hold on;
colr = legends{3}.colr;
yl=[0,1.5];
ylim(yl);
signif_display_offset =-0.3;
compute_stim_amp_full_pairwise2_revision_regression (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);
% compute_stim_amp_full (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);

xl=[-2.9 0];
xlim(xl);
set(gca,'Xtick',[-2.5 -1.6 -0.8 0], 'Ytick',[0 1], 'Fontsize', 7)
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5, sprintf('Stimulus mode \n response (a.u.)'), 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',colr);
xl=[-2.9 0];
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-1.8,ceil(yl(2))*0.6,'Delay','FontSize',6);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'H', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);



%% Stimulus mode computed using Early Delay
axes('position',[position_x3(2), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='miss';
key.mode_type_name = 'Stimulus EarlyDelay Orthog.111';
mode_names_titles = { 'Stimulus'};

plot_r_flag=1;
%Distractor full
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11StimulusRotation* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"' ) ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.2,1.15];
stim_legend_flag=1;
[xl, yl] =figure_plotModes2 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
set(gca,'Xtick',[-2 0],'Ytick',[0 1]);
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Mode computed based\non early-delay stimulation'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )

% Stimulus quantification
%-----------------------------------------------------------------------------
plot_r_flag=1;
flag_normalize_modes=1;
axes('position',[position_x3(2), position_y3(2), panel_width1*0.75, panel_height1]);
hold on;
colr = legends{3}.colr;
yl=[0,1.5];
ylim(yl);
signif_display_offset =-0.3;
compute_stim_amp_full_pairwise2_revision_regression (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);
% compute_stim_amp_full (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);

xl=[-2.9 0];
xlim(xl);
set(gca,'Xtick',[-2.5 -1.6 -0.8 0], 'Ytick',[0 1], 'Fontsize', 7)
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5, sprintf('Stimulus mode \n response (a.u.)'), 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',colr);
xl=[-2.9 0];
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-1.8,ceil(yl(2))*0.6,'Delay','FontSize',6);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'H', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);




%% Stimulus mode computed using Late Delay
axes('position',[position_x3(3), position_y3(1), panel_width3*1.4, panel_height3*1.2]);
flag_normalize_modes=1;
key=[]; k=[];
% key.unit_quality = 'ok or good';
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.mode_weights_sign = 'all';
key.brain_area = 'ALM';
key.hemisphere = 'left';
% key.outcome='miss';
key.mode_type_name = 'Stimulus LateDelay Orthog.111';
mode_names_titles = { 'Stimulus'};

plot_r_flag=1;
%Distractor full
k=[];
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_full = 1;
title1 = '';
title2='';
title3=[];
rel =((EXP.Session * EXP.SessionID * ANL.ProjTrialAverageBaseline11StimulusRotation* EXP.SessionTraining  * ANL.TrialTypeID * ANL.TrialTypeGraphic * ANL.TrialTypeInstruction  * ANL.SessionGrouping * ANL.TrialTypeStimTime & 'outcome="response"' ) ) & k & (ANL.IncludeSessionSelectivity2 & 'num_delay_selective_units>=0' & 'num_sample_selective_units>=0') - ANL.ExcludeSession;
xlabel_flag=1;
ylabel_flag=1;
y_lims = [-0.2,1.2];
stim_legend_flag=1;
[xl, yl] =figure_plotModes2 (rel,  Param, xlabel_flag, title1, title2, title3, ylabel_flag,  k, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag);
set(gca,'Xtick',[-2 0],'Ytick',[0 1]);
text(xl(1)+diff(xl)*0.5, yl(1)+diff(yl)*1.35,sprintf('Mode computed based\non late-delay stimulation'),'HorizontalAlignment','center','FontSize',7,'fontweight','bold' )


% Stimulus quantification
%-----------------------------------------------------------------------------
plot_r_flag=1;
flag_normalize_modes=1;
axes('position',[position_x3(3), position_y3(2), panel_width1*0.75, panel_height1]);
hold on;
colr = legends{3}.colr;
yl=[0,1.5];
ylim(yl);
signif_display_offset =-0.3;
compute_stim_amp_full_pairwise2_revision_regression (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);
% compute_stim_amp_full (rel,  Param, colr, flag_normalize_modes, plot_r_flag, yl, signif_display_offset, k);

xl=[-2.9 0];
xlim(xl);
set(gca,'Xtick',[-2.5 -1.6 -0.8 0], 'Ytick',[0 1], 'Fontsize', 7)
text(xl(1)-diff(xl)*0.4, yl(1)+diff(yl)*0.5, sprintf('Stimulus mode \n response (a.u.)'), 'FontSize',7,'HorizontalAlignment','center','Rotation',90,'Color',colr);
xl=[-2.9 0];
text ((xl(1)+diff(xl)*0.5), (yl(1) + diff(yl)*-0.25), sprintf('Time to Go cue (s)'),'Fontsize', 7,'HorizontalAlignment','center');
text(-1.8,ceil(yl(2))*0.6,'Delay','FontSize',6);
text(xl(1)-diff(xl)*0.45, yl(1)+diff(yl)*1.3, 'H', ...
    'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
text(-3,yl(1)+diff(yl)*1.35,'Response size','FontSize',7);




%% Stimulus mode rotation
ax=axes('position',[position_x3(4), position_y3(1), panel_width3*2, panel_height3*1.2]);

plot_r_flag=1;
flag_normalize_modes=1;

key=[]; k=[];
key.unit_quality = 'all';
key.cell_type = 'Pyr';
key.brain_area = 'ALM';
key.hemisphere = 'left';

%Distractor full
k=key;
k.training_type = 'distractor';
k.session_flag_full = 1;
% k.trialtype_flag_left_and_control_right_nopresample = 1;
k.trialtype_flag_right_full_nopresample_and_control_left=1;
title1 = '';
title2='';
title3=[];
rel_rotation =ANL.ModeStimulusRotation & ((EXP.Session * EXP.SessionID  * EXP.SessionTraining *  ANL.IncludeSession * ANL.SessionGrouping - ANL.ExcludeSession) & k & key);


rel_rotation= rel_rotation *EXP.SessionID;

session_uid = unique(fetchn(rel_rotation, 'session_uid'));

for i_s = 1:1:numel(session_uid)
    
    kk.session_uid =  session_uid(i_s);
    kk.mode_type_name =  'Stimulus Orthog.111';
    sample = fetchn( rel_rotation & kk,'mode_unit_weight', 'ORDER BY unit');
    
    kk.mode_type_name =  'Stimulus EarlyDelay Orthog.111';
    early = fetchn( rel_rotation & kk,'mode_unit_weight', 'ORDER BY unit');
    
    kk.mode_type_name =  'Stimulus LateDelay Orthog.111';
    late = fetchn( rel_rotation & kk,'mode_unit_weight', 'ORDER BY unit');
    
    
    r(i_s,:,:) = corr([sample,early,late]);
    
end
r_mat = squeeze(nanmean(r,1));
imagesc(r_mat)

nanmean(nanmean([r(:,1,2),r(:,1,3),r(:,2,3)],2))
nanstd(nanmean([r(:,1,2),r(:,1,3),r(:,2,3)],2))./sqrt(size(r,1))

% mean(r_mat(r_mat<1))

ax.CLim = [0 1];
ccc= colorbar
ylabel(ccc, 'Mode-weights correlation')

title('Stimulus-mode similarity')
set(gca,'XTickLabel',{'Sample', 'Early Delay', 'Late Delay'}, 'YTickLabel',{'Sample', 'Early Delay', 'Late Delay'})
xtickangle(90)


if isempty(dir(dir_save_figure))
    mkdir (dir_save_figure)
end
figure_name_out=[ dir_save_figure filename];
eval(['print ', figure_name_out, ' -dtiff -cmyk -r300']);
eval(['print ', figure_name_out, ' -painters -dpdf -cmyk -r200']);
