function FRA_analysis_subfields(FRA_file_input, genotype)
% Authors: Simon Wadle & Tatjana Schmitt, 2019-2023
% this function sorts FRA parameter on a subfield-specific basis
% gets called by 'pipeline_complete_SPLanalysis_awake_FMR1.m'

for j = 1:2
    if j == 1
        [path, name, ext] = fileparts(FRA_file_input);
        FRA_file = fullfile(path, [name,'_day1', ext]);
        save_file = fullfile(path,['FRA_analysis_subfields_',genotype,'_day1.mat']);
    else
        [path, name, ext] = fileparts(FRA_file_input);
        FRA_file = fullfile(path, [name,'_day2', ext]);
        save_file = fullfile(path,['FRA_analysis_subfields_',genotype,'_day2.mat']);
    end


    % get file
    load(FRA_file, 'tuning_overview');

    % calculation
    FRAs_single_subfields = cell(1,3);
    FRAs_double_narrow_subfields = cell(1,3);
    FRAs_double_broad_subfields = cell(1,3);
    percentage_PT_subfields = cell(1,3);
    percentage_tuning_subfields = cell(1,3);


    for ii = 1:size(tuning_overview,1)
        if tuning_overview(ii,5) == 1
            FRAs_single_subfields{1,tuning_overview(ii,4)}(end+1, 1) = tuning_overview(ii,6);
        elseif tuning_overview(ii,5) == 2
            if tuning_overview(ii,6) < tuning_overview(ii,7)
                FRAs_double_narrow_subfields{1,tuning_overview(ii,4)}(end+1, 1) = tuning_overview(ii,6);
                FRAs_double_broad_subfields{1, tuning_overview(ii,4)}(end+1, 1) = tuning_overview(ii,7);
            else
                FRAs_double_narrow_subfields{1,tuning_overview(ii,4)}(end+1, 1) = tuning_overview(ii,7);
                FRAs_double_broad_subfields{1, tuning_overview(ii,4)}(end+1, 1) = tuning_overview(ii,6);
            end
        else
            continue
        end
    end

    for ii = 1:3
        FRAs_single_subfields{2,ii} = mean(FRAs_single_subfields{1,ii});
        FRAs_double_narrow_subfields{2,ii} = mean(FRAs_double_narrow_subfields{1,ii});
        FRAs_double_broad_subfields{2,ii} = mean(FRAs_double_broad_subfields{1,ii});
    end

    
    disp('saving...')
    save(save_file, 'FRAs_single_subfields', 'FRAs_double_broad_subfields', ...
        'FRAs_double_narrow_subfields', '-v7.3')
    disp('saving done.')

end
end