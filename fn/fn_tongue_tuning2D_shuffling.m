function [ SI] = fn_tongue_tuning2D_shuffling(X,Y, SPIKES, t_wnd, min_trials_2D_bin, hist_bins_X ,hist_bins_Y ,smooth_flag)

[N,Xedges,Yedges,binX,binY] = histcounts2(X, Y,hist_bins_X, hist_bins_Y);
X_centers=Xedges(1:end-1)+mean(diff(Xedges))/2;
Y_centers=Yedges(1:end-1)+mean(diff(Yedges))/2;
minimal_occupancy = min_trials_2D_bin;
remove_unoccupied_bins=N*0;
remove_unoccupied_bins(find(N(:)<minimal_occupancy))=NaN;
N=N+remove_unoccupied_bins;

time_binned=N*diff(t_wnd);

for i_tr=1:1:numel(SPIKES)
    spk_t=SPIKES{i_tr};
    spk(i_tr)=sum(spk_t>t_wnd(1) & spk_t<t_wnd(2));%/diff(t_wnd);
end



V=spk;

tuning_2D=[];
for i_x=1:1:numel(X_centers)
    for i_y=1:1:numel(Y_centers)
        tuning_2D(i_x,i_y) =sum(V(binX==i_x & binY==i_y));
    end
end
tuning_2D=tuning_2D./time_binned;
tuning_2D(isnan(tuning_2D))=0;

if smooth_flag==1
    % Smoothing = convolve with gaussian kernel:
    sigma = 0.5;
    tuning_2D = imgaussfilt(tuning_2D,sigma,'FilterDomain','spatial');
end
tuning_2D =  tuning_2D + remove_unoccupied_bins;

[SI] = fn_compute_spatial_info (time_binned, tuning_2D);

