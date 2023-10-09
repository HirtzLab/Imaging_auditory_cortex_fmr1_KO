function frequency_response_area(SPL_file,fit_flag,overwrite)
% Authors: Simon Wadle & Tatjana Schmitt, 2019-2023
% this function constructs FRAs and fits the mean over SPLs
% gets called by 'pipeline_complete_SPLanalysis_awake_FMR1.m'


%% load file
load(SPL_file, 'export_struct');

%% extract data
temp_fieldnames = fieldnames(export_struct);

for m = 1:size(temp_fieldnames,1)
    [save_path,~, ~] =fileparts(SPL_file);
    name = strcat(temp_fieldnames{m,1});
    if fit_flag
        save_file = fullfile(save_path, strcat(name,'_FRA_analysis_fitted_all.mat'));
    else
        save_file = fullfile(save_path, strcat(name,'_FRA_analysis_all.mat'));
    end
    if overwrite
        do_analysis_flag = 1;
    elseif ~exist(save_file,"file")
        do_analysis_flag = 1;
    else
        do_analysis_flag = 0;
    end
    if do_analysis_flag
        save_table = export_struct.(temp_fieldnames{m,1});
        keep_logical = ones(size(save_table.post_means{1,1},1),1);
        % get rid of NaNs
        for k = 1:size(save_table,1)
            for ii = 1:size(save_table.post_means{1,1},1)
                if sum(isnan(save_table.post_means{k,1}(ii,:))) == size(save_table.post_means{k,1}(ii,:),2)
                    keep_logical(ii) = 0;
                end
            end
            save_table.Cell_ID{k,1}(~keep_logical,:) = [];
            save_table.BF{k,1}(~keep_logical,:) = [];
            save_table.plot_sequences{k,1}(~keep_logical,:) = [];
            save_table.post_means_event{k,1}(~keep_logical,:) = [];
            save_table.pre_means{k,1}(~keep_logical,:) = [];
            save_table.post_means{k,1}(~keep_logical,:) = [];
            save_table.events{k,1}(~keep_logical,:) = [];
            save_table.p_values_ttest{k,1}(~keep_logical,:) = [];
            save_table.p_values_ANOVA_all{k,1}(~keep_logical,:) = [];
            save_table.p_values_ANOVA_grouped{k,1}(~keep_logical,:) = [];
        end

        % get cell ID list
        cell_IDs = save_table.Cell_ID{1,1};

        % write all spike deconvolution values and ANOVA p_values into matrix
        all_activities_cells = cell(size(save_table.Cell_ID{1,1}, 1), 8);

        for ii = 1:size(all_activities_cells, 1)
            for j = 1:size(save_table.post_means{1,1},2)
                for k = 1:size(save_table,1)
                    all_activities_cells{ii,1}(k,j) = save_table.post_means{k,1}(ii,j);
                    all_activities_cells{ii,4}(k,j) = save_table.p_values_ANOVA_all{k,1}(ii,j);
                    all_activities_cells{ii,6}(k,j) = save_table.p_values_ANOVA_grouped{k,1}(ii,j);
                end
            end
        end

        % reading & writing BFs from Matlab GUI
        BFs = zeros(size(all_activities_cells, 1), size(save_table,1));
        for ii = 1:size(all_activities_cells, 1)
            for j = 1:size(BFs,2)
                BFs(ii,j) =  save_table.BF{j,1}(ii,2);
            end
        end

        % normalize spike deconvolution values & get all values at significant
        % responses (with increased mean values)

        for ii = 1:size(all_activities_cells, 1)
            for j = 1:size(save_table.post_means{1,1},2)
                for k = 1:size(save_table,1)
                    max_act = max(all_activities_cells{ii,1}, [], 'all');
                    all_activities_cells{ii,3}(k,j) = all_activities_cells{ii,1}(k,j)/max_act;
                    % do it for single ANOVA
                    if all_activities_cells{ii,4}(k,j) < 0.01 && save_table.pre_means{k,1}(ii,j) < save_table.post_means{k,1}(ii,j)
                        all_activities_cells{ii,5}(k,j) = all_activities_cells{ii,3}(k,j);
                    else
                        all_activities_cells{ii,5}(k,j) = 0;
                    end
                    % do it for grouped ANOVA
                    if all_activities_cells{ii,6}(k,j) < 0.01 && save_table.pre_means{k,1}(ii,j) < save_table.post_means{k,1}(ii,j)
                        all_activities_cells{ii,7}(k,j) = all_activities_cells{ii,3}(k,j);
                    else
                        all_activities_cells{ii,7}(k,j) = 0;
                    end
                end
            end
        end

        % check for PT responsive neurons (1 or 0)
        for ii = 1:size(all_activities_cells,1)
            % single ANOVA
            if sum(all_activities_cells{ii,5}, 'all') == 0
                all_activities_cells{ii,2}(1,1) = 0;
            else
                all_activities_cells{ii,2}(1,1) = 1;
            end
            % grouped_ANOVA
            if sum(all_activities_cells{ii,7}, 'all') == 0
                all_activities_cells{ii,8}(1,1) = 0;
            else
                all_activities_cells{ii,8}(1,1) = 1;
            end
        end

        % calculate mean FRAs from significant responses (with increased mean values)
        FRAs_mean_single_ANOVA = zeros(size(save_table.post_means{1,1},2), size(all_activities_cells, 1));
        FRAs_mean_grouped_ANOVA = zeros(size(save_table.post_means{1,1},2), size(all_activities_cells, 1));
        FRAs_mean_all = zeros(size(save_table.post_means{1,1},2), size(all_activities_cells, 1));
        for ii = 1:size(FRAs_mean_single_ANOVA, 1)
            for j = 1:size(FRAs_mean_single_ANOVA, 2)
                FRAs_mean_all(ii,j) = mean(all_activities_cells{j,3}(:,ii),'omitnan');
                FRAs_mean_single_ANOVA(ii,j) = mean(all_activities_cells{j,5}(:,ii),'omitnan');
                FRAs_mean_grouped_ANOVA(ii,j) = mean(all_activities_cells{j,7}(:,ii),'omitnan');
            end
        end

        % normalize mean FRAs
        FRAs_norm_all = zeros(size(FRAs_mean_all));
        for ii = 1:size(FRAs_norm_all,2)
            max_act = max(FRAs_mean_all(:,ii));
            FRAs_norm_all(:,ii) = FRAs_mean_all(:,ii)/max_act;
        end

        FRAs_norm_single_ANOVA = zeros(size(FRAs_mean_single_ANOVA));
        for ii = 1:size(FRAs_norm_single_ANOVA,2)
            max_act = max(FRAs_mean_single_ANOVA(:,ii));
            FRAs_norm_single_ANOVA(:,ii) = FRAs_mean_single_ANOVA(:,ii)/max_act;
        end

        FRAs_norm_grouped_ANOVA = zeros(size(FRAs_mean_grouped_ANOVA));
        for ii = 1:size(FRAs_norm_grouped_ANOVA,2)
            max_act = max(FRAs_mean_grouped_ANOVA(:,ii));
            FRAs_norm_grouped_ANOVA(:,ii) = FRAs_mean_grouped_ANOVA(:,ii)/max_act;
        end

        % calculate 'real' BF
        BF = zeros(size(BFs,1),1);
        BF_grouped = zeros(size(BFs,1),1);
        frequencies = [4, 5, 6, 7, 8, 10, 12, 14, 16, 20, 24, 28, 32, 40, 48, 56, 64];
        frequencies = 1000 .* frequencies;
        for ii = 1:size(BF,1)
            if all_activities_cells{ii,2} == 1
                [row, col] = find(all_activities_cells{ii,3} == 1);
                BF(ii,1) = frequencies(1, col);
                BF(ii,2) = save_table.p_values_ANOVA_all{row,1}(ii, col);
            else
                BF(ii,1) = nan;
            end
            if all_activities_cells{ii,8} == 1
                [row, col] = find(all_activities_cells{ii,3} == 1);
                BF_grouped(ii,1) = frequencies(1, col);
                BF_grouped(ii,2) = save_table.p_values_ANOVA_grouped{row,1}(ii, col);
            else
                BF_grouped(ii,1) = nan;
            end
        end

        % get p_value
        p_values_BF = cell(size(FRAs_mean_single_ANOVA,2),1);
        for ii = 1:size(p_values_BF,1)
            for j = 1:size(save_table,1)
                p_values_BF{ii,1}(j,1) = BFs(ii,j);
                if isnan(BFs(ii,j))
                    [~, idx] = max(all_activities_cells{ii,3}(j,:));
                    p_values_BF{ii,1}(j,2) = save_table.p_values_ttest{j,1}(ii,idx);
                else
                    [~, col] = find(frequencies(1,:) == BFs(ii,j));
                    p_values_BF{ii,1}(j,2) = save_table.p_values_ttest{j,1}(ii,col);
                end
            end
        end

        all_activities_cells = array2table(all_activities_cells, 'VariableNames',...
            {'spike_deconv'; 'PTresponsive'; 'spike_deconv_norm'; 'single_ANOVA_p_value'; 'spike_devonc_significant_single_ANOVA';'grouped_ANOVA_p_value';'spike_devonc_significant_grouped_ANOVA';'PTresponsive_grouped_ANOVA'});

        %% fit function
        if overwrite
            if fit_flag
                [fitted_parameter, fit_param, fit_param_both, gof_fit] = FRA_mean_gauss_fit(all_activities_cells, FRAs_norm_all);
                save(save_file, 'BF', 'BFs', 'BF_grouped', 'all_activities_cells', 'FRAs_norm_single_ANOVA', 'FRAs_norm_all', ...
                    'fitted_parameter', 'fit_param', 'gof_fit', 'fit_param_both', 'p_values_BF', 'cell_IDs','FRAs_norm_grouped_ANOVA', '-v7.3')
            else
                save_file = fullfile(save_path, strcat(name,'_FRA_analysis.mat'));
                save(save_file, 'BF', 'BFs', 'BF_grouped', 'all_activities_cells', 'FRAs_norm_single_ANOVA', 'FRAs_norm_all', ...
                    'p_values_BF', 'cell_IDs','FRAs_norm_grouped_ANOVA', '-v7.3', '-append')
            end
        elseif ~exist(save_file, "file")
            if fit_flag
                [fitted_parameter, fit_param, fit_param_both, gof_fit] = FRA_mean_gauss_fit(all_activities_cells, FRAs_norm_all);
                save(save_file, 'BF', 'BFs', 'BF_grouped', 'all_activities_cells', 'FRAs_norm_single_ANOVA', 'FRAs_norm_all', ...
                    'fitted_parameter', 'fit_param','gof_fit', 'fit_param_both', 'p_values_BF', 'cell_IDs','FRAs_norm_grouped_ANOVA', '-v7.3')
            else
                save_file = fullfile(save_path, strcat(name,'_FRA_analysis.mat'));
                save(save_file, 'BF', 'BFs', 'BF_grouped', 'all_activities_cells', 'FRAs_norm_single_ANOVA', 'FRAs_norm_all', ...
                    'p_values_BF', 'cell_IDs','FRAs_norm_grouped_ANOVA', '-v7.3')
            end
        end
    end
end