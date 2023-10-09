function FRA_analysis_combine_awake(complete_FRA_files,save_path_input,Rsquare_threshold)
% Authors: Simon Wadle & Tatjana Schmitt, 2019-2023
% this function extracts important parameter from FRA data
% gets called by 'pipeline_complete_SPLanalysis_awake_FMR1.m'

for ii = 1:size(complete_FRA_files, 1)

    path_parts = split(complete_FRA_files(ii).folder, '\');
    animal_path = fullfile(path_parts{1:end-2});
    all_animal_files = cellfun(@(x) strfind(x, animal_path), {complete_FRA_files.folder}, 'uni', false);
    logical_idx_animal = ~cellfun(@isempty, all_animal_files);
    cur_animal_filenames = {complete_FRA_files(logical_idx_animal).name};
    date_collection = zeros();
    for j = 1:size(cur_animal_filenames, 2)
        date_collection(j) = str2double(cur_animal_filenames{j}(end-35:end-28));        
    end
    recording_dates = unique(date_collection);    
    
    if sum(strcmp(complete_FRA_files(ii).folder, {complete_FRA_files.folder})) > 1
        cur_files = complete_FRA_files(strcmp(complete_FRA_files(ii).folder, {complete_FRA_files.folder}));
        cur_files_sorted = table2struct(sortrows(struct2table(cur_files), "name"));
        FRA_files_day_1_double(ii) = cur_files_sorted(1,1);
        FRA_files_day_2_double(ii) = cur_files_sorted(2,1);
    elseif size(recording_dates, 2) < 3
        FRA_files_day_1_double(ii) = complete_FRA_files(ii);
    elseif find(recording_dates == str2double(complete_FRA_files(ii).name(end-35:end-28))) > 2
        FRA_files_day_2_double(ii) = complete_FRA_files(ii);
    elseif find(recording_dates == str2double(complete_FRA_files(ii).name(end-35:end-28))) < 3
        FRA_files_day_1_double(ii) = complete_FRA_files(ii);
    else
        warning('file could not be assigned to date')
    end
end
FRA_files_day_1_double(cellfun(@isempty, {FRA_files_day_1_double.name})) = [];
FRA_files_day_2_double(cellfun(@isempty, {FRA_files_day_2_double.name})) = [];

[~, ia_day1, ~] = unique({FRA_files_day_1_double.name});
FRA_files_day_1 = FRA_files_day_1_double(ia_day1);
[~, ia_day2, ~] = unique({FRA_files_day_2_double.name});
FRA_files_day_2 = FRA_files_day_2_double(ia_day2);
%%
save_flag = true;
%%
for j = 1:2
    if j == 1
        cur_FRA_files = FRA_files_day_1;
        [path, name, ext] = fileparts(save_path_input);
        save_path = fullfile(path, [name,'_day1', ext]);
    else
        [path, name, ext] = fileparts(save_path_input);
        save_path = fullfile(path, [name,'_day2', ext]);
        cur_FRA_files = FRA_files_day_2;
    end
    Rsquare = zeros;
    FWHM_1 = zeros;
    FWHM_2 = zeros;
    all_BFs = zeros;
    BF_single_peak = zeros;
    BF_double_peak = zeros;
    percentage_PT = zeros;
    percentage_tuning = zeros;
    tuning_overview = zeros;        %% cellID, redcell, subfield, BF, peaks, FWHM
    center_frequency = zeros;
    center_frequency_single_peak = zeros;

    cnt_PT_res_cells = 1;
    cnt_FWHM_1 = 1;
    cnt_FWHM_2 = 1;
    FOV = 1;

    for m = 1:size(cur_FRA_files,2)
        % load FOV FRA analysis
        FOV_path = cur_FRA_files(m).folder;
        FOV_file = cur_FRA_files(m).name;
        load(fullfile(FOV_path, FOV_file), 'BF_grouped', 'all_activities_cells', 'p_values_BF', 'fitted_parameter');

        % load FOV subfield list with global coordinates and subfields
        path_parts = split(FOV_path,'\');
        FOV_folder = fullfile(path_parts{1:end-1});

        temp_filepath_dataFall = [FOV_folder, '\**\complete_data_Fall.mat'];
        data_Fall_file = dir(temp_filepath_dataFall);

        load(fullfile(data_Fall_file.folder, data_Fall_file.name), 'list_subfields');
        if exist('list_subfields', 'var')
            % combine cells
            single_peak = 0;
            double_peak = 0;
            for ii = 1:size(BF_grouped,1)
                if fitted_parameter.Rsquare_adj(ii,1) < Rsquare_threshold
                    fitted_parameter.amplitude(ii,1) = nan;
                    fitted_parameter.amplitude(ii,2) = nan;
                    fitted_parameter.FWHM(ii,1) = nan;
                    fitted_parameter.FWHM(ii,2) = nan;
                    fitted_parameter.peaks(ii,1) = 0;
                end
                if isnan(BF_grouped(ii,1))
                    continue
                else
                    Rsquare(cnt_PT_res_cells,1) = fitted_parameter.Rsquare(ii,1);
                    all_BFs(cnt_PT_res_cells,1) = BF_grouped(ii,1);
                    all_BFs(cnt_PT_res_cells,2) = list_subfields(ii,2);
                    all_BFs(cnt_PT_res_cells,3) = list_subfields(ii,3);
                    all_BFs(cnt_PT_res_cells,4) = 1;
                    all_BFs(cnt_PT_res_cells,5) = list_subfields(ii,5);
                    all_BFs(cnt_PT_res_cells,6) = list_subfields(ii,6);
                    center_frequency(cnt_PT_res_cells,1) = fitted_parameter.center(ii,1);
                    center_frequency(cnt_PT_res_cells,2) = list_subfields(ii,2);
                    center_frequency(cnt_PT_res_cells,3) = list_subfields(ii,3);
                    center_frequency(cnt_PT_res_cells,4) = 1;
                    center_frequency(cnt_PT_res_cells,5) = list_subfields(ii,5);
                    center_frequency(cnt_PT_res_cells,6) = list_subfields(ii,6);
                    tuning_overview(cnt_PT_res_cells,1) = list_subfields(ii,6);
                    tuning_overview(cnt_PT_res_cells,2) = 1;
                    tuning_overview(cnt_PT_res_cells,3) = BF_grouped(ii,1);
                    tuning_overview(cnt_PT_res_cells,4) = list_subfields(ii,5);
                    tuning_overview(cnt_PT_res_cells,5) = fitted_parameter.peaks(ii,1);
                    tuning_overview(cnt_PT_res_cells,6) = fitted_parameter.FWHM(ii,1);
                    tuning_overview(cnt_PT_res_cells,7) = fitted_parameter.FWHM(ii,2);
                    tuning_overview(cnt_PT_res_cells,8) = fitted_parameter.Rsquare_adj(ii,1);

                    cnt_PT_res_cells = cnt_PT_res_cells + 1;
                    if fitted_parameter.peaks(ii,1) == 1
                        BF_single_peak(cnt_FWHM_1,1) = BF_grouped(ii,1);
                        BF_single_peak(cnt_FWHM_1,2) = list_subfields(ii,2);
                        BF_single_peak(cnt_FWHM_1,3) = list_subfields(ii,3);
                        BF_single_peak(cnt_FWHM_1,4) = 1;
                        BF_single_peak(cnt_FWHM_1,5) = list_subfields(ii,5);
                        BF_single_peak(cnt_FWHM_1,6) = list_subfields(ii,6);
                        center_frequency_single_peak(cnt_FWHM_1,1) = fitted_parameter.center(ii,1);
                        center_frequency_single_peak(cnt_FWHM_1,2) = list_subfields(ii,2);
                        center_frequency_single_peak(cnt_FWHM_1,3) = list_subfields(ii,3);
                        center_frequency_single_peak(cnt_FWHM_1,4) = 1;
                        center_frequency_single_peak(cnt_FWHM_1,5) = list_subfields(ii,5);
                        center_frequency_single_peak(cnt_FWHM_1,6) = list_subfields(ii,6);
                        FWHM_1(cnt_FWHM_1,1) = fitted_parameter.FWHM(ii,1);
                        cnt_FWHM_1 = cnt_FWHM_1 + 1;
                        single_peak = single_peak + 1;
                    elseif fitted_parameter.peaks(ii,1) == 2
                        BF_double_peak(cnt_FWHM_2,1) = BF_grouped(ii,1);
                        BF_double_peak(cnt_FWHM_2,2) = list_subfields(ii,2);
                        BF_double_peak(cnt_FWHM_2,3) = list_subfields(ii,3);
                        BF_double_peak(cnt_FWHM_2,4) = 1;
                        BF_double_peak(cnt_FWHM_2,5) = list_subfields(ii,5);
                        BF_double_peak(cnt_FWHM_2,6) = list_subfields(ii,6);
                        FWHM_2(cnt_FWHM_2,1) = fitted_parameter.FWHM(ii,1);
                        FWHM_2(cnt_FWHM_2,2) = fitted_parameter.FWHM(ii,2);
                        cnt_FWHM_2 = cnt_FWHM_2 + 1;
                        double_peak = double_peak +1;
                    else
                        continue
                    end
                end
            end

            PT_responsive = size(BF_grouped(~isnan(BF_grouped(:,1)),1),1);

            percentage_PT(FOV,1) = PT_responsive./size(BF_grouped,1)*100;
            percentage_tuning(FOV,1) = single_peak./PT_responsive * 100;
            percentage_tuning(FOV,2) = double_peak./PT_responsive * 100;
            percentage_tuning(FOV,3) = (PT_responsive - single_peak - double_peak)./PT_responsive * 100;

            FOV = FOV+1;
        end
    end

    mean_percentage_tuning = mean(percentage_tuning, 'omitnan');
    mean_percentage_PT = mean(percentage_PT, 'omitnan');
    FWHM_2_broad = zeros(size(FWHM_2,1),1);
    FWHM_2_narrow = zeros(size(FWHM_2,1),1);
    FWHM_2_ratio = zeros(size(FWHM_2,1),1);

    if size(FWHM_2,2) == 2
        for ii = 1:size(FWHM_2,1)
            if FWHM_2(ii,1) > FWHM_2(ii,2)
                FWHM_2_broad(ii,1) = FWHM_2(ii,1);
                FWHM_2_narrow(ii,1) = FWHM_2(ii,2);
                FWHM_2_ratio(ii,1) = FWHM_2(ii,2)/FWHM_2(ii,1);
            else
                FWHM_2_broad(ii,1) = FWHM_2(ii,2);
                FWHM_2_narrow(ii,1) = FWHM_2(ii,1);
                FWHM_2_ratio(ii,1) = FWHM_2(ii,1)/FWHM_2(ii,2);
            end
        end
    end

    if save_flag
        disp('saving...')
        save(save_path, 'all_activities_cells', 'all_BFs', 'BF_double_peak', 'BF_single_peak', 'FWHM_1', 'FWHM_2',...
            'FWHM_2_broad', 'FWHM_2_narrow', 'FWHM_2_ratio', 'percentage_PT', 'percentage_tuning',...
            'mean_percentage_tuning', 'mean_percentage_PT', 'PT_responsive', 'p_values_BF', ...
            'Rsquare', 'tuning_overview', 'center_frequency', 'center_frequency_single_peak', '-v7.3')
        disp('saving done.')
    end

    disp('done')
end
end