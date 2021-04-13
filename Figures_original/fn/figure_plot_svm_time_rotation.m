function  figure_plot_svm_time_rotation(time,r, position_x, position_y, panel_width, panel_height, label_flag,c_lims, last_label, key)
idx_time =time>=-3.2;
time = time(idx_time);
imagesc(time,time,r(idx_time,idx_time));
axx=gca;
my_colormap = jet;
colormap(my_colormap);
caxis([c_lims]);

% c = colorbar;
% cbar_x =axx.Position(1) + axx.Position(3)*1.05;
% cbar_y =axx.Position(2) + axx.Position(4)/6;
% cbar_width =0.01;
% cbar_height= axx.Position(4)/2;
% c.Position=[cbar_x cbar_y cbar_width cbar_height];
% c.Ticks=[0,50,100];
% c.Label.String = 'performance (%)';
% cbar_label_x = c.Label.Position(1);
% cbar_label_y = c.Label.Position(2);
% cbar_label_z = c.Label.Position(3);
% c.Label.Position(1) = cbar_label_x;
% c.Label.FontAngle ='italic';
% c.Label.FontSize =10;
% c.Label.FontWeight ='bold';

% c=colorbar
% c.Limits=[50 100]
% set(gca,'Fontsize',10);
hold on;
plot([ time(1) time(end)], [-3 -3 ], 'w-','LineWidth',0.5);
plot([ time(1) time(end)], [-2.15 -2.15], 'w-','LineWidth',0.5);
plot([ time(1) time(end)], [0 0 ], 'w-','LineWidth',0.5);
plot([ -3 -3 ], [time(1) time(end)], 'w-','LineWidth',0.5);
plot([ -2.15 -2.15 ], [time(1) time(end)], 'w-','LineWidth',0.5);
plot([ 0 0 ], [time(1) time(end)], 'w-','LineWidth',0.5);


% axis equal;

% text(4.8,-1.2,'Performance (%)','fontsize',6,'Rotation',90,'HorizontalAlignment','center');
axis tight;
axis equal;
xl=[-3.2 0.4];
yl=[-3.2 0.4];
xlim(xl);
ylim(yl)

% axis tight;

if label_flag==1
    text(xl(1)+diff(xl)*0.7, yl(2)+diff(yl)*0.25,'Decoder training time (s)', 'FontSize',7,'HorizontalAlignment','center');
    text(xl(1)-diff(xl)*0.3, yl(1)+diff(yl)*0.5,'Test time (s)', 'FontSize',7,'HorizontalAlignment','center','Rotation',90);
    text(-1.8,0.7,'delay','fontsize',7,'Rotation',0,'HorizontalAlignment','left');
    text(-3.6,-1.8,'delay','fontsize',7,'Rotation',+90,'HorizontalAlignment','right');
    text(xl(1)-diff(xl)*0.3, yl(1)-diff(yl)*0.2, 'l', ...
        'fontsize', 12, 'fontname', 'helvetica', 'fontweight', 'bold');
    set(gca,'Fontsize',6,'YAxisLocation','left', 'fontname', 'helvetica','Xtick',[-2.5,0],'XtickLabel',[-2,0],'Ytick',[-2.5,0],'YtickLabel',[-2,0]);
else
    set(gca,'Fontsize',6,'YAxisLocation','left', 'fontname', 'helvetica','Xtick',[-2.5,0],'XtickLabel',[-2,0],'Ytick',[-2.5,0],'YtickLabel',[-2,0]);
end
box off;

%Colorbar
my_colorbar=colorbar;
set(my_colorbar, 'fontname', 'helvetica', 'fontsize', 7,'location','EastOutside',  'Position', [position_x+panel_width*1.05, position_y+0.025, panel_width*0.1, panel_height*0.5], 'ticklength', [0.02], 'tickdir', 'out');
text( xl(1)+diff(xl)*1.1, yl(1)+diff(yl)*0.00, sprintf('%d',c_lims(2)), ...
    'fontname', 'helvetica', 'fontsize', 6, 'HorizontalAlignment','center' );
text( xl(1)+diff(xl)*1.1, yl(1)+diff(yl)*0.8, sprintf('%d',c_lims(1)), ...
    'fontname', 'helvetica', 'fontsize', 6, 'HorizontalAlignment','center' );

set(my_colorbar,'XLim', [c_lims],'XTick', [], 'fontsize', 6);

if last_label==1
    text( xl(1)+diff(xl)*1.25, yl(1)+diff(yl)*0.35, '%', ...
        'fontname', 'helvetica', 'fontsize', 6, 'HorizontalAlignment','center' );
    
end

if strcmp(key.sensory_or_motor,'sensory')
    text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.15,'Sensory', 'FontSize',7,'HorizontalAlignment','center');
elseif strcmp(key.sensory_or_motor,'motor')
    text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.15,'Motor', 'FontSize',7,'HorizontalAlignment','center');
else
    text(xl(1)+diff(xl)*0.5, yl(1)-diff(yl)*0.15,'All trials', 'FontSize',7,'HorizontalAlignment','center');
end
