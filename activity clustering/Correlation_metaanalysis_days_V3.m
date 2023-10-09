% To be run after Cluster_analysis_pipeline_over_days code, performs additional
% analyses and statistics

%intended to be used one one group of animals, that is compared between two
%days

% Field 0 is not the combination of all FOVs in different subfields, but in
% case no subfield parcelation was selected

clearvars;


include_animals = {'animal_1','animal_2','...'}; 
 
root_path = 'fill in'; 


all_cluster_files = dir([root_path, '\**\filename_you_used.mat']);

FOV_analyzed.group_1 ={};
FOV_analyzed.group_2 ={};

for ii = 1:size(all_cluster_files)
    
    cur_cluster_file = fullfile(all_cluster_files(ii).folder, all_cluster_files(ii).name);
    path_parts = split(cur_cluster_file, '\');

    
    animal=path_parts{end-4}; 
    day = path_parts{end}(end-7:end-4);
   
if  sum(ismember(include_animals,animal))>0 
    
    if sum(day == 'day1') == 4
    group = 'group_1';
    elseif sum(day == 'day2') == 4    
    group = 'group_2';
    end
    
    check_dir = dir(fullfile(all_cluster_files(ii).folder,'*.mat'));
    
    if size(check_dir,1) == 2 && check_dir(1).bytes > 1000 && check_dir(2).bytes > 1000
    
    Loaded_data = load(cur_cluster_file, 'Results');
    
    temp_stim_names = fieldnames(Loaded_data.Results);
    Loaded_data.Results = Loaded_data.Results.(temp_stim_names{1});
    
    
    
    if isfield (Loaded_data.Results,'Complete_on_response')
        
        if isfield (Loaded_data.Results.Complete_on_response,'All_celltypes')
            
            if isfield(Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Complete_on_response.All_celltypes.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','All_celltypes','Field0');
                end
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Complete_on_response.All_celltypes.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','All_celltypes','Field1');
                end
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Complete_on_response.All_celltypes.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','All_celltypes','Field2');
                end
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Complete_on_response.All_celltypes.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Complete_on_response.All_celltypes.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','All_celltypes','Field3');
                end
            end
        end
        
        
        if isfield (Loaded_data.Results.Complete_on_response,'Celltype0')
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype0.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype0','Field0');
                end
                
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype0.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype0','Field1');
                end
                
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype0.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype0','Field2');
                end
                
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype0.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype0.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype0','Field3');
                end
                
            end
            
        end
        
        
        if isfield (Loaded_data.Results.Complete_on_response,'Celltype1')
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype1.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype1','Field0');
                end
                 
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype1.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype1','Field1');
                end
                 
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype1.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype1','Field2');
                end
                 
            end
            
            if isfield(Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Complete_on_response.Celltype1.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Complete_on_response.Celltype1.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Complete_on_response','Celltype1','Field3');
                end
                 
            end
            
        end
    end
    
    if isfield (Loaded_data.Results,'Limited_on_response')
        
        
        if isfield (Loaded_data.Results.Limited_on_response,'All_celltypes')
            
            if isfield(Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis.Field0) ==0
                    
                    FOV_analyzed.(group).Limited_on_response.All_celltypes.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','All_celltypes','Field0');
    
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis.Field1) ==0
                     FOV_analyzed.(group).Limited_on_response.All_celltypes.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','All_celltypes','Field1');
    
                    
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Limited_on_response.All_celltypes.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','All_celltypes','Field2');
                    
    
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Limited_on_response.All_celltypes.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Limited_on_response.All_celltypes.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','All_celltypes','Field3');
                    
                end
            end
            
        end
        
        
        if isfield (Loaded_data.Results.Limited_on_response,'Celltype0')
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype0.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype0','Field0');
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype0.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype0','Field1');
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype0.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype0','Field2');
                end
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype0.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype0.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype0','Field3');
                end
            end
            
        end
        
        
        if isfield (Loaded_data.Results.Limited_on_response,'Celltype1')
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype1.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype1','Field0');
                end
                
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype1.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype1','Field1');
                end
                
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype1.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype1','Field2');
                end
                
            end
            
            if isfield(Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Limited_on_response.Celltype1.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Limited_on_response.Celltype1.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Limited_on_response','Celltype1','Field3');
                end
                
            end
            
        end
    end
    
    
    
    if isfield (Loaded_data.Results,'Off_response')
        
         if isfield (Loaded_data.Results.Off_response,'All_celltypes')
            
            if isfield(Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Off_response.All_celltypes.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','All_celltypes','Field0');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Off_response.All_celltypes.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','All_celltypes','Field1');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Off_response.All_celltypes.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','All_celltypes','Field2');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Off_response.All_celltypes.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Off_response.All_celltypes.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','All_celltypes','Field3');
                end
            end
            
        end
        
        
        if isfield (Loaded_data.Results.Off_response,'Celltype0')
            
            if isfield(Loaded_data.Results.Off_response.Celltype0.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Off_response.Celltype0.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Off_response.Celltype0.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype0','Field0');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype0.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Off_response.Celltype0.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Off_response.Celltype0.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype0','Field1');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype0.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Off_response.Celltype0.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Off_response.Celltype0.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype0','Field2');
                end
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype0.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Off_response.Celltype0.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Off_response.Celltype0.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype0','Field3');
                end
            end
            
        end
        
        
        if isfield (Loaded_data.Results.Off_response,'Celltype1')
            
            if isfield(Loaded_data.Results.Off_response.Celltype1.Cluster_analysis,'Field0')
                if isempty (Loaded_data.Results.Off_response.Celltype1.Cluster_analysis.Field0) ==0
                    FOV_analyzed.(group).Off_response.Celltype1.Field0 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype1','Field0');
                end
                
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype1.Cluster_analysis,'Field1')
                if isempty (Loaded_data.Results.Off_response.Celltype1.Cluster_analysis.Field1) ==0
                    FOV_analyzed.(group).Off_response.Celltype1.Field1 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype1','Field1');
                end
                
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype1.Cluster_analysis,'Field2')
                if isempty (Loaded_data.Results.Off_response.Celltype1.Cluster_analysis.Field2) ==0
                    FOV_analyzed.(group).Off_response.Celltype1.Field2 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype1','Field2');
                end
                
            end
            
            if isfield(Loaded_data.Results.Off_response.Celltype1.Cluster_analysis,'Field3')
                if isempty (Loaded_data.Results.Off_response.Celltype1.Cluster_analysis.Field3) ==0
                    FOV_analyzed.(group).Off_response.Celltype1.Field3 = Analyse_FOV (FOV_analyzed.(group),Loaded_data,'Off_response','Celltype1','Field3');
                end
                
            end
            
        end
         
    end
    

    end
end
end

