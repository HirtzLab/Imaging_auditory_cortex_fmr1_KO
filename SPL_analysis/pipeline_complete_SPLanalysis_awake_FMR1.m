% Authors: Simon Wadle & Tatjana Schmitt, 2019-2023
% this function takes the output from 'tono_analysis_2P_ANOVA_awake.m' and
% calculates FRAs of each neuron and sorts it according to genotypes

clearvars
% meta analysis
red_cell_idx = false;                % true if double labelling, false if only single channel
fit_flag = 1;                        % true if you want to fit FRAs
save_flag = true;
plot_flag = 0;
overwrite_flag = 1;
nr_subfields = 3;
Rsquare_threshold = 0.8;

%% filepath
root_path = 'directory';
mouseline_tag = 'FMR1';
load 'Jet_colormap_2P.mat';
all_ANOVA_files = dir([root_path,'\**\Tono_analysis_ANOVA.mat']);

%% sort for WT and KO
[WT_ANOVA_files, KO_ANOVA_files] = sort_WT_KO_files(all_ANOVA_files, mouseline_tag);

%% FRA analysis
for genotype = 1:2
    
    if genotype == 1
        cur_mouseline_filepaths = WT_ANOVA_files;
        genotype_char = 'WT';
    else
        cur_mouseline_filepaths = KO_ANOVA_files;
        genotype_char = 'KO';
    end
    % fitting and analysis for each FOV
    fprintf('processing file %3d of %3d', 1, size(cur_mouseline_filepaths,1))
    for ii = 1:size(cur_mouseline_filepaths,1)
        fprintf('\b\b\b\b\b\b\b\b\b\b%3d of %3d', ii, size(cur_mouseline_filepaths,1))
        cur_path = fullfile(cur_mouseline_filepaths(ii).folder, cur_mouseline_filepaths(ii).name);
        frequency_response_area(cur_path,fit_flag,overwrite_flag);
    end
    fprintf('\n')
    disp('fitting done, combining data...');
    mkdir(fullfile(root_path,'TonoAnalysisOverview'));
    if fit_flag
        all_files_FRAanalysis = dir([root_path, '\**\*FRA_analysis_fitted_all.mat']);
    else
        all_files_FRAanalysis = dir([root_path, '\**\*FRA_analysis_all.mat']);
    end
    [WT_FRA_files, KO_FRA_files] = sort_WT_KO_files(all_files_FRAanalysis, mouseline_tag);

    if genotype == 1
        save_filename = ['FRA_analysis_grouped_ANOVA_WT_',mouseline_tag,'_',num2str(Rsquare_threshold),'.mat'];
        cur_mouseline_filepaths = WT_FRA_files;
    else
        save_filename = ['FRA_analysis_grouped_ANOVA_KO_',mouseline_tag,'_',num2str(Rsquare_threshold),'.mat'];
        cur_mouseline_filepaths = KO_FRA_files;
    end
    save_file = fullfile(root_path,'TonoAnalysisOverview', save_filename);

    %% combine data
    FRA_analysis_combine_awake(cur_mouseline_filepaths, save_file, Rsquare_threshold);
    disp('combining done, starting subfield specific analysis');
    
    % do subfield specific analysis
    FRA_analysis_subfields(save_file, genotype_char);
    disp('FRA analysis finished.')

end

disp('SPL finished.')
disp('done.')


function [WT_files, KO_files] = sort_WT_KO_files(all_files, genotype_tag)

switch genotype_tag 
    case 'FMR1'
        KO_legend = {...
            "name_WT_animal", 0;...
            "name_KO_animal", 1;...
            };
end

KO_files = cell(1);
WT_files = cell(1);

for ii = 1:size(KO_legend)    
    idx = find(contains({all_files.folder}, KO_legend{ii,1}));
    if KO_legend{ii,2}
         temp_files = all_files(idx);
         KO_files{1,1}(end+1:end+size(temp_files,1),1) = temp_files; 
    else
         temp_files_WT = all_files(idx);
         WT_files{1,1}(end+1:end+size(temp_files_WT,1),1) = temp_files_WT;  
    end
end
KO_files = KO_files{1,1};
WT_files = WT_files{1,1};

end