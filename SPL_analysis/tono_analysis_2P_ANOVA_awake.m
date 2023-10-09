% Authors: Simon Wadle, 2019-2023
% this function takes the output from 'multiple_day_Fall_extraction_v3_2.m'
% and extracts activity from each cell aligns it to the tone onset and
% analyzes pre and post activity via ANOVA

clearvars
% analysis options
pre_analysis_window = 12;           % How many frames before stimulus onset will be analyzed
post_analysis_window = 12;          % How many frames after stimulus onset (including onset_frame) will be analyzed
alpha_level = 0.05;
% Plotting options
gap = 5;                            % how many nans to insert between different frequency sequences for plotting sequence
pre_offset = 12;                    % how many frames before stimulus onset you want to include in plotting sequence
post_offset = 12;                   % how many frames after stimulus offset you want to include in plotting sequence

root_path = 'dircetory';

filepath_Fall = [root_path, '\**\complete_data_Fall.mat'];
Fall_complete_data_files = dir(filepath_Fall);
FOV_counter = 1;
for ii = 1:size(Fall_complete_data_files,1)
    dir_name_temp = Fall_complete_data_files(ii).folder;
    path_parts_temp = split(dir_name_temp,'\');
    if contains(path_parts_temp{end-2}, 'FOV')
        Fall_complete_data_files_corrected{FOV_counter,1} = fullfile(Fall_complete_data_files(ii).folder,Fall_complete_data_files(ii).name);
        save_identifier{FOV_counter,1} = [replace(path_parts_temp{end-2}, '-', '_'),'_',path_parts_temp{end-4}];
        FOV_counter = FOV_counter+1;
    end
end

for n = 1:size(Fall_complete_data_files_corrected,1)
    disp(['analyzing file ',num2str(n), '/', num2str(size(Fall_complete_data_files_corrected,1))])
    disp(Fall_complete_data_files_corrected{n,1})
    DATA = load(Fall_complete_data_files_corrected{n,1}, 'param_table', 'list', 'spk_traces', 'df_f_traces', 'daily_logical', 'running_trace_logical_matrix');    

    % Calculate short indices of original trace and cut it
    stimulation_list = {'PT_'};
    idx_PT_stim = zeros(1,5);
    cnt_PT_stim = 1;
    for ii = 1:size(DATA.param_table,1)
        if ii == size(DATA.param_table,1)
            if contains(DATA.param_table.Properties.RowNames{ii,1}, stimulation_list)
                idx_PT_stim(1, cnt_PT_stim) = ii;
                cnt_PT_stim = cnt_PT_stim + 1;
            end
        else
            if contains(DATA.param_table.Properties.RowNames{ii,1}, stimulation_list) && ~contains(DATA.param_table.Properties.RowNames{ii+1,1}, 'AM')
                idx_PT_stim(1, cnt_PT_stim) = ii;
                cnt_PT_stim = cnt_PT_stim + 1;
            end
        end
    end
    disp(['Found ', num2str(cnt_PT_stim-1), ' different SPLs for PT stimulation.']);
    idx_PT_stim_cur_day = [];
    export_struct = [];
    if sum(idx_PT_stim,2) > 1
        idx_PT_stim_cur_day(1,1:5) = idx_PT_stim(1:5);
        if size(idx_PT_stim,2) > 5
            idx_PT_stim_cur_day(2,1:5) = idx_PT_stim(6:10);
        end
        for q = 1:size(idx_PT_stim_cur_day,1)
            save_table = create_analysis_table;
            num_of_freqs = size(DATA.param_table.stim_times{idx_PT_stim(1,1),1},1);
            BF_neurons = DATA.list(:,1);
            for m = idx_PT_stim_cur_day(q,1):idx_PT_stim_cur_day(q,end)
                repetitions = DATA.param_table.repetitions{m,1};
                pre_means = [];
                post_means = [];
                post_means_event = [];
                p_values = [];
                events = [];
                p = [];
                p2 = [];
                corrected_spk_traces = exclude_running_and_bad_days(DATA.spk_traces, DATA.running_trace_logical_matrix, DATA.daily_logical,DATA.param_table.stim_times{m}, pre_analysis_window, post_analysis_window, 'both');
                corrected_df_f_traces = exclude_running_and_bad_days(DATA.df_f_traces, DATA.running_trace_logical_matrix, DATA.daily_logical,DATA.param_table.stim_times{m},pre_analysis_window, post_analysis_window, 'both');
                for k = 1:size(corrected_spk_traces,1)
                    max_value_spk = max(corrected_spk_traces(k,:));
                    min_value_spk = min(corrected_spk_traces(k,:));
                    max_value_df_f = max(corrected_df_f_traces(k,:));
                    min_value_df_f = min(corrected_df_f_traces(k,:));
                    pre_values = {};
                    post_values = {};
                    pre_means_single_rep = [];
                    post_means_single_rep = [];
                    for ii = 1:repetitions
                        stimulus_offset = 0;
                        cur_trace_x = [];
                        cur_trace_y = [];
                        cur_trace_y_df_f = [];                        

                        for j = 1:num_of_freqs
                            % cut traces for analysis
                            stim_start = DATA.param_table.stim_times{m,1}{j,1}(1,ii);
                            stim_end = DATA.param_table.stim_times{m,1}{j,1}(2,ii);

                            analysis_trace = corrected_spk_traces(k,round(stim_start - pre_analysis_window):round(stim_start + post_analysis_window));
                            pre_values{ii,j} = analysis_trace(1:pre_analysis_window);
                            post_values{ii,j} = analysis_trace(end - post_analysis_window+1:end);
                            pre_means_single_rep(ii,j) = mean(analysis_trace(1:pre_analysis_window),2);
                            post_means_single_rep(ii,j) = mean(analysis_trace(end - post_analysis_window+1:end),2);

                            % cut traces for plot sequence of mean dF/F & spk trace
                            stim_length = stim_end - stim_start;
                            start_frame = round(stim_start) - pre_offset;
                            end_frame = round(stim_end) + post_offset;
                            stimulus_end = stim_length + pre_offset + post_offset + stimulus_offset;
                            cur_trace_x = [cur_trace_x, stimulus_offset:stimulus_end];
                            cur_trace_y = [cur_trace_y, corrected_spk_traces(k,start_frame:end_frame)];
                            cur_trace_y_df_f = [cur_trace_y_df_f, corrected_df_f_traces(k,start_frame:end_frame)];
                            patches_x(:,j) = [pre_offset + stimulus_offset, pre_offset + stim_length + stimulus_offset, pre_offset+stim_length + stimulus_offset, pre_offset + stimulus_offset];
                            patches_y_spk(:,j) = [min_value_spk, min_value_spk, max_value_spk.*1.1, max_value_spk.*1.1];
                            patches_y_df_f(:,j) = [min_value_df_f, min_value_df_f, max_value_df_f.*1.1, max_value_df_f.*1.1];

                            stimulus_offset = stimulus_offset + stim_length + pre_offset + post_offset + gap;
                            cur_trace_x(end+1:end+gap) = nan;
                            while length(cur_trace_x) > length(cur_trace_y)
                                cur_trace_y(end+1) = nan;
                                cur_trace_y_df_f(end+1) = nan;
                            end

                        end
                        y_trace_collection(ii,:) = cur_trace_y;
                        y_trace_collection_df_f(ii,:) = cur_trace_y_df_f;
                    end

                    for ii = 1:num_of_freqs
                        alternating_pre_post = [reshape([pre_values{:,ii}],[],repetitions),reshape([post_values{:,ii}],[],repetitions)];                        
                        two_column_anova = [[pre_values{:,ii}]',[post_values{:,ii}]'];
                        if sum(isnan(two_column_anova(:,1))) > length(two_column_anova)/2
                            p(k,ii) = nan;
                            p2(k,ii) = nan;
                        else
                            p(k,ii) = anova1(alternating_pre_post,[], 'off');
                            p2(k,ii) = anova1(two_column_anova,[],'off');
                        end
                    end
                    % test the pre vs post means of each repetitions against each other and save input traces, p-values and wheter the p-value is beneath
                    % alpha_level (event)
                    mean_values = [pre_means_single_rep; post_means_single_rep];


                    for ii = 1:size(mean_values, 2)
                        [events(k,ii), pre_means(k,ii), post_means(k,ii), ~, p_values(k,ii)] = CheckResponse(mean_values(:,ii)', repetitions, alpha_level);
                    end

                    % get best frequency by comparing the highest mean of the post_means from each repetition, when it is a event
                    post_means_event(k,:) = post_means(k,:);
                    post_means_event(k,p2(k,:)>alpha_level) = nan;
                    post_means_event(k,isnan(p2(k,:))) = nan;
                    frequencies = [DATA.param_table.stim_times{m,1}{:,2}];
                    [~,idx] = find(post_means_event(k,:) == max(post_means_event(k,:)));
                    if isempty(idx)
                        BF_neurons(k,2) = nan;
                    else
                        BF_neurons(k,2) = frequencies(1,idx);
                    end
                    plot_sequences{k,1} = cur_trace_x;
                    plot_sequences{k,2} = y_trace_collection;
                    plot_sequences{k,3} = mean(y_trace_collection,1,"omitnan");
                    plot_sequences{k,4} = y_trace_collection_df_f;
                    plot_sequences{k,5} = mean(y_trace_collection_df_f,1,"omitnan");
                    plot_sequences{k,6} = patches_x;
                    plot_sequences{k,7} = patches_y_spk;
                    plot_sequences{k,8} = patches_y_df_f;
                end
                plot_structure.x_values = plot_sequences(:,1);
                plot_structure.y_values_rep_spk = plot_sequences(:,2);
                plot_structure.y_values_mean_spk = plot_sequences(:,3);
                plot_structure.y_values_rep_df_f = plot_sequences(:,4);
                plot_structure.y_values_mean_df_f = plot_sequences(:,5);
                plot_structure.x_values_patches = plot_sequences(:,6);
                plot_structure.y_values_patches_spk = plot_sequences(:,7);
                plot_structure.y_values_patches_df_f = plot_sequences(:,8);
                plot_table = struct2table(plot_structure);
                if size(DATA.list,2)>3
                    save_table = [save_table; {DATA.list(:,[1,4]), BF_neurons, plot_table, post_means_event, pre_means, post_means, events, p_values, p, p2}];
                else
                    save_table = [save_table; {DATA.list(:,1), BF_neurons, plot_table, post_means_event, pre_means, post_means, events, p_values, p, p2}];
                end
                plot_sequences = [];
            end 
            cur_save_name = [save_identifier{n,1},'_',DATA.param_table.Properties.RowNames{idx_PT_stim_cur_day(q,1)}(end-7:end)];
            export_struct.(cur_save_name) = save_table;
        end

        path_parts = split(Fall_complete_data_files_corrected{n,1}, '\');
        save_dir = fullfile(path_parts{1:end-3},'TonotopyAnalysis');
        mkdir(save_dir)
        file_save_name = fullfile(save_dir,'Tono_analysis_ANOVA.mat');
        save(file_save_name, 'export_struct', '-v7.3' )

    else
        disp('no SPL stimulations found')
    end


end



function [event, pre_mean, post_mean, delta_mean, p_value] = CheckResponse(trace, stim_time_point, alpha_level)

post_mean = mean(trace(stim_time_point+1:end), 'omitnan');
pre_mean = mean(trace(1:stim_time_point), 'omitnan');
delta_mean = post_mean - pre_mean;
[event, p_value] = ttest2(trace(1:stim_time_point), trace(stim_time_point+1:end), 'Tail', "left", "Alpha", alpha_level);
if isnan(event)
    event = 0;
    p_value = 1;
end
end

function analysis_table = create_analysis_table

varnames = {...
    'Cell_ID',...
    'BF',...
    'plot_sequences',...
    'post_means_event', ...
    'pre_means', ...
    'post_means', ...
    'events', ...
    'p_values_ttest',...
    'p_values_ANOVA_all',...
    'p_values_ANOVA_grouped'...
    };

vartypes = {'cell','cell','cell','cell','cell','cell','cell','cell','cell','cell'};
varunits = {'', 'Hz', 'spike decon', 'spike decon', 'spike decon','spike decon','logical', '','',''};

analysis_table = table('Size', [0 size(varnames,2)], 'VariableTypes', vartypes, 'VariableNames', varnames');
analysis_table.Properties.VariableUnits = varunits;

end

function output_traces = exclude_running_and_bad_days(input_traces, running_logical, daily_logical, stim_times, pre_window, post_window, modifier)

switch modifier

    case 'both'
        running_corrected = input_traces;
        for ii = 1:size(stim_times,1)
            for k = 1:size(stim_times{ii,1},2)
                if sum(running_logical(1,round(stim_times{ii,1}(1,k)):round(stim_times{ii,1}(2,k)))) < length(running_logical(1,round(stim_times{ii,1}(1,k)):round(stim_times{ii,1}(2,k))))
                    running_corrected(:,round(stim_times{ii,1}(1,k))-pre_window:round(stim_times{ii,1}(1,k))+post_window) = nan;
                end
            end
        end

        daily_and_running_corrected = running_corrected;
        for ii = 1:size(daily_logical,1)
            for j = 1:size(stim_times,1)
                for k = 1:size(stim_times{j,1},2)
                    if sum(daily_logical(ii,round(stim_times{j,1}(1,k)):round(stim_times{j,1}(2,k)))) < length(daily_logical(ii,round(stim_times{j,1}(1,k)):round(stim_times{j,1}(2,k))))
                        daily_and_running_corrected(ii,round(stim_times{j,1}(1,k))-pre_window:round(stim_times{j,1}(1,k))+post_window) = nan;
                    end
                end
            end
        end
        output_traces = daily_and_running_corrected;

    case 'running'
        running_corrected = input_traces;
        for ii = 1:size(stim_times,1)
            for k = 1:size(stim_times{ii,1},2)
                if sum(running_logical(1,round(stim_times{ii,1}(1,k)):round(stim_times{ii,1}(2,k)))) < length(running_logical(1,round(stim_times{ii,1}(1,k)):round(stim_times{ii,1}(2,k))))
                    running_corrected(:,round(stim_times{ii,1}(1,k))-pre_window:round(stim_times{ii,1}(1,k))+post_window) = nan;
                end
            end
        end
        output_traces = running_corrected;

    case 'daily'
        daily_corrected = input_traces;
        for ii = 1:size(daily_logical,1)
            for j = 1:size(stim_times,1)
                for k = 1:size(stim_times{j,1},2)
                    if sum(daily_logical(ii,round(stim_times{j,1}(1,k)):round(stim_times{j,1}(2,k)))) < length(daily_logical(ii,round(stim_times{j,1}(1,k)):round(stim_times{j,1}(2,k))))
                        daily_corrected(ii,round(stim_times{j,1}(1,k))-pre_window:round(stim_times{j,1}(1,k))+post_window) = nan;
                    end
                end
            end
        end
        output_traces = daily_corrected;

end


end