if isfield (FOV_analyzed.group_1,'Complete_on_response') && isfield (FOV_analyzed.group_2,'Complete_on_response')
    
    if isfield (FOV_analyzed.group_1.Complete_on_response,'All_celltypes') && isfield(FOV_analyzed.group_2.Complete_on_response,'All_celltypes')
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.All_celltypes,'Field0') && isfield(FOV_analyzed.group_2.Complete_on_response.All_celltypes,'Field0')
            
            FOV_analyzed.stats.Complete_on_response.All_celltypes.Field0 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.All_celltypes.Field0,FOV_analyzed.group_2.Complete_on_response.All_celltypes.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.All_celltypes,'Field1') && isfield(FOV_analyzed.group_2.Complete_on_response.All_celltypes,'Field1')
            
            FOV_analyzed.stats.Complete_on_response.All_celltypes.Field1 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.All_celltypes.Field1,FOV_analyzed.group_2.Complete_on_response.All_celltypes.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.All_celltypes,'Field2') && isfield(FOV_analyzed.group_2.Complete_on_response.All_celltypes,'Field2')
            
            FOV_analyzed.stats.Complete_on_response.All_celltypes.Field2 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.All_celltypes.Field2,FOV_analyzed.group_2.Complete_on_response.All_celltypes.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.All_celltypes,'Field3') && isfield(FOV_analyzed.group_2.Complete_on_response.All_celltypes,'Field3')
            
            FOV_analyzed.stats.Complete_on_response.All_celltypes.Field3 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.All_celltypes.Field3,FOV_analyzed.group_2.Complete_on_response.All_celltypes.Field3);
            
        end
    end
    
    if isfield (FOV_analyzed.group_1.Complete_on_response,'Celltype1') && isfield (FOV_analyzed.group_2.Complete_on_response,'Celltype1')
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype1,'Field0') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype1,'Field0')
            
            FOV_analyzed.stats.Complete_on_response.Celltype1.Field0 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype1.Field0,FOV_analyzed.group_2.Complete_on_response.Celltype1.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype1,'Field1') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype1,'Field1')
            
            FOV_analyzed.stats.Complete_on_response.Celltype1.Field1 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype1.Field1,FOV_analyzed.group_2.Complete_on_response.Celltype1.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype1,'Field2') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype1,'Field2')
            
            FOV_analyzed.stats.Complete_on_response.Celltype1.Field2 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype1.Field2,FOV_analyzed.group_2.Complete_on_response.Celltype1.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype1,'Field3') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype1,'Field3')
            
            FOV_analyzed.stats.Complete_on_response.Celltype1.Field3 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype1.Field3,FOV_analyzed.group_2.Complete_on_response.Celltype1.Field3);
            
        end
    end
    
    
    if isfield (FOV_analyzed.group_1.Complete_on_response,'Celltype0') && isfield(FOV_analyzed.group_2.Complete_on_response,'Celltype0')
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype0,'Field0') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype0,'Field0')
            
            FOV_analyzed.stats.Complete_on_response.Celltype0.Field0 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype0.Field0,FOV_analyzed.group_2.Complete_on_response.Celltype0.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype0,'Field1') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype0,'Field1')
            
            FOV_analyzed.stats.Complete_on_response.Celltype0.Field1 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype0.Field1,FOV_analyzed.group_2.Complete_on_response.Celltype0.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype0,'Field2') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype0,'Field2')
            
            FOV_analyzed.stats.Complete_on_response.Celltype0.Field2 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype0.Field2,FOV_analyzed.group_2.Complete_on_response.Celltype0.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Complete_on_response.Celltype0,'Field3') && isfield(FOV_analyzed.group_2.Complete_on_response.Celltype0,'Field3')
            
            FOV_analyzed.stats.Complete_on_response.Celltype0.Field3 = subfield_stats(FOV_analyzed.group_1.Complete_on_response.Celltype0.Field3,FOV_analyzed.group_2.Complete_on_response.Celltype0.Field3);
            
        end
        
    end
end

if isfield (FOV_analyzed.group_1,'Limited_on_response') && isfield (FOV_analyzed.group_2,'Limited_on_response')
    
    if isfield (FOV_analyzed.group_1.Limited_on_response,'All_celltypes') && isfield(FOV_analyzed.group_2.Limited_on_response,'All_celltypes')
        
        if isfield(FOV_analyzed.group_1.Limited_on_response.All_celltypes,'Field0') && isfield(FOV_analyzed.group_2.Limited_on_response.All_celltypes,'Field0')
            
            FOV_analyzed.stats.Limited_on_response.All_celltypes.Field0 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.All_celltypes.Field0,FOV_analyzed.group_2.Limited_on_response.All_celltypes.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Limited_on_response.All_celltypes,'Field1') && isfield(FOV_analyzed.group_2.Limited_on_response.All_celltypes,'Field1') 
           
            FOV_analyzed.stats.Limited_on_response.All_celltypes.Field1 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.All_celltypes.Field1,FOV_analyzed.group_2.Limited_on_response.All_celltypes.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Limited_on_response.All_celltypes,'Field2') && isfield(FOV_analyzed.group_2.Limited_on_response.All_celltypes,'Field2')
            
            FOV_analyzed.stats.Limited_on_response.All_celltypes.Field2 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.All_celltypes.Field2,FOV_analyzed.group_2.Limited_on_response.All_celltypes.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Limited_on_response.All_celltypes,'Field3') && isfield(FOV_analyzed.group_2.Limited_on_response.All_celltypes,'Field3')
            
            FOV_analyzed.stats.Limited_on_response.All_celltypes.Field3 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.All_celltypes.Field3,FOV_analyzed.group_2.Limited_on_response.All_celltypes.Field3);
            
        end
    end
        
        if isfield (FOV_analyzed.group_1.Limited_on_response,'Celltype0')
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype0,'Field0')
                
                FOV_analyzed.stats.Limited_on_response.Celltype0.Field0 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype0.Field0,FOV_analyzed.group_2.Limited_on_response.Celltype0.Field0);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype0,'Field1')
                
                FOV_analyzed.stats.Limited_on_response.Celltype0.Field1 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype0.Field1,FOV_analyzed.group_2.Limited_on_response.Celltype0.Field1);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype0,'Field2')
                
                FOV_analyzed.stats.Limited_on_response.Celltype0.Field2 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype0.Field2,FOV_analyzed.group_2.Limited_on_response.Celltype0.Field2);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype0,'Field3')
                
                FOV_analyzed.stats.Limited_on_response.Celltype0.Field3 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype0.Field3,FOV_analyzed.group_2.Limited_on_response.Celltype0.Field3);
                
            end
        end
        
        if isfield (FOV_analyzed.group_1.Limited_on_response,'Celltype1')
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype1,'Field0')
                
                FOV_analyzed.stats.Limited_on_response.Celltype1.Field0 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype1.Field0,FOV_analyzed.group_2.Limited_on_response.Celltype1.Field0);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype1,'Field1')
                
                FOV_analyzed.stats.Limited_on_response.Celltype1.Field1 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype1.Field1,FOV_analyzed.group_2.Limited_on_response.Celltype1.Field1);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype1,'Field2')
                
                FOV_analyzed.stats.Limited_on_response.Celltype1.Field2 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype1.Field2,FOV_analyzed.group_2.Limited_on_response.Celltype1.Field2);
                
            end
            
            if isfield(FOV_analyzed.group_1.Limited_on_response.Celltype1,'Field3')
                
                FOV_analyzed.stats.Limited_on_response.Celltype1.Field3 = subfield_stats(FOV_analyzed.group_1.Limited_on_response.Celltype1.Field3,FOV_analyzed.group_2.Limited_on_response.Celltype1.Field3);
                
            end
        end
    end


