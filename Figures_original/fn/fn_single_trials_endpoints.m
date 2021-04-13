function x = fn_single_trials_endpoints(rel, k, smooth_bins, session_uid, numbins, tidx, min_num_trials)
for i_s=1:1:numel(session_uid)
    k.session_uid=session_uid(i_s);
    
    all_projs=cell2mat(fetchn(rel & k,'proj_trial'));
    all_projs1_hit = movmean(all_projs ,[smooth_bins 0], 2,'omitnan', 'Endpoints','shrink');
    if isempty(all_projs1_hit)
        x(i_s,numel(numbins)-1)=NaN;
    else
        endpoints = nanmean(all_projs1_hit(:,tidx),2);
        x(i_s,:)=histcounts(endpoints,numbins)/numel(endpoints);
        if numel(endpoints)<min_num_trials
            x(i_s,:)=NaN;
        end
    end
end