% Author: Jan Hirtz - 2023 

% based on concepts published in Beathellier et al. (2012): Discrete Neocortical Dynamics Predict Behavioral Categorization of Sounds. Neuron 76: 435–449 

% allows for multiple sound cartegories to be stacked for analysis
% performs analysis of two experimental days to allow for comparison,
% between the two, limits to cells active/present on both days, no
% actual clustering but correlation of the neurons between the days 
% excluded reps with animal running 


    
clearvars
   
        day_to_be_used = 1;
        day_to_relate = 2;
  
SW_format = 1; %put 0 in case of older formats which don't have the info about days and such
root_path = 'fill_in';
stims_to_be_used = {'fill_in'}; 
stimulation_identifier = {'fill_in'}; %something that is only used on the days that should be included in analysis


stimulation_list_subset = [1,2,4,5,6,7,8,9,10,12]; % for consecutive animal, newer data


min_rep_number = 5;
all_files = dir([root_path, '\**\complete_data_Fall.mat']);
options.Rscriptpath = 'fill_in';
options.Rexchangepath = 'fill_in';

options.Rpath = '';
options.stim_time_elongation = 0; % time in s, elongation of window in case full stim time is analyzed
options.Editabsolutetime = 0.4; %time in s, window for on response from start of stim
options.Editabsolutetime_off = 0.3; % time in s, window for off response from end of stim
options.min_time_window = 2; % 1 is full sound length plut elongation, 2 is limited, 3 is off response
options.max_time_window = 2;
options.manual_framerate = 0; %only used if framerate is not in param_table, put 0 if you want to use table 
options.minimal_neuron_number_per_subfield = 10; %also minimal number of specific cell type per subfield
options.min_field_number = 1;
options.max_field_number = 3;
options.max_celltype_number = -1; % put -1 in case all cells are regarded as one type; the step of analyzing all cell together will always be included anyway
options.stimulation_list_subset=stimulation_list_subset;
options.min_rep_number = min_rep_number;
options.SW_format=SW_format;

    if SW_format == 0

        for ii = 1:size(all_files)

            Results ={};

            complete_data_Fall_path = fullfile(all_files(ii).folder, all_files(ii).name);
            path_parts = split(complete_data_Fall_path, '\');
            save_path = fullfile(path_parts{1:end-3},'fill_in'); 
            mkdir(save_path)

            complete_data_Fall_DATA = load(complete_data_Fall_path);


            stim_times_initial = {};
            sounds_used = [];

            for j = 1:size(complete_data_Fall_DATA.param_table,1)
                if  sum(contains(stims_to_be_used,complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}))>=1
                    options.idx = j;

                    if isempty(stim_times_initial)

                        if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_con')
                            stim_times_initial = complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1);
                            sounds_used = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1},complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,2));
                            sounds_used = string(complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,2));
                        elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'voc')
                            stim_times_initial = complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1);
                            sounds_used = num2str(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1});

                        else
                            stim_times_initial = complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1);
                            sounds_used = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1},complete_data_Fall_DATA.param_table.stim_times{j,1}(:,2));
                            sounds_used = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1},num2str(cell2mat(complete_data_Fall_DATA.param_table.stim_times{j,1}(:,2))));
                        end

                    else

                        if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_con')
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1));
                            sounds_used_new = string(complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,2));
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'voc')
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));
                            sounds_used_new = num2str(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1});
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        else
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));
                            sounds_used_new = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1},num2str(cell2mat(complete_data_Fall_DATA.param_table.stim_times{j,1}(:,2))));
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        end
                    end


                end
            end


            options.stim_times_initial = stim_times_initial;
            options.sounds_used = sounds_used;

            if length(stims_to_be_used) == 1
                Results.(complete_data_Fall_DATA.param_table.Properties.RowNames{options.idx,1}) = Cluster_Correlations(complete_data_Fall_DATA, options);
            elseif length(stims_to_be_used) > 1
                Results.(strjoin(stims_to_be_used,'_')) = Cluster_Correlations(complete_data_Fall_DATA, options);
            end

           
            save([save_path, '\filename_you_want.mat'], 'Results')
        end

    elseif SW_format == 1

        for ii = 1:size(all_files)

            Results ={};

            complete_data_Fall_path = fullfile(all_files(ii).folder, all_files(ii).name);
            path_parts = split(complete_data_Fall_path, '\');
            save_path = fullfile(path_parts{1:end-3},'filename_you_want');
            mkdir(save_path)

            complete_data_Fall_DATA = load(complete_data_Fall_path);

            stim_days = [];
            day_counter = 1;

            for j = 1:size(complete_data_Fall_DATA.param_table,1)
                if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, stimulation_identifier)
                    stim_days{day_counter} =  complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([end-7]:end);
                    day_counter = day_counter+1;
                end
            end
            stim_days = unique(stim_days);
            
            if length(stim_days)> 1
            
            day = stim_days(day_to_be_used);
            day_ref = stim_days(day_to_relate);
            stim_times_initial = {};
            stim_times_initial_ref = {};
            sounds_used = [];

            for j = 1:size(complete_data_Fall_DATA.param_table,1)
                if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, day) && sum(contains(stims_to_be_used,complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-9])))>=1
                    options.idx = j;

                    if isempty(stim_times_initial)

                        if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'consecutive_animal')
                            stim_times_initial = complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1);
                            sounds_used = string(complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,2));
                        elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix_stimulation') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'vocalization')
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));
                            sounds_used = num2str(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-9]));

                        else
                            stim_times_initial = complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1);
                            sounds_used = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-8]),num2str(cell2mat(complete_data_Fall_DATA.param_table.stim_times{j,1}(:,2))));
                        end
                    else

                        if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'consecutive_animal')
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1));
                            sounds_used_new = string(complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,2));
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix_stimulation') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'vocalization')
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));
                            sounds_used_new = num2str(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-9]));
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        else
                            stim_times_initial = vertcat(stim_times_initial,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));
                            sounds_used_new = strcat(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-8]),num2str(cell2mat(complete_data_Fall_DATA.param_table.stim_times{j,1}(:,2))));
                            sounds_used = vertcat(sounds_used,sounds_used_new);
                        end
                    end
                end

                if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, day_ref) && sum(contains(stims_to_be_used,complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-9])))>=1

                    if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, day_ref) && sum(contains(stims_to_be_used,complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}([1:end-9])))>=1
                        %options.idx = j;

                        if isempty(stim_times_initial_ref)

                            if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'consecutive_animal')
                                stim_times_initial_ref = complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1);

                            elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix_stimulation') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'vocalization')
                                stim_times_initial_ref = vertcat(stim_times_initial_ref,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));


                            else
                                stim_times_initial_ref = complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1);

                            end
                        else

                            if contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'consecutive_animal')
                                stim_times_initial_ref = vertcat(stim_times_initial_ref,complete_data_Fall_DATA.param_table.stim_times{j,1}(stimulation_list_subset,1));

                            elseif contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'animal_mix_stimulation') || contains(complete_data_Fall_DATA.param_table.Properties.RowNames{j,1}, 'vocalization')
                                stim_times_initial_ref = vertcat(stim_times_initial_ref,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));

                            else
                                stim_times_initial_ref = vertcat(stim_times_initial_ref,complete_data_Fall_DATA.param_table.stim_times{j,1}(:,1));

                            end
                        end
                    end
                end
            end
            options.stim_times_initial = stim_times_initial;
            options.stim_times_initial_ref = stim_times_initial_ref;
            options.sounds_used = sounds_used;


            if length(stims_to_be_used) == 1
                Results.(complete_data_Fall_DATA.param_table.Properties.RowNames{options.idx,1}) = Cluster_Correlations(complete_data_Fall_DATA, options);
            elseif length(stims_to_be_used) > 1
                Results.((strcat(strjoin(stims_to_be_used,'_'),complete_data_Fall_DATA.param_table.Properties.RowNames{options.idx,1}([end-8 : end])))) = Cluster_Correlations(complete_data_Fall_DATA, options);
            end
            save([save_path,'\filename_you_want.mat'], 'Results')
            end
        end
    end