if isfield (FOV_analyzed.group_1,'Off_response') && isfield (FOV_analyzed.group_2,'Off_response')
    
    if isfield (FOV_analyzed.group_1.Off_response,'Celltype0')
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype0,'Field0')
            
            FOV_analyzed.stats.Off_response.Celltype0.Field0 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype0.Field0,FOV_analyzed.group_2.Off_response.Celltype0.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype0,'Field1')
            
            FOV_analyzed.stats.Off_response.Celltype0.Field1 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype0.Field1,FOV_analyzed.group_2.Off_response.Celltype0.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype0,'Field2')
            
            FOV_analyzed.stats.Off_response.Celltype0.Field2 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype0.Field2,FOV_analyzed.group_2.Off_response.Celltype0.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype0,'Field3')
            
            FOV_analyzed.stats.Off_response.Celltype0.Field3 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype0.Field3,FOV_analyzed.group_2.Off_response.Celltype0.Field3);
            
        end
    end
    
    if isfield (FOV_analyzed.group_1.Off_response,'Celltype1')
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype1,'Field0')
            
            FOV_analyzed.stats.Off_response.Celltype1.Field0 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype1.Field0,FOV_analyzed.group_2.Off_response.Celltype1.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype1,'Field1')
            
            FOV_analyzed.stats.Off_response.Celltype1.Field1 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype1.Field1,FOV_analyzed.group_2.Off_response.Celltype1.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype1,'Field2')
            
            FOV_analyzed.stats.Off_response.Celltype1.Field2 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype1.Field2,FOV_analyzed.group_2.Off_response.Celltype1.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.Celltype1,'Field3')
            
            FOV_analyzed.stats.Off_response.Celltype1.Field3 = subfield_stats(FOV_analyzed.group_1.Off_response.Celltype1.Field3,FOV_analyzed.group_2.Off_response.Celltype1.Field3);
            
        end
    end
    
    if isfield (FOV_analyzed.group_1.Off_response,'All_celltypes')
        
        if isfield(FOV_analyzed.group_1.Off_response.All_celltypes,'Field0')
            
            FOV_analyzed.stats.Off_response.All_celltypes.Field0 = subfield_stats(FOV_analyzed.group_1.Off_response.All_celltypes.Field0,FOV_analyzed.group_2.Off_response.All_celltypes.Field0);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.All_celltypes,'Field1')
            
            FOV_analyzed.stats.Off_response.All_celltypes.Field1 = subfield_stats(FOV_analyzed.group_1.Off_response.All_celltypes.Field1,FOV_analyzed.group_2.Off_response.All_celltypes.Field1);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.All_celltypes,'Field2')
            
            FOV_analyzed.stats.Off_response.All_celltypes.Field2 = subfield_stats(FOV_analyzed.group_1.Off_response.All_celltypes.Field2,FOV_analyzed.group_2.Off_response.All_celltypes.Field2);
            
        end
        
        if isfield(FOV_analyzed.group_1.Off_response.All_celltypes,'Field3')
            
            FOV_analyzed.stats.Off_response.All_celltypes.Field3 = subfield_stats(FOV_analyzed.group_1.Off_response.All_celltypes.Field3,FOV_analyzed.group_2.Off_response.All_celltypes.Field3);
            
        end
        
    end
end




assignin('base','FOV_analyzed',FOV_analyzed);


function metadata = Analyse_FOV(old_metadata,Loaded_data,analysis_window,Celltypes,Field)

prior_FOV = 0;

if isfield(old_metadata,(analysis_window))
    if isfield(old_metadata.(analysis_window),(Celltypes))
        if isfield(old_metadata.(analysis_window).(Celltypes),(Field))
            
            prior_FOV = 1;
        end
    end
end

if prior_FOV == 0
    
    metadata.overall_sound_correlations = mean(nonzeros(triu(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations,1)));  
    metadata.overall_sound_reliabilities = mean(diag(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations,1));  
    
    
    metadata.neurons_per_FOV = size(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.list,1);
    metadata.fraction_of_clustered_sounds = length(nonzeros(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator))/length(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator);

    metadata.number_of_sound_clusters  = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.number_of_sound_clusters ;
   
    
    
    Sound_clusters = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters;
    sound_correlation_matrix = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations;
    outperm_sounds = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.outperm_sounds;
    Cluster_indicator = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator;
  
    
    
    for i = 1:length(sound_correlation_matrix)
                        
         for ii = 1:length(sound_correlation_matrix)
                            
             ordered_sound_correlation_matrix(i,ii) = sound_correlation_matrix(outperm_sounds(i),outperm_sounds(ii));
                            
         end
    end
     
    
    
    
    outside_sound_cluster_correlation = {};
    cluster_numbers = unique(nonzeros(Cluster_indicator));
    
    for e = 1: length(cluster_numbers)
        corr_sound_counter = 1;
        
    for j = 1:length(ordered_sound_correlation_matrix)
        for k = 1:length(ordered_sound_correlation_matrix)
            
            if Cluster_indicator(j) == cluster_numbers(e) && Cluster_indicator(k) ~= cluster_numbers(e) && Cluster_indicator(k) ~= 0
                outside_sound_cluster_correlation{e}(corr_sound_counter) = ordered_sound_correlation_matrix(j,k);
                corr_sound_counter = corr_sound_counter+1;
                
            end
            
        end
    end
    if isempty (outside_sound_cluster_correlation) == 0
    metadata.outside_sound_cluster_correlation(e) = mean(outside_sound_cluster_correlation{e});
    end
    end
    
    

    
    
    for n = 1:length(Sound_clusters)
        
        Sounds_in_Clusters{n} = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster;
        metadata.Sound_clusters_mean_correlation(n) = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.mean_correlation;
        metadata.Sound_clusters_mean_reliability(n) = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.mean_reliability;
        metadata.Cluster_dominance{n} = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.Cluster_dominance;
        metadata.sounds_per_cluster(n) = length(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster);
        
        
                        PT_counter = 0;
                        AM_20Hz_counter = 0;
                        AM_40Hz_counter = 0;
                        animal_sound_counter = 0;
                        %vocalization_counter = 0;
                        
                        
                            
                            for m = 1:metadata.sounds_per_cluster(n)
                                if contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'PT_70dB')
                                    PT_counter = PT_counter +1;
                                elseif contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'AM_20Hz')
                                    AM_20Hz_counter = AM_20Hz_counter +1;
                                elseif contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'AM_40Hz')
                                    AM_40Hz_counter = AM_40Hz_counter +1;
                             
                                else
                                    animal_sound_counter = animal_sound_counter +1;
                                end
                                

                            end
                            
                            metadata.max_cluster_dominance(n) = (max(horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter)))/metadata.sounds_per_cluster(n);
                            sound_index = find((horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter)) == (max(horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter))));
                            
                            if sound_index  == 1
                            metadata.max_cluster_dominance_sound{n} = 'PT';
                            elseif sound_index  == 2
                            metadata.max_cluster_dominance_sound{n} = 'AM_20Hz';
                            elseif sound_index  == 3
                            metadata.max_cluster_dominance_sound{n} = 'AM_40Hz';
                            elseif sound_index  == 4
                            metadata.max_cluster_dominance_sound{n} = 'Animal_sounds';
                            else
                            metadata.max_cluster_dominance_sound{n} = 'tied';   
                            end
                            
                                
                            if PT_counter > metadata.sounds_per_cluster(n)/1.5
                                 metadata.Strong_Cluster_dominance{n} = 'PT';
                            elseif AM_20Hz_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'AM_20Hz';
                            elseif AM_40Hz_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'AM_40Hz';
                            elseif animal_sound_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'Animal_sounds';

                            else
                                metadata.Strong_Cluster_dominance{n} = 'mixed';
                            end
                            

                            
    metadata.sound_clustering_for_similarity{1} = Sounds_in_Clusters;
    end
    
       
        

    
