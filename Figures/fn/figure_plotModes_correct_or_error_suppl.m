function [xl, yl] = figure_plotModes_correct_or_error_suppl (rel,Param, xlabel_flag, title1, title2,title3, ylabel_flag,  mode_names_titles, y_lims, outcome, flag_normalize_modes, plot_r_flag, key_trial_type, stim_legend_flag, key,  xl, line_style, stim_time_flag)


if ~exist('line_style')
    line_style='-';
end

if ~exist('stim_time_flag')
    stim_time_flag=1;
end

%
% y_lims(1,:) = [-4,20];
% y_lims(2,:) = [-4,30];
% y_lims(3,:) = [-4,30];



hold on
key_mode.outcome = outcome; ylab='';
%     trial_type_substract='l';
trial_type_substract=[];

PROJ = fn_plotProjection_for_figure_correct_or_error2_suppl (Param, rel, key_mode, trial_type_substract, ylab,mode_names_titles{1}, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag, key_trial_type);
% PROJ = fn_plotProjection_for_figure_correct_or_error (Param, rel, key_mode, trial_type_substract, ylab,mode_names_titles{1}, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag, key_trial_type);
% PROJ = fn_plotProjection_for_figure_correct_or_error3 (Param, rel, key_mode, trial_type_substract, ylab,mode_names_titles{1}, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag, key_trial_type);


%     title(sprintf('%s',mode_names_titles{imod}));
%     xl=[-3.5 1];
if ~exist('xl')
    xl=[-2.8 0];
    
elseif isempty(xl)
    xl=[-2.8 0];
end
xlim(xl);
%     yl = yx_lims (imod, :);
yl = y_lims ;
ylim(yl);
% if ylabel_flag==1
%     if strcmp(key.mode_weights_sign, 'all')
%         text ((xl(1)-diff(xl)*0.4), (yl(1) + diff(yl)*0.5), sprintf('%s mode\nAll cells (a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
%     elseif  strcmp(key.mode_weights_sign, 'negative')
%         text ((xl(1)-diff(xl)*0.4), (yl(1) + diff(yl)*0.5), sprintf('%s mode\nLeft preferring cells \n(a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
%         
%     end
% end
if ylabel_flag==1
    if strcmp(key.mode_weights_sign, 'all')
        text ((xl(1)-diff(xl)*0.3), (yl(1) + diff(yl)*0.5), sprintf('%s mode (a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif  strcmp(key.mode_weights_sign, 'negative')
        text ((xl(1)-diff(xl)*0.3), (yl(1) + diff(yl)*0.5), sprintf('%s mode (a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
        
    end
end

set(gca,'FontSize',7,'YTick',[0,y_lims(2)]);

%     set(gca,'FontSize',10,'YTick',[0,ax_lims(imod, 2)]);
%     set(gca,'FontSize',10,'YTick',[-15, 5]);



text (-2, (yl(2) + diff(yl)*0.6), sprintf('%s\n%s\n%s',title3,title1, title2),'Fontsize', 7,'HorizontalAlignment','center','FontWeight','bold');

if xlabel_flag==1
    text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.25,'Time to Go cue (s)', 'FontSize',7,'HorizontalAlignment','center');
    set(gca,'Xtick',[-2 0],'XtickLabel',[-2 0],'TickDir','out');
else
    set(gca,'Xtick',[-2 0],'XtickLabel',[-2 0],'TickDir','out');
end



% Plot waves - full stimuli
x = 0:0.01:pi;
y_mini = repmat(sin(x),1); % mini
y_full = repmat(sin(x),4); % full


if ~isempty(key_trial_type.trial_type_name)
    if strcmp(key.training_type,'regular')
            factor=diff(yl)/4;
        colr{1}=fetch1(ANL.TrialTypeGraphic &  key_trial_type,'trialtype_rgb');
        plot(linspace(-1.6, -1.5, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
                text(-1, yl(2)*1.2, '--- Error trials', 'Color', colr{1}, 'FontSize',7)

    else
         factor=diff(yl)/4;
        colr{1}=fetch1(ANL.TrialTypeGraphic &  key_trial_type,'trialtype_rgb');
        plot(linspace(-1.6, -1.2, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
    end
end

% if stim_legend_flag==1
%     
%     if isfield(key,'trialtype_flag_full')
%     factor1=1+0.2*(diff(yl)/yl(2));
%     factor2=1+0.05*(diff(yl)/yl(2));
%         
%         colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
%         colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
%         colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');
%         
%         time1=[-2.5,-1.6,-0.8];
%         time2=[-2.1,-1.2,-0.4];
%         if isfield(key,'trialtype_left_and_right_no_distractors')
%             time1=time1(1);
%         end
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
%             plot([time1(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%             plot([time1(i_ss), time1(i_ss)],[yl(2)*factor2,yl(2)*factor1],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%             plot([time2(i_ss), time2(i_ss)],[yl(2)*factor1,yl(2)*factor2],'Color',colr{i_ss},'LineWidth',1,'Clipping','off')
%         end
%         
%     end
% end

% Plot waves - full stimuli
x = 0:0.01:pi;
y_mini = repmat(sin(x),1); % mini
y_full = repmat(sin(x),4); % full



if stim_legend_flag==1
    if isfield(key,'trialtype_flag_full')
        factor=diff(yl)/6;
        
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Full"','trialtype_rgb');
        colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Full"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.35,'Clipping','off')
        plot(linspace(-1.6, -1.2, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.35,'Clipping','off')
        plot(linspace(-0.8, -0.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.35,'Clipping','off')
    else
        factor=diff(yl)/6;
        
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-1.6Mini"','trialtype_rgb');
        colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-0.8Mini"','trialtype_rgb');
        colr{4}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="l_-2.5Mini"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{1},'LineWidth',0.35,'Clipping','off')
        plot(linspace(-1.6, -1.5, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-0.8, -0.7, numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-2.5, -2.4,  numel(x)),y_mini*(factor/3)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
    end
end