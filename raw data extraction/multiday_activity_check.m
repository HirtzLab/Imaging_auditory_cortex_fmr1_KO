%Authors: Simon Wadle, 2019-2023
%function uses dF/F activity from each cell and analyzes baseline activity
%between days to exclude cells being not atice at certain days

root_path = 'directory';
smooth_flag = 1;

all_mat_files = dir([root_path, '\**\complete_data_Fall.mat']);
fprintf('file %3d of %3d', 1, size(all_mat_files, 1))
for k = 1:size(all_mat_files, 1)
    [cell_ids{k},excluded_cells{k},fractions(k)] = single_file_analysis(fullfile(all_mat_files(k).folder, all_mat_files(k).name), smooth_flag);
    fprintf('\b\b\b\b\b\b\b\b\b\b%3d of %3d', k, size(all_mat_files, 1))
end


function [cell_ids, excluded_cells, fraction_of_discarded_cells] = single_file_analysis(filename, smooth_flag)

load(filename, 'param_table', 'neuropil_traces','raw_traces', 'list')
day_names = unique(param_table.day);
dB_values = zeros(1,size(raw_traces,1));
daily_logical = nan(size(raw_traces));
for ii = 1:size(day_names,1)
    last_idx = max(find(strcmp(string(param_table.day), day_names{ii}),1,'last'));
    first_idx = max(find(strcmp(string(param_table.day), day_names{ii}),1,'first'));
    if first_idx == 1
        start_frame_of_cur_day = 1;
    else
        start_frame_of_cur_day = sum([param_table.number_of_frames{1:first_idx-1}])+1;
    end

    end_frame_of_cur_day = sum([param_table.number_of_frames{1:last_idx}]);

    if smooth_flag
        raw_traces_smooth = movmean(raw_traces,7,2);

        for j = 1:size(raw_traces,1)
            dB_values(ii,j) = 20*log(max(raw_traces_smooth(j,start_frame_of_cur_day:end_frame_of_cur_day)-neuropil_traces(j,start_frame_of_cur_day:end_frame_of_cur_day))/std(neuropil_traces(j,start_frame_of_cur_day:end_frame_of_cur_day)));
        end
    else

        for j = 1:size(raw_traces,1)
            dB_values(ii,j) = 20*log(max(raw_traces(j,start_frame_of_cur_day:end_frame_of_cur_day)-neuropil_traces(j,start_frame_of_cur_day:end_frame_of_cur_day))/std(neuropil_traces(j,start_frame_of_cur_day:end_frame_of_cur_day)));
        end
    end

 
    daily_logical(dB_values(ii,:)<36,start_frame_of_cur_day:end_frame_of_cur_day) = 0;
    daily_logical(~(dB_values(ii,:)<36),start_frame_of_cur_day:end_frame_of_cur_day) = 1;

end
excluded_cells = [];
for ii = 1:size(cell_ids,2)
    excluded_cells = [excluded_cells;cell_ids{ii}];
end
excluded_cells = unique(excluded_cells);

fraction_of_discarded_cells = length(excluded_cells)./size(raw_traces,1);
end