else
    
    metadata.overall_sound_reliabilities = mean(diag(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations,1));
    metadata.overall_sound_correlations = mean(nonzeros(triu(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations,1)));
    metadata.neurons_per_FOV = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).neurons_per_FOV,size(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.list,1));
    
    metadata.fraction_of_clustered_sounds = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).fraction_of_clustered_sounds,length(nonzeros(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator))/length(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator));
    metadata.number_of_sound_clusters  = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).number_of_sound_clusters,Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.number_of_sound_clusters) ;
   
    
    
    
    Sound_clusters = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters;
    sound_correlation_matrix = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.sound_correlations;
    outperm_sounds = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.outperm_sounds;
    Cluster_indicator = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.Cluster_indicator;
  
    
    
    for i = 1:length(sound_correlation_matrix)
                        
         for ii = 1:length(sound_correlation_matrix)
                            
             ordered_sound_correlation_matrix(i,ii) = sound_correlation_matrix(outperm_sounds(i),outperm_sounds(ii));
                            
         end
    end
     
    
    
    outside_sound_cluster_correlation = {};
    cluster_numbers = unique(nonzeros(Cluster_indicator));
    
    for e = 1: length(cluster_numbers)
        corr_sound_counter = 1;
        
    for j = 1:length(ordered_sound_correlation_matrix)
        for k = 1:length(ordered_sound_correlation_matrix)
            
            if Cluster_indicator(j) == cluster_numbers(e) && Cluster_indicator(k) ~= cluster_numbers(e) && Cluster_indicator(k) ~= 0
                outside_sound_cluster_correlation{e}(corr_sound_counter) = ordered_sound_correlation_matrix(j,k);
                corr_sound_counter = corr_sound_counter+1;
                
            end
            
        end
    end
    if isempty(outside_sound_cluster_correlation) == 0
    metadata.outside_sound_cluster_correlation(e) = mean(outside_sound_cluster_correlation{e});
    end
    end
    

    for n = 1:length(Sound_clusters)
        
        Sounds_in_Clusters{n} = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster;
        metadata.Sound_clusters_mean_correlation(n) = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.mean_correlation;
        metadata.Sound_clusters_mean_reliability(n) = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.mean_reliability;
        metadata.Cluster_dominance{n} = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.Cluster_dominance;
        metadata.sounds_per_cluster(n) = length(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster);
        
                        PT_counter = 0;
                        AM_20Hz_counter = 0;
                        AM_40Hz_counter = 0;
                        animal_sound_counter = 0;
                      
                        
                        
                            
                            for m = 1:metadata.sounds_per_cluster(n)
                                if contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'PT_50dB')
                                    PT_counter = PT_counter +1;
                                elseif contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'AM_20Hz')
                                    AM_20Hz_counter = AM_20Hz_counter +1;
                                elseif contains(Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).sound_clusters{n}.sounds_in_cluster{m},'AM_40Hz')
                                    AM_40Hz_counter = AM_40Hz_counter +1;                            
                                else
                                    animal_sound_counter = animal_sound_counter +1;
                                end
                                

                            end
                            
                            metadata.max_cluster_dominance(n) = (max(horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter)))/metadata.sounds_per_cluster(n);
                            sound_index = find(horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter) == max(horzcat(PT_counter,AM_20Hz_counter,AM_40Hz_counter,animal_sound_counter)));
                            
                            if sound_index  == 1
                            metadata.max_cluster_dominance_sound{n} = 'PT';
                            elseif sound_index  == 2
                            metadata.max_cluster_dominance_sound{n} = 'AM_20Hz';
                            elseif sound_index  == 3
                            metadata.max_cluster_dominance_sound{n} = 'AM_40Hz';
                            elseif sound_index  == 4
                            metadata.max_cluster_dominance_sound{n} = 'Animal_sounds';

                            else
                            metadata.max_cluster_dominance_sound{n} = 'tied';    
                            end
                            
                                
                            if PT_counter > metadata.sounds_per_cluster(n)/1.5
                                 metadata.Strong_Cluster_dominance{n} = 'PT';
                            elseif AM_20Hz_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'AM_20Hz';
                            elseif AM_40Hz_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'AM_40Hz';
                            elseif animal_sound_counter > metadata.sounds_per_cluster(n)/1.5
                                metadata.Strong_Cluster_dominance{n} = 'Animal_sounds';

                            else
                                metadata.Strong_Cluster_dominance{n} = 'mixed';
                            end
                            

    metadata.sound_clustering_for_similarity{1} = Sounds_in_Clusters;      
    end
    
    



    if isfield(metadata,'Sound_clusters_mean_correlation') && isfield(old_metadata.(analysis_window).(Celltypes).(Field),'Sound_clusters_mean_correlation')
    
   
    metadata.sound_clustering_for_similarity = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).sound_clustering_for_similarity,metadata.sound_clustering_for_similarity);
    
    
    metadata.Sound_clusters_mean_correlation = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).Sound_clusters_mean_correlation,metadata.Sound_clusters_mean_correlation);
    metadata.Sound_clusters_mean_reliability = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).Sound_clusters_mean_reliability,metadata.Sound_clusters_mean_reliability);
    metadata.Cluster_dominance = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).Cluster_dominance,metadata.Cluster_dominance);
    metadata.Strong_Cluster_dominance = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).Strong_Cluster_dominance,metadata.Strong_Cluster_dominance);
    metadata.sounds_per_cluster = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).sounds_per_cluster,metadata.sounds_per_cluster);
    if isfield (metadata,'Sound_cluster_freq_IQR')
    metadata.Sound_cluster_freq_IQR = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).Sound_cluster_freq_IQR,metadata.Sound_cluster_freq_IQR);
    end
    metadata.max_cluster_dominance = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).max_cluster_dominance,metadata.max_cluster_dominance);
    metadata.max_cluster_dominance_sound = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).max_cluster_dominance_sound,metadata.max_cluster_dominance_sound);
    
     
    
    elseif isfield(old_metadata.(analysis_window).(Celltypes).(Field),'Sound_clusters_mean_correlation')
    
    metadata.sound_clustering_for_similarity = old_metadata.(analysis_window).(Celltypes).(Field).sound_clustering_for_similarity;
    metadata.Sound_clusters_mean_correlation = old_metadata.(analysis_window).(Celltypes).(Field).Sound_clusters_mean_correlation;
    metadata.Sound_clusters_mean_reliability = old_metadata.(analysis_window).(Celltypes).(Field).Sound_clusters_mean_reliability;
    metadata.Cluster_dominance = old_metadata.(analysis_window).(Celltypes).(Field).Cluster_dominance;
    metadata.Strong_Cluster_dominance = old_metadata.(analysis_window).(Celltypes).(Field).Strong_Cluster_dominance;
    metadata.sounds_per_cluster = old_metadata.(analysis_window).(Celltypes).(Field).sounds_per_cluster;
    if isfield (old_metadata.(analysis_window).(Celltypes).(Field),'Sound_cluster_freq_IQR')
    metadata.Sound_cluster_freq_IQR = old_metadata.(analysis_window).(Celltypes).(Field).Sound_cluster_freq_IQR;
    end
    metadata.max_cluster_dominance = old_metadata.(analysis_window).(Celltypes).(Field).max_cluster_dominance;
    metadata.max_cluster_dominance_sound = old_metadata.(analysis_window).(Celltypes).(Field).max_cluster_dominance_sound;   
    
    
    end
    
    if isfield(metadata,'outside_sound_cluster_correlation') && isfield(old_metadata.(analysis_window).(Celltypes).(Field),'outside_sound_cluster_correlation')
    
    
    metadata.outside_sound_cluster_correlation = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).outside_sound_cluster_correlation,metadata.outside_sound_cluster_correlation);
    
    elseif isfield(old_metadata.(analysis_window).(Celltypes).(Field),'outside_sound_cluster_correlation')
    
    metadata.outside_sound_cluster_correlation = old_metadata.(analysis_window).(Celltypes).(Field).outside_sound_cluster_correlation;
   
    end
    
    if isfield(metadata,'overall_sound_correlations') && isfield(old_metadata.(analysis_window).(Celltypes).(Field),'overall_sound_correlations')
        metadata.overall_sound_correlations =  horzcat(old_metadata.(analysis_window).(Celltypes).(Field).overall_sound_correlations,metadata.overall_sound_correlations);
        metadata.overall_sound_reliabilities =  horzcat(old_metadata.(analysis_window).(Celltypes).(Field).overall_sound_reliabilities,metadata.overall_sound_reliabilities);
    elseif isfield(old_metadata.(analysis_window).(Celltypes).(Field),'overall_sound_correlations')
         metadata.overall_sound_correlations = old_metadata.(analysis_window).(Celltypes).(Field).overall_sound_correlations;
         metadata.overall_sound_reliabilities = old_metadata.(analysis_window).(Celltypes).(Field).overall_sound_reliabilities;
    end
    
    