function time_windows = Cluster_Correlations (DATA, options)

% to include automatic saving, search for "Results" at the very end of the function, and safe that structure

%DATA is a structure containing all elements of an f_all dataset

%% make sure the following settings are correct for your dataset

stim_times_initial = options.stim_times_initial; % "stim_times" will change later, so we call it "initial" here to call back to it if needed
stim_times_initial_ref = options.stim_times_initial_ref;
% in a lot of datatets we don't need daily_logical, so we create it if we
% don't have it

if isfield(DATA,'daily_logical') == 0
    DATA.daily_logical = ones(size(DATA.spk_traces,1),size(DATA.spk_traces,2));
end

% same for running_trace_logical_matrix

if isfield(DATA,'running_trace_logical_matrix') == 0
    DATA.running_trace_logical_matrix = ones(1,size(DATA.spk_traces,2));
end


if options.manual_framerate == 0
    framerate = DATA.param_table.fs{options.idx,1};
else
    framerate = options.manual_framerate;
end

% if size(DATA.param_table.stim_times{options.idx,1},2) < 2
%     Sounds_used = DATA.param_table.Properties.RowNames{options.idx,1};
% else
Sounds_used = options.sounds_used; %these are the names of the stims analyzed, should be same as above
%end
stim_time_elongation = options.stim_time_elongation;
Editabsolutetime = options.Editabsolutetime;
Editabsolutetime_off = options.Editabsolutetime_off;

