function [xl, yl] = figure_plotModes7 (rel,Param, xlabel_flag, title1, title2,title3, ylabel_flag, key, mode_names_titles, y_lims, flag_normalize_modes, plot_r_flag, stim_legend_flag, xl, line_style, stim_time_flag)


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
ylab='';
%     trial_type_substract='l';
trial_type_substract=[];
[~] = fn_plotProjection_for_figure_correct_or_error2(Param, rel, key, trial_type_substract, ylab,mode_names_titles{1}, flag_normalize_modes, plot_r_flag, line_style, stim_time_flag);
%     title(sprintf('%s',mode_names_titles{imod}));
%     xl=[-3.5 1];
if ~exist('xl')
    xl=[-4 0];
end
xlim(xl);
%     yl = yx_lims (imod, :);
yl = y_lims ;
ylim(yl);
if ylabel_flag==1
    if strcmp(key.mode_weights_sign, 'all')
        text ((xl(1)-diff(xl)*0.2), (yl(1) + diff(yl)*0.5), sprintf('%s mode \n(a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
    elseif  strcmp(key.mode_weights_sign, 'negative')
        text ((xl(1)-diff(xl)*0.35), (yl(1) + diff(yl)*0.4), sprintf('%s mode\nLeft preferring cells \n(a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');
        elseif  strcmp(key.mode_weights_sign, 'positive')
        text ((xl(1)-diff(xl)*0.35), (yl(1) + diff(yl)*0.4), sprintf('%s mode\nRight preferring cells \n(a.u.)',mode_names_titles{1}),'Fontsize', 7,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center');

    end
end


set(gca,'FontSize',6,'YTick',[0,y_lims(2)]);

%     set(gca,'FontSize',10,'YTick',[0,ax_lims(imod, 2)]);
%     set(gca,'FontSize',10,'YTick',[-15, 5]);

text (-2, (yl(2) + diff(yl)*0.6), sprintf('%s\n%s\n%s',title3,title1, title2),'Fontsize', 7,'HorizontalAlignment','center','FontWeight','bold');

if xlabel_flag==1
    xlabel ('Time to Go cue (s)','Fontsize', 7);
    set(gca,'Xtick',[-4 -2 0],'TickDir','out');
else
    set(gca,'Xtick',[-4 -2 0],'XtickLabel',[],'TickDir','out');
end

% Plot waves - full stimuli
x = 0:0.01:pi;
y_mini = repmat(sin(x),1); % mini
y_full = repmat(sin(x),4); % full

if stim_legend_flag==1
    factor=(diff(yl))/4.5;
    
    if  isfield(key,'trialtype_flag_right_early_delay_and_control_pure')
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-1.6Full"','trialtype_rgb');
%         colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-0.8Full"','trialtype_rgb');
%         colr{4}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-3.8Full"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*0.5,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
%         plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.35,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        %         plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*0.35,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
        
        plot(linspace(-1.6, -1.2, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
%         plot(linspace(-0.8, -0.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        %         plot(linspace(-3.8, -3.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
    end
    if isfield(key,'trialtype_flag_right_full_only_presample_and_control_left')
        colr{1}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r"','trialtype_rgb');
        colr{2}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-1.6Full"','trialtype_rgb');
        colr{3}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-0.8Full"','trialtype_rgb');
        colr{4}=fetch1(ANL.TrialTypeGraphic &  'trial_type_name="r_-3.8Full"','trialtype_rgb');
        
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*0.5,'Color',colr{1},'LineWidth',0.5,'Clipping','off')
        %         plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
        %         plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.35,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-2.5, -2.1, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
        
        %         plot(linspace(-1.6, -1.2, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{2},'LineWidth',0.5,'Clipping','off')
        %         plot(linspace(-0.8, -0.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{3},'LineWidth',0.5,'Clipping','off')
        plot(linspace(-3.8, -3.4, 4*numel(x)),y_full*(factor)+yl(2)*1.05,'Color',colr{4},'LineWidth',0.5,'Clipping','off')
        
    end
    
end