end
end

function stats = subfield_stats(data1,data2)




if kstest((data1.fraction_of_clustered_sounds-mean(data1.fraction_of_clustered_sounds))/std(data1.fraction_of_clustered_sounds)) ==0 && kstest((data2.fraction_of_clustered_sounds-mean(data2.fraction_of_clustered_sounds))/std(data2.fraction_of_clustered_sounds))  ==0
    [h,p] = ttest(data1.fraction_of_clustered_sounds,data2.fraction_of_clustered_sounds);
    stats.fraction_of_clustered_sounds.p_value = p;
    stats.fraction_of_clustered_sounds.test_type = 'ttest';
else
    p = signrank(data1.fraction_of_clustered_sounds,data2.fraction_of_clustered_sounds);
    stats.fraction_of_clustered_sounds.p_value = p;
    stats.fraction_of_clustered_sounds.test_type = 'signrank';
end

stats.fraction_of_clustered_sounds.mean_1 = mean (data1.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.mean_2 = mean (data2.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.median_1 = median (data1.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.median_2 = median (data2.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.SD_1 = std (data1.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.SD_2 = std (data2.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.SEM_1 = std (data1.fraction_of_clustered_sounds)/sqrt(length((data1.fraction_of_clustered_sounds)));
stats.fraction_of_clustered_sounds.SEM_2 = std (data2.fraction_of_clustered_sounds)/sqrt(length((data2.fraction_of_clustered_sounds)));
stats.fraction_of_clustered_sounds.n_1 = length (data1.fraction_of_clustered_sounds);
stats.fraction_of_clustered_sounds.n_2 = length (data2.fraction_of_clustered_sounds);


if kstest((data1.neurons_per_FOV-mean(data1.neurons_per_FOV))/std(data1.neurons_per_FOV)) ==0 && kstest((data2.neurons_per_FOV-mean(data2.neurons_per_FOV))/std(data2.neurons_per_FOV))  ==0
    [h,p] = ttest(data1.neurons_per_FOV,data2.neurons_per_FOV);
    stats.neurons_per_FOV.p_value = p;
    stats.neurons_per_FOV.test_type = 'ttest';
else
    p = signrank(data1.neurons_per_FOV,data2.neurons_per_FOV);
    stats.neurons_per_FOV.p_value = p;
    stats.neurons_per_FOV.test_type = 'signrank';
end

stats.neurons_per_FOV.mean_1 = mean (data1.neurons_per_FOV);
stats.neurons_per_FOV.mean_2 = mean (data2.neurons_per_FOV);
stats.neurons_per_FOV.median_1 = median (data1.neurons_per_FOV);
stats.neurons_per_FOV.median_2 = median (data2.neurons_per_FOV);
stats.neurons_per_FOV.SD_1 = std (data1.neurons_per_FOV);
stats.neurons_per_FOV.SD_2 = std (data2.neurons_per_FOV);
stats.neurons_per_FOV.SEM_1 = std (data1.neurons_per_FOV)/sqrt(length((data1.neurons_per_FOV)));
stats.neurons_per_FOV.SEM_2 = std (data2.neurons_per_FOV)/sqrt(length((data2.neurons_per_FOV)));
stats.neurons_per_FOV.n_1 = length (data1.neurons_per_FOV);
stats.neurons_per_FOV.n_2 = length (data2.neurons_per_FOV);

if  kstest((data1.number_of_sound_clusters-mean(data1.number_of_sound_clusters))/std(data1.number_of_sound_clusters)) ==0 && kstest((data2.number_of_sound_clusters-mean(data2.number_of_sound_clusters))/std(data2.number_of_sound_clusters))  ==0
    [h,p] = ttest(data1.number_of_sound_clusters,data2.number_of_sound_clusters);
    stats.number_of_sound_clusters.p_value = p;
    stats.number_of_sound_clusters.test_type = 'ttest';
else
    p = signrank(data1.number_of_sound_clusters,data2.number_of_sound_clusters);
    stats.number_of_sound_clusters.p_value = p;
    stats.number_of_sound_clusters.test_type = 'signrank';
end

stats.number_of_sound_clusters.mean_1 = mean (data1.number_of_sound_clusters);
stats.number_of_sound_clusters.mean_2 = mean (data2.number_of_sound_clusters);
stats.number_of_sound_clusters.n_1 = length (data1.number_of_sound_clusters);
stats.number_of_sound_clusters.n_2 = length (data2.number_of_sound_clusters);
stats.number_of_sound_clusters.median_1 = median (data1.number_of_sound_clusters);
stats.number_of_sound_clusters.median_2 = median (data2.number_of_sound_clusters);
stats.number_of_sound_clusters.SD_1 = std (data1.number_of_sound_clusters);
stats.number_of_sound_clusters.SD_2 = std (data2.number_of_sound_clusters);
stats.number_of_sound_clusters.SEM_1 = std (data1.number_of_sound_clusters)/sqrt(length((data1.number_of_sound_clusters)));
stats.number_of_sound_clusters.SEM_2 = std (data2.number_of_sound_clusters)/sqrt(length((data2.number_of_sound_clusters)));



if std(data1.sounds_per_cluster) ==0 && std(data2.sounds_per_cluster) >0

kstest_1 = kstest(data1.sounds_per_cluster-mean(data1.sounds_per_cluster));   
kstest_2 = kstest((data2.sounds_per_cluster-mean(data2.sounds_per_cluster))/std(data2.sounds_per_cluster));

elseif std(data1.sounds_per_cluster) >0 && std(data2.sounds_per_cluster) ==0

kstest_2 = kstest(data2.sounds_per_cluster-mean(data2.sounds_per_cluster));   
kstest_1 = kstest((data1.sounds_per_cluster-mean(data1.sounds_per_cluster))/std(data1.sounds_per_cluster));

elseif std(data1.sounds_per_cluster) ==0 && std(data2.sounds_per_cluster) == 0

kstest_1 = kstest(data1.sounds_per_cluster-mean(data1.sounds_per_cluster));         
kstest_2 = kstest(data2.sounds_per_cluster-mean(data2.sounds_per_cluster)); 

else

kstest_1 = kstest((data1.sounds_per_cluster-mean(data1.sounds_per_cluster))/std(data1.sounds_per_cluster));
kstest_2 = kstest((data2.sounds_per_cluster-mean(data2.sounds_per_cluster))/std(data2.sounds_per_cluster));

end
    
if kstest_1 ==0 && kstest_2  ==0
    [h,p] = ttest2(data1.sounds_per_cluster,data2.sounds_per_cluster);
    stats.sounds_per_cluster.p_value = p;
    stats.sounds_per_cluster.test_type = 'ttest';
else
    p = ranksum(data1.sounds_per_cluster,data2.sounds_per_cluster);
    stats.sounds_per_cluster.p_value = p;
    stats.sounds_per_cluster.test_type = 'ranksum';
end



stats.sounds_per_cluster.mean_1 = mean (data1.sounds_per_cluster);
stats.sounds_per_cluster.mean_2 = mean (data2.sounds_per_cluster);
stats.sounds_per_cluster.n_1 = length (data1.sounds_per_cluster);
stats.sounds_per_cluster.n_2 = length (data2.sounds_per_cluster);
stats.sounds_per_cluster.median_1 = median (data1.sounds_per_cluster);
stats.sounds_per_cluster.median_2 = median (data2.sounds_per_cluster);
stats.sounds_per_cluster.SD_1 = std (data1.sounds_per_cluster);
stats.sounds_per_cluster.SD_2 = std (data2.sounds_per_cluster);
stats.sounds_per_cluster.SEM_1 = std (data1.sounds_per_cluster)/sqrt(length((data1.sounds_per_cluster)));
stats.sounds_per_cluster.SEM_2 = std (data2.sounds_per_cluster)/sqrt(length((data2.sounds_per_cluster)));


if kstest((data1.overall_sound_correlations-mean(data1.overall_sound_correlations))/std(data1.overall_sound_correlations)) ==0 && kstest((data2.overall_sound_correlations-mean(data2.overall_sound_correlations))/std(data2.overall_sound_correlations))  ==0
    [h,p] = ttest(data1.overall_sound_correlations,data2.overall_sound_correlations);
    stats.overall_sound_correlations.p_value = p;
    stats.overall_sound_correlations.test_type = 'ttest';
else
    p = signrank(data1.overall_sound_correlations,data2.overall_sound_correlations);
    stats.overall_sound_correlations.p_value = p;
    stats.overall_sound_correlations.test_type = 'signrank';
end


stats.overall_sound_correlations.mean_1 = mean (data1.overall_sound_correlations);
stats.overall_sound_correlations.mean_2 = mean (data2.overall_sound_correlations);
stats.overall_sound_correlations.n_1 = length (data1.overall_sound_correlations);
stats.overall_sound_correlations.n_2 = length (data2.overall_sound_correlations);
stats.overall_sound_correlations.median_1 = median (data1.overall_sound_correlations);
stats.overall_sound_correlations.median_2 = median (data2.overall_sound_correlations);
stats.overall_sound_correlations.SD_1 = std (data1.overall_sound_correlations);
stats.overall_sound_correlations.SD_2 = std (data2.overall_sound_correlations);
stats.overall_sound_correlations.SEM_1 = std (data1.overall_sound_correlations)/sqrt(length((data1.overall_sound_correlations)));
stats.overall_sound_correlations.SEM_2 = std (data2.overall_sound_correlations)/sqrt(length((data2.overall_sound_correlations)));


if kstest((data1.overall_sound_reliabilities-mean(data1.overall_sound_reliabilities))/std(data1.overall_sound_reliabilities)) ==0 && kstest((data2.overall_sound_reliabilities-mean(data2.overall_sound_reliabilities))/std(data2.overall_sound_reliabilities))  ==0
    [h,p] = ttest(data1.overall_sound_reliabilities,data2.overall_sound_reliabilities);
    stats.overall_sound_reliabilities.p_value = p;
    stats.overall_sound_reliabilities.test_type = 'ttest';
else
    p = signrank(data1.overall_sound_reliabilities,data2.overall_sound_reliabilities);
    stats.overall_sound_reliabilities.p_value = p;
    stats.overall_sound_reliabilities.test_type = 'signrank';
end


stats.overall_sound_reliabilities.mean_1 = mean (data1.overall_sound_reliabilities);
stats.overall_sound_reliabilities.mean_2 = mean (data2.overall_sound_reliabilities);
stats.overall_sound_reliabilities.n_1 = length (data1.overall_sound_reliabilities);
stats.overall_sound_reliabilities.n_2 = length (data2.overall_sound_reliabilities);
stats.overall_sound_reliabilities.median_1 = median (data1.overall_sound_reliabilities);
stats.overall_sound_reliabilities.median_2 = median (data2.overall_sound_reliabilities);
stats.overall_sound_reliabilities.SD_1 = std (data1.overall_sound_reliabilities);
stats.overall_sound_reliabilities.SD_2 = std (data2.overall_sound_reliabilities);
stats.overall_sound_reliabilities.SEM_1 = std (data1.overall_sound_reliabilities)/sqrt(length((data1.overall_sound_reliabilities)));
stats.overall_sound_reliabilities.SEM_2 = std (data2.overall_sound_reliabilities)/sqrt(length((data2.overall_sound_reliabilities)));





if kstest((data1.Sound_clusters_mean_correlation-mean(data1.Sound_clusters_mean_correlation))/std(data1.Sound_clusters_mean_correlation)) ==0 && kstest((data2.Sound_clusters_mean_correlation-mean(data2.Sound_clusters_mean_correlation))/std(data2.Sound_clusters_mean_correlation))  ==0
    [h,p] = ttest2(data1.Sound_clusters_mean_correlation,data2.Sound_clusters_mean_correlation);
    stats.Sound_clusters_mean_correlation.p_value = p;
    stats.Sound_clusters_mean_correlation.test_type = 'ttest';
else
    p = ranksum(data1.Sound_clusters_mean_correlation,data2.Sound_clusters_mean_correlation);
    stats.Sound_clusters_mean_correlation.p_value = p;
    stats.Sound_clusters_mean_correlation.test_type = 'ranksum';
end

stats.Sound_clusters_mean_correlation.mean_1 = mean (data1.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.mean_2 = mean (data2.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.n_1 = length (data1.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.n_2 = length (data2.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.median_1 = median (data1.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.median_2 = median (data2.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.SD_1 = std (data1.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.SD_2 = std (data2.Sound_clusters_mean_correlation);
stats.Sound_clusters_mean_correlation.SEM_1 = std (data1.Sound_clusters_mean_correlation)/sqrt(length((data1.Sound_clusters_mean_correlation)));
stats.Sound_clusters_mean_correlation.SEM_2 = std (data2.Sound_clusters_mean_correlation)/sqrt(length((data2.Sound_clusters_mean_correlation)));

if kstest((data1.outside_sound_cluster_correlation-mean(data1.outside_sound_cluster_correlation))/std(data1.outside_sound_cluster_correlation)) ==0 && kstest((data2.outside_sound_cluster_correlation-mean(data2.outside_sound_cluster_correlation))/std(data2.outside_sound_cluster_correlation))  ==0
    [h,p] = ttest2(data1.outside_sound_cluster_correlation,data2.outside_sound_cluster_correlation);
    stats.outside_sound_cluster_correlation.p_value = p;
    stats.outside_sound_cluster_correlation.test_type = 'ttest';
else
    p = ranksum(data1.outside_sound_cluster_correlation,data2.outside_sound_cluster_correlation);
    stats.outside_sound_cluster_correlation.p_value = p;
    stats.outside_sound_cluster_correlation.test_type = 'ranksum';
end

stats.outside_sound_cluster_correlation.mean_1 = mean (data1.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.mean_2 = mean (data2.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.n_1 = length (data1.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.n_2 = length (data2.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.median_1 = median (data1.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.median_2 = median (data2.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.SD_1 = std (data1.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.SD_2 = std (data2.outside_sound_cluster_correlation);
stats.outside_sound_cluster_correlation.SEM_1 = std (data1.outside_sound_cluster_correlation)/sqrt(length((data1.outside_sound_cluster_correlation)));
stats.outside_sound_cluster_correlation.SEM_2 = std (data2.outside_sound_cluster_correlation)/sqrt(length((data2.outside_sound_cluster_correlation)));

if kstest((data1.Sound_clusters_mean_reliability-mean(data1.Sound_clusters_mean_reliability))/std(data1.Sound_clusters_mean_reliability)) ==0 && kstest((data2.Sound_clusters_mean_reliability-mean(data2.Sound_clusters_mean_reliability))/std(data2.Sound_clusters_mean_reliability))  ==0
    [h,p] = ttest2(data1.Sound_clusters_mean_reliability,data2.Sound_clusters_mean_reliability);
    stats.Sound_clusters_mean_reliability.p_value = p;
    stats.Sound_clusters_mean_reliability.test_type = 'ttest';
else
    p = ranksum(data1.Sound_clusters_mean_reliability,data2.Sound_clusters_mean_reliability);
    stats.Sound_clusters_mean_reliability.p_value = p;
    stats.Sound_clusters_mean_reliability.test_type = 'ranksum';
end


stats.Sound_clusters_mean_reliability.mean_1 = mean (data1.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.mean_2 = mean (data2.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.n_1 = length (data1.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.n_2 = length (data2.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.median_1 = median (data1.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.median_2 = median (data2.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.SD_1 = std (data1.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.SD_2 = std (data2.Sound_clusters_mean_reliability);
stats.Sound_clusters_mean_reliability.SEM_1 = std (data1.Sound_clusters_mean_reliability)/sqrt(length((data1.Sound_clusters_mean_reliability)));
stats.Sound_clusters_mean_reliability.SEM_2 = std (data2.Sound_clusters_mean_reliability)/sqrt(length((data2.Sound_clusters_mean_reliability)));

if isfield (data1,'Sound_cluster_freq_IQR')

if kstest((data1.Sound_cluster_freq_IQR-mean(data1.Sound_cluster_freq_IQR))/std(data1.Sound_cluster_freq_IQR)) ==0 && kstest((data2.Sound_cluster_freq_IQR-mean(data2.Sound_cluster_freq_IQR))/std(data2.Sound_cluster_freq_IQR))  ==0
    [h,p] = ttest2(data1.Sound_cluster_freq_IQR,data2.Sound_cluster_freq_IQR);
    stats.Sound_cluster_freq_IQR.p_value = p;
    stats.Sound_cluster_freq_IQR.test_type = 'ttest';
else
    p = ranksum(data1.Sound_cluster_freq_IQR,data2.Sound_cluster_freq_IQR);
    stats.Sound_cluster_freq_IQR.p_value = p;
    stats.Sound_cluster_freq_IQR.test_type = 'ranksum';
end

stats.Sound_cluster_freq_IQR.mean_1 = mean (data1.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.mean_2 = mean (data2.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.n_1 = length (data1.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.n_2 = length (data2.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.median_1 = median (data1.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.median_2 = median (data2.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.SD_1 = std (data1.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.SD_2 = std (data2.Sound_cluster_freq_IQR);
stats.Sound_cluster_freq_IQR.SEM_1 = std (data1.Sound_cluster_freq_IQR)/sqrt(length((data1.Sound_cluster_freq_IQR)));
stats.Sound_cluster_freq_IQR.SEM_2 = std (data2.Sound_cluster_freq_IQR)/sqrt(length((data2.Sound_cluster_freq_IQR)));

end

if std(data1.max_cluster_dominance) ==0
stats.max_cluster_dominance.p_value = 1;    
stats.max_cluster_dominance.test_type = 'none';

else

if kstest((data1.max_cluster_dominance-mean(data1.max_cluster_dominance))/std(data1.max_cluster_dominance)) ==0 && kstest((data2.max_cluster_dominance-mean(data2.max_cluster_dominance))/std(data2.max_cluster_dominance))  ==0
    [h,p] = ttest2(data1.max_cluster_dominance,data2.max_cluster_dominance);
    stats.max_cluster_dominance.p_value = p;
    stats.max_cluster_dominance.test_type = 'ttest';
else
    p = ranksum(data1.max_cluster_dominance,data2.max_cluster_dominance);
    stats.max_cluster_dominance.p_value = p;
    stats.max_cluster_dominance.test_type = 'ranksum';
end
end

stats.max_cluster_dominance.mean_1 = mean (data1.max_cluster_dominance);
stats.max_cluster_dominance.mean_2 = mean (data2.max_cluster_dominance);
stats.max_cluster_dominance.n_1 = length (data1.max_cluster_dominance);
stats.max_cluster_dominance.n_2 = length (data2.max_cluster_dominance);
stats.max_cluster_dominance.median_1 = median (data1.max_cluster_dominance);
stats.max_cluster_dominance.median_2 = median (data2.max_cluster_dominance);
stats.max_cluster_dominance.SD_1 = std (data1.max_cluster_dominance);
stats.max_cluster_dominance.SD_2 = std (data2.max_cluster_dominance);
stats.max_cluster_dominance.SEM_1 = std (data1.max_cluster_dominance)/sqrt(length((data1.max_cluster_dominance)));
stats.max_cluster_dominance.SEM_2 = std (data2.max_cluster_dominance)/sqrt(length((data2.max_cluster_dominance)));


stats.Cluster_dominance.set1.PT = 0;
stats.Cluster_dominance.set1.AM = 0;
stats.Cluster_dominance.set1.AM_20Hz = 0;
stats.Cluster_dominance.set1.AM_40Hz = 0;
stats.Cluster_dominance.set1.Animal_sounds = 0;
stats.Cluster_dominance.set1.mixed = 0;

stats.Cluster_dominance.set2.PT = 0;
stats.Cluster_dominance.set2.AM = 0;
stats.Cluster_dominance.set2.AM_20Hz = 0;
stats.Cluster_dominance.set2.AM_40Hz = 0;
stats.Cluster_dominance.set2.Animal_sounds = 0;
stats.Cluster_dominance.set2.mixed = 0;

for i=1:length(data1.Cluster_dominance)

                   if contains(data1.Cluster_dominance{i}, 'PT')
                       
                       stats.Cluster_dominance.set1.PT = stats.Cluster_dominance.set1.PT +1 ;
                        
                    elseif contains(data1.Cluster_dominance{i}, 'AM')
                        
                        stats.Cluster_dominance.set1.AM = stats.Cluster_dominance.set1.AM +1 ;
                        
                        if contains(data1.Cluster_dominance{i}, 'AM_20Hz')
                            stats.Cluster_dominance.set1.AM_20Hz = stats.Cluster_dominance.set1.AM_20Hz +1 ;
                        elseif contains(data1.Cluster_dominance{i}, 'AM_40Hz')
                            stats.Cluster_dominance.set1.AM_40Hz = stats.Cluster_dominance.set1.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data1.Cluster_dominance{i}, 'Animal_sounds')
                        
                        stats.Cluster_dominance.set1.Animal_sounds = stats.Cluster_dominance.set1.Animal_sounds +1 ;
                        
                   elseif contains(data1.Cluster_dominance{i}, 'mixed' )
                       
                       stats.Cluster_dominance.set1.mixed = stats.Cluster_dominance.set1.mixed +1 ;
                        
                   end
end

for i=1:length(data2.Cluster_dominance)

                   if contains(data2.Cluster_dominance{i}, 'PT')
                       
                       stats.Cluster_dominance.set2.PT = stats.Cluster_dominance.set2.PT +1 ;
                        
                    elseif contains(data2.Cluster_dominance{i}, 'AM')
                        
                        stats.Cluster_dominance.set2.AM = stats.Cluster_dominance.set2.AM +1 ;
                        
                        if contains(data2.Cluster_dominance{i}, 'AM_20Hz')
                            stats.Cluster_dominance.set2.AM_20Hz = stats.Cluster_dominance.set2.AM_20Hz +1 ;
                        elseif contains(data2.Cluster_dominance{i}, 'AM_40Hz')
                            stats.Cluster_dominance.set2.AM_40Hz = stats.Cluster_dominance.set2.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data2.Cluster_dominance{i}, 'Animal_sounds')
                        
                        stats.Cluster_dominance.set2.Animal_sounds = stats.Cluster_dominance.set2.Animal_sounds +1 ;
                       
                        
                   elseif contains(data2.Cluster_dominance{i}, 'mixed' )
                       
                       stats.Cluster_dominance.set2.mixed = stats.Cluster_dominance.set2.mixed +1 ;
                        
                   end
end
 

stats.Strong_Cluster_dominance.set1.PT = 0;
stats.Strong_Cluster_dominance.set1.AM = 0;
stats.Strong_Cluster_dominance.set1.AM_20Hz = 0;
stats.Strong_Cluster_dominance.set1.AM_40Hz = 0;
stats.Strong_Cluster_dominance.set1.Animal_sounds = 0;
stats.Strong_Cluster_dominance.set1.mixed = 0;

stats.Strong_Cluster_dominance.set2.PT = 0;
stats.Strong_Cluster_dominance.set2.AM = 0;
stats.Strong_Cluster_dominance.set2.AM_20Hz = 0;
stats.Strong_Cluster_dominance.set2.AM_40Hz = 0;
stats.Strong_Cluster_dominance.set2.Animal_sounds = 0;
stats.Strong_Cluster_dominance.set2.mixed = 0;

for i=1:length(data1.Strong_Cluster_dominance)

                   if contains(data1.Strong_Cluster_dominance{i}, 'PT')
                       
                       stats.Strong_Cluster_dominance.set1.PT = stats.Strong_Cluster_dominance.set1.PT +1 ;
                        
                    elseif contains(data1.Strong_Cluster_dominance{i}, 'AM')
                        
                        stats.Strong_Cluster_dominance.set1.AM = stats.Strong_Cluster_dominance.set1.AM +1 ;
                        
                        if contains(data1.Strong_Cluster_dominance{i}, 'AM_20Hz')
                            stats.Strong_Cluster_dominance.set1.AM_20Hz = stats.Strong_Cluster_dominance.set1.AM_20Hz +1 ;
                        elseif contains(data1.Strong_Cluster_dominance{i}, 'AM_40Hz')
                            stats.Strong_Cluster_dominance.set1.AM_40Hz = stats.Strong_Cluster_dominance.set1.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data1.Strong_Cluster_dominance{i}, 'Animal_sounds')
                        
                        stats.Strong_Cluster_dominance.set1.Animal_sounds = stats.Strong_Cluster_dominance.set1.Animal_sounds +1 ;
                       
                        
                   elseif contains(data1.Strong_Cluster_dominance{i}, 'mixed' )
                       
                       stats.Strong_Cluster_dominance.set1.mixed = stats.Strong_Cluster_dominance.set1.mixed +1 ;
                        
                   end
end

for i=1:length(data2.Strong_Cluster_dominance)

                   if contains(data2.Strong_Cluster_dominance{i}, 'PT')
                       
                       stats.Strong_Cluster_dominance.set2.PT = stats.Strong_Cluster_dominance.set2.PT +1 ;
                        
                    elseif contains(data2.Strong_Cluster_dominance{i}, 'AM')
                        
                        stats.Strong_Cluster_dominance.set2.AM = stats.Strong_Cluster_dominance.set2.AM +1 ;
                        
                        if contains(data2.Strong_Cluster_dominance{i}, 'AM_20Hz')
                            stats.Strong_Cluster_dominance.set2.AM_20Hz = stats.Strong_Cluster_dominance.set2.AM_20Hz +1 ;
                        elseif contains(data2.Strong_Cluster_dominance{i}, 'AM_40Hz')
                            stats.Strong_Cluster_dominance.set2.AM_40Hz = stats.Strong_Cluster_dominance.set2.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data2.Strong_Cluster_dominance{i}, 'Animal_sounds')
                        
                        stats.Strong_Cluster_dominance.set2.Animal_sounds = stats.Strong_Cluster_dominance.set2.Animal_sounds +1 ;
                       

                   elseif contains(data2.Strong_Cluster_dominance{i}, 'mixed' )
                       
                       stats.Strong_Cluster_dominance.set2.mixed = stats.Strong_Cluster_dominance.set2.mixed +1 ;
                        
                   end
end


stats.max_cluster_dominance_sound.set1.PT = 0;
stats.max_cluster_dominance_sound.set1.AM = 0;
stats.max_cluster_dominance_sound.set1.AM_20Hz = 0;
stats.max_cluster_dominance_sound.set1.AM_40Hz = 0;
stats.max_cluster_dominance_sound.set1.Animal_sounds = 0;
stats.max_cluster_dominance_sound.set1.mixed = 0;

stats.max_cluster_dominance_sound.set2.PT = 0;
stats.max_cluster_dominance_sound.set2.AM = 0;
stats.max_cluster_dominance_sound.set2.AM_20Hz = 0;
stats.max_cluster_dominance_sound.set2.AM_40Hz = 0;
stats.max_cluster_dominance_sound.set2.Animal_sounds = 0;
stats.max_cluster_dominance_sound.set2.mixed = 0;

for i=1:length(data1.max_cluster_dominance_sound)

                   if contains(data1.max_cluster_dominance_sound{i}, 'PT')
                       
                       stats.max_cluster_dominance_sound.set1.PT = stats.max_cluster_dominance_sound.set1.PT +1 ;
                        
                    elseif contains(data1.max_cluster_dominance_sound{i}, 'AM')
                        
                        stats.max_cluster_dominance_sound.set1.AM = stats.max_cluster_dominance_sound.set1.AM +1 ;
                        
                        if contains(data1.max_cluster_dominance_sound{i}, 'AM_20Hz')
                            stats.max_cluster_dominance_sound.set1.AM_20Hz = stats.max_cluster_dominance_sound.set1.AM_20Hz +1 ;
                        elseif contains(data1.max_cluster_dominance_sound{i}, 'AM_40Hz')
                            stats.max_cluster_dominance_sound.set1.AM_40Hz = stats.max_cluster_dominance_sound.set1.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data1.max_cluster_dominance_sound{i}, 'Animal_sounds')
                        
                        stats.max_cluster_dominance_sound.set1.Animal_sounds = stats.max_cluster_dominance_sound.set1.Animal_sounds +1 ;
                       
                        
                   elseif contains(data1.max_cluster_dominance_sound{i}, 'mixed' )
                       
                       stats.max_cluster_dominance_sound.set1.mixed = stats.max_cluster_dominance_sound.set1.mixed +1 ;
                        
                   end
end

for i=1:length(data2.max_cluster_dominance_sound)

                   if contains(data2.max_cluster_dominance_sound{i}, 'PT')
                       
                       stats.max_cluster_dominance_sound.set2.PT = stats.max_cluster_dominance_sound.set2.PT +1 ;
                        
                    elseif contains(data2.max_cluster_dominance_sound{i}, 'AM')
                        
                        stats.max_cluster_dominance_sound.set2.AM = stats.max_cluster_dominance_sound.set2.AM +1 ;
                        
                        if contains(data2.max_cluster_dominance_sound{i}, 'AM_20Hz')
                            stats.max_cluster_dominance_sound.set2.AM_20Hz = stats.max_cluster_dominance_sound.set2.AM_20Hz +1 ;
                        elseif contains(data2.max_cluster_dominance_sound{i}, 'AM_40Hz')
                            stats.max_cluster_dominance_sound.set2.AM_40Hz = stats.max_cluster_dominance_sound.set2.AM_40Hz +1 ;
                        end
                        
                        
                    elseif contains(data2.max_cluster_dominance_sound{i}, 'Animal_sounds')
                        
                        stats.max_cluster_dominance_sound.set2.Animal_sounds = stats.max_cluster_dominance_sound.set2.Animal_sounds +1 ;
                       
                        
                   elseif contains(data2.max_cluster_dominance_sound{i}, 'mixed' )
                       
                       stats.max_cluster_dominance_sound.set2.mixed = stats.max_cluster_dominance_sound.set2.mixed +1 ;
                        
                   end
end

  for o = 1:length(data1.sound_clustering_for_similarity)
      max_similiarity_of_cluster =[];
      for p = 1:length(data1.sound_clustering_for_similarity{o})
            
          similiarity_internal = [];
           for a = 1:length(data2.sound_clustering_for_similarity{o})
          
            inter = intersect(data1.sound_clustering_for_similarity{o}{p},data2.sound_clustering_for_similarity{o}{a});  
            similiarity_internal(a) = length(inter)/length(data1.sound_clustering_for_similarity{o}{p});
            
           end
           
           max_similiarity_of_cluster (p) = max(similiarity_internal);
      end
      
      stats.similiarity_of_FOV (o) = mean (max_similiarity_of_cluster);
  end
  


end