CelltypeColumn = 4;
min_time_window = options.min_time_window;
max_time_window = options.max_time_window;
max_celltype_number = options.max_celltype_number; % put -1 in case all cells are regarded as one type; the step of analyzing all cell together will always be included anyway
min_field_number = options.min_field_number;
max_field_number = options.max_field_number; % put in 0 if you don't discriminate between subfields

minimal_neuron_number_per_subfield = options.minimal_neuron_number_per_subfield;

Rexchangepath = options.Rexchangepath;
Rpath = options.Rpath;
Rscriptpath = options.Rscriptpath;



%% first hierachical level is time window, three types, first is complete time of stim plus stim_time_elongation, second is absolute time from start of stim,
% third is absolute off time from end of stim (off response)

for time_window_type = min_time_window:max_time_window
    
    if time_window_type == 1
        
        Absoluteanalysistimes = 0;
        Offresponse = 0;
        time_window_name = 'Complete_on_response';
        
    elseif time_window_type == 2
        
        Absoluteanalysistimes = 1;
        Offresponse = 0;
        time_window_name = 'Limited_on_response';
        
    else
        Absoluteanalysistimes = 1;
        Offresponse = 1;
        time_window_name = 'Off_response';
        
    end
    
    % next hierachical level is the cell type, -1 being all cell types
    % together
    
    for Celltype = -1:max_celltype_number
        
        
        if Celltype == -1
            celltype_name = 'All_celltypes';
        else
            celltype_name = (['Celltype',num2str(Celltype)]);
        end
        
        % after that we go to subfields
        
        for field_counter = min_field_number:max_field_number
            
            
            
            % orders data in listbox hierachical, does not identify clusters yet, activity based on spk.traces (deconvolution from Suite2P)
            
            
            % first check if selected subfield is in data and whether
            % enough neurons belong to the subfield and are not false cells
            
            if Celltype == -1 % in case celltype does not matter
                if isfield(DATA,'list_subfields') == 1
                    check_cell_counter = 0;
                    for ccc = 1:size(DATA.list_subfields,1)
                        if DATA.list_subfields(ccc,5) == field_counter && DATA.daily_logical(ccc,round(stim_times_initial{1,1}(1,1))) == 1 && DATA.daily_logical(ccc,round(stim_times_initial_ref{1,1}(1,1))) == 1
                            check_cell_counter = check_cell_counter +1;
                        end
                    end
                    
                    if check_cell_counter >= minimal_neuron_number_per_subfield
                        check_list=DATA.list_subfields(:,5);
                    else
                        check_list=0;
                        
                        if field_counter  == 0
                            check_cell_counter = size(DATA.list_subfields,1); % to have run anyway in case Field is all subfields together;
                        end
                    end
                else
                    check_list=0;
                    if field_counter  == 0
                        check_cell_counter = size(DATA.list_subfields,1); % to have run anyway in case Field is all subfields together;
                    end
                end
                
            else %cell type has to be considered for minimal number as well
                if isfield(DATA,'list_subfields') == 1
                    
                    if field_counter == 0
                        
                        check_cell_counter = 0;
                        for ccc = 1:size(DATA.list_subfields,1)
                            if DATA.list_subfields(ccc,CelltypeColumn) == Celltype && DATA.daily_logical(ccc,round(stim_times_initial{1,1}(1,1))) == 1 && DATA.daily_logical(ccc,round(stim_times_initial_ref{1,1}(1,1))) == 1
                                check_cell_counter = check_cell_counter +1;
                            end
                        end
                        
                    else
                        check_cell_counter = 0;
                        for ccc = 1:size(DATA.list_subfields,1)
                            if DATA.list_subfields(ccc,CelltypeColumn) == Celltype && DATA.list_subfields(ccc,5) == field_counter && DATA.daily_logical(ccc,round(stim_times_initial{1,1}(1,1))) == 1 && DATA.daily_logical(ccc,round(stim_times_initial_ref{1,1}(1,1))) == 1
                                check_cell_counter = check_cell_counter +1;
                            end
                        end
                    end
                    if check_cell_counter >= minimal_neuron_number_per_subfield && field_counter ~= 0
                        check_list=DATA.list_subfields(:,5);
                    else
                        check_list=0;
                    end
                    
                else %only check for minimal cell type number
                    check_cell_counter = 0;
                    for ccc = 1:size(DATA.list,1)
                        if DATA.list(ccc,CelltypeColumn) == Celltype && DATA.daily_logical(ccc,round(stim_times_initial{1,1}(1,1))) == 1 && DATA.daily_logical(ccc,round(stim_times_initial_ref{1,1}(1,1))) == 1
                            check_cell_counter = check_cell_counter +1;
                        end
                    end
                    
                    
                    
                    
                    check_list=0;
                    
                end
            end
            
            
            
            if ismember(field_counter, check_list) == 1 && check_cell_counter >= minimal_neuron_number_per_subfield
                
                
                %loading data and settings
                correlation_matrix = [];
                
                sound_big_matrix = [];

                common_sound_data = [];
                list = [];
                traces = [];
                
                stim_times = stim_times_initial;
                stim_times_ref = stim_times_initial_ref;
                
                subfield_name = (['Field',num2str(field_counter)]); % to specifiy the subfield it should be saved in
                
                Cluster_analysis.(celltype_name).(subfield_name) = []; % to overwrite a former calculation, this property is used later to store results
                
                
                if Absoluteanalysistimes ==1
                    %make all stim times absolute equal length
                    
                    
                    if Offresponse ==1 %in case of off response analysis
                        for iiii=1:length(stim_times)
                            stim_times{iiii,1}(1,:) = stim_times{iiii,1}(2,:);
                            stim_times{iiii,1}(2,:) = stim_times{iiii,1}(2,:)+(Editabsolutetime_off*framerate);
                        end
                        
                        for iiii=1:length(stim_times_ref)
                            stim_times_ref{iiii,1}(1,:) = stim_times_ref{iiii,1}(2,:);
                            stim_times_ref{iiii,1}(2,:) = stim_times_ref{iiii,1}(2,:)+(Editabsolutetime_off*framerate);
                        end
                        
                    else % in case of on response analysis
                        for iiii=1:length(stim_times)
                            stim_times{iiii,1}(2,:) = stim_times{iiii,1}(1,:)+(Editabsolutetime*framerate);
                        end
                        
                        for iiii=1:length(stim_times_ref)
                            stim_times_ref{iiii,1}(2,:) = stim_times_ref{iiii,1}(1,:)+(Editabsolutetime*framerate);
                        end
                    end
                    
                else
                    % calculates elongation of analyses time window beyond stimulation time
                    for ii=1:length(stim_times)
                        stim_times{ii,1}(2,:) = stim_times{ii,1}(2,:)+(stim_time_elongation*framerate);
                    end
                    
                    for ii=1:length(stim_times_ref)
                        stim_times_ref{ii,1}(2,:) = stim_times_ref{ii,1}(2,:)+(stim_time_elongation*framerate);
                    end
                    
                end
                
                % limit cells according to subfield and cell type
                
                if field_counter == 0 % that means all cells are selected, regardless of subfield
                    
                    % now we select the traces that belong to the subfield
                    % and celltype, and check that they are not false
                    % we do that for data that have the 'list_subfield'
                    % file, and those that do not
                    
                    if isfield(DATA,'list_subfields') == 1
                        
                        
                        if Celltype ~= -1
                            
                            list_counter = 1;
                            for oo = 1:size(DATA.list_subfields,1)
                                if DATA.list_subfields(oo,CelltypeColumn) == Celltype && DATA.daily_logical(oo,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(oo,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list_subfields(oo,:);
                                    traces(list_counter,:) = DATA.spk_traces(oo,:);
                                    list_counter = list_counter +1;
                                end
                            end
                            
                            
                            
                        else
                            list_counter = 1;
                            for oo = 1:size(DATA.list_subfields,1)
                                if DATA.daily_logical(oo,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(oo,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list_subfields(oo,:);
                                    traces(list_counter,:) = DATA.spk_traces(oo,:);
                                    list_counter = list_counter +1;
                                end
                            end
                        end
                        
                    else
                        
                        if Celltype ~= -1
                            
                            list_counter = 1;
                            for oo = 1:size(DATA.list,1)
                                if DATA.list(oo,CelltypeColumn) == Celltype && DATA.daily_logical(oo,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(oo,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list(oo,:);
                                    traces(list_counter,:) = DATA.spk_traces(oo,:);
                                    list_counter = list_counter +1;
                                end
                            end
                            
                            
                        else
                            list_counter = 1;
                            for oo = 1:size(DATA.list,1)
                                if DATA.daily_logical(oo,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(oo,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list(oo,:);
                                    traces(list_counter,:) = DATA.spk_traces(oo,:);
                                    list_counter = list_counter +1;
                                end
                            end
                        end
                    end
                    
                else
                    
                    if isfield(DATA,'list_subfields') == 1
                        
                        
                        if Celltype ~= -1
                            
                            list_counter = 1;
                            for nnn = 1:size(DATA.list_subfields,1)
                                if DATA.list_subfields(nnn,CelltypeColumn) == Celltype && DATA.list_subfields(nnn,5) == field_counter && DATA.daily_logical(nnn,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(nnn,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list_subfields(nnn,:);
                                    traces(list_counter,:) = DATA.spk_traces(nnn,:);
                                    list_counter = list_counter +1;
                                end
                            end
                            
                            
                        else
                            list_counter = 1;
                            for nnn = 1:size(DATA.list_subfields,1)
                                if DATA.list_subfields(nnn,5) == field_counter && DATA.daily_logical(nnn,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(nnn,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:) =  DATA.list_subfields(nnn,:);
                                    traces(list_counter,:) = DATA.spk_traces(nnn,:);
                                    list_counter = list_counter +1;
                                end
                            end
                        end
                        
                    else
                        if Celltype ~= -1
                            
                            list_counter = 1;
                            for nnn = 1:size(DATA.list,1)
                                if DATA.list(nnn,CelltypeColumn) == Celltype && DATA.list(nnn,5) == field_counter && DATA.daily_logical(nnn,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(nnn,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:)= DATA.list(nnn,:);
                                    traces(list_counter,:) = DATA.spk_traces(nnn,:);
                                    list_counter = list_counter +1;
                                end
                            end
                        else
                            list_counter = 1;
                            for nnn = 1:size(DATA.list,1)
                                if DATA.list(nnn,5) == field_counter && DATA.daily_logical(nnn,round(stim_times{1,1}(1,1))) == 1 && DATA.daily_logical(nnn,round(stim_times_ref{1,1}(1,1))) == 1
                                    list(list_counter,:) =  DATA.list(nnn,:);
                                    traces(list_counter,:) = DATA.spk_traces(nnn,:);
                                    list_counter = list_counter +1;
                                end
                            end
                        end
                    end
                end
                
                
                number_of_sounds = length(stim_times);
                number_of_reps = size(stim_times{1},2);
                number_of_cells = size(traces,1);
                
                % now of if there is running time in repetition
                run_matrix = []; % sounds x repetiotions, if 0 then running
                for n=1:number_of_sounds
                    times_of_sounds = stim_times{n};
                    for m = 1:number_of_reps
                        
                        start_frame = round(times_of_sounds(1,m));
                        end_frame = round(times_of_sounds(2,m));
                        
                        
                        
                        if   sum(DATA.running_trace_logical_matrix(start_frame:end_frame)) < length([start_frame:end_frame])
                            run_matrix(n,m) = 0;
                        else
                            run_matrix(n,m) = 1;
                        end
                    end
                    
                end
                
                
                run_matrix_ref = []; % sounds x repetiotions, if 0 then running
                for n=1:number_of_sounds
                    times_of_sounds = stim_times_ref{n};
                    for m = 1:number_of_reps
                        
                        start_frame = round(times_of_sounds(1,m));
                        end_frame = round(times_of_sounds(2,m));
                        
                        
                        
                        if   sum(DATA.running_trace_logical_matrix(start_frame:end_frame)) < length([start_frame:end_frame])
                            run_matrix_ref(n,m) = 0;
                        else
                            run_matrix_ref(n,m) = 1;
                        end
                    end
                    
                end
             
                
                %now check if any sounds does not have enough reps without
                %running, in that case terminate the current analysis
                
                actual_number_of_reps = min(sum(run_matrix,2));
                actual_number_of_reps_ref = min(sum(run_matrix_ref,2));
                
                actual_number_of_reps = min(actual_number_of_reps,actual_number_of_reps_ref);
                
                if actual_number_of_reps < options.min_rep_number 
                    Cluster_analysis.(celltype_name).(subfield_name) = [];
                    continue
                    
                else % else we now delete stim times accordingly, every repetition with running
                    
                    for kk = number_of_reps:-1:1
                        for u = 1:number_of_sounds
                            
                            if  run_matrix(u,kk) == 0
                                
                                
                                stim_times{u}(:,kk) = [];
                                
                            end
                        end
                        
                    end
                    
                    for kk = number_of_reps:-1:1
                        for u = 1:number_of_sounds
                            
                            if  run_matrix_ref(u,kk) == 0
                                
                                
                                stim_times_ref{u}(:,kk) = [];
                                
                            end
                        end
                        
                    end
                    
                end
                
               
                
                %create cell array (highest order sounds) with activity of each neuron (mean across analysis time window)
                % for each repetition in a matrix of each field
                
                population_matrix = []; % in case is was defined from an earlier calculation
                population_matrix_ref = []; % in case is was defined from an earlier calculation
                big_matrix = [];
                correlation_matrix_1 = [];
                population_matrix_of_sound = [];
                population_matrix_of_sound_ref = [];
                
                for n=1:number_of_sounds
                    times_of_sounds = stim_times{n};
                    for m = 1:actual_number_of_reps
                        
                        start_frame = round(times_of_sounds(1,m));
                        end_frame = round(times_of_sounds(2,m));
                        
                        for l=1:size(traces,1)
                            
                            population_matrix_of_sound(l,m) = mean(traces(l,start_frame:end_frame));
                        end
                    end
                    population_matrix{n} = population_matrix_of_sound;
                end
                
                for n=1:number_of_sounds
                    times_of_sounds_ref = stim_times_ref{n};
                    for m = 1:actual_number_of_reps
                        
                        start_frame = round(times_of_sounds_ref(1,m));
                        end_frame = round(times_of_sounds_ref(2,m));
                        
                        for l=1:size(traces,1)
                            
                            population_matrix_of_sound_ref(l,m) = mean(traces(l,start_frame:end_frame));
                        end
                    end
                    population_matrix_ref{n} = population_matrix_of_sound_ref;
                end
                
                
                % make big cell array with correlations for each repetition
                for i=1:actual_number_of_reps
                    for v=1:actual_number_of_reps
                        for u = 1: number_of_sounds
                            
                                big_matrix{u}(i,v)= corr(population_matrix{u}(:,i),population_matrix_ref{u}(:,v));
                                if isnan(big_matrix{u}(i,v))== 1
                                    big_matrix{u}(i,v)=0;
                              
                                end
                           
                        end
                    end
                end
                
                
                
                sound_big_matrix = big_matrix;
                
                % average correlations across neurons and reptitions to obtain
                % correlation of sounds
                for t = 1: number_of_sounds
                    
                        correlation_matrix(t) = mean(big_matrix{t},'all');
                        
                    
                end
                
                %average again for overall correlation in the FOV between
                %days
                
                day_correlation = mean(correlation_matrix);
                
               
                % a lot of info about general properties of clusters is
                % stored, can be usefull
                common_sound_data.sound_correlations=correlation_matrix;
                common_sound_data.day_correlation=day_correlation;
         
                
                common_sound_data.sounds_used=Sounds_used;
                common_sound_data.corr_stim_times=stim_times_initial;
                common_sound_data.sound_big_matrix=sound_big_matrix;
                common_sound_data.analysis_times=stim_times;
                common_sound_data.list=list;
                common_sound_data.traces=traces;
                if Celltype ~= -1
                    common_sound_data.Celltype=[str2double(Celltype) str2double(CelltypeColumn)];
                end
                
                
                subfield_name = (['Field',num2str(field_counter)]); % to specifiy the subfield it should be saved in
                
                Cluster_analysis.(celltype_name).(subfield_name).common_data=common_sound_data; % all the general info on clusters
                
            else
                subfield_name = ['Field', num2str(field_counter)];
              
                Cluster_analysis.(celltype_name).(subfield_name) = [];
            end
        end
        
                    
                   
        
        celltypes.(celltype_name).Cluster_analysis = Cluster_analysis.(celltype_name);
        
    end
    
    time_windows.(time_window_name) = celltypes;
    
end



end


