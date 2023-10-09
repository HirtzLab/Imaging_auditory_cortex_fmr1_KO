% To be run after Cluster_analysis_pipeline_between_days code, performs additional
% analyses and statistics

% Field 0 is not the combination of all FOVs in different subfields, but in
% case no subfield parcelation was selected


clearvars;



animals_in_group_1 = {'animal_1','animal_2','...'}; 
animals_in_group_2 = {'animal_11','animal_12','...'}; 

root_path = 'fill in'; 


all_cluster_files = dir([root_path, '\**\filename_you_used.mat']);
FOV_analyzed.group_1 ={};
FOV_analyzed.group_2 ={};

for ii = 1:size(all_cluster_files)
    
    cur_cluster_file = fullfile(all_cluster_files(ii).folder, all_cluster_files(ii).name);
    path_parts = split(cur_cluster_file, '\');

    
    animal=path_parts{end-4}; 
    
   
if  sum(ismember(animals_in_group_1,animal))>0 ||  sum(ismember(animals_in_group_2,animal))>0   
    
    if sum(ismember(animals_in_group_1,animal))>0
    group = 'group_1';
    elseif sum(ismember(animals_in_group_2,animal))>0    
    group = 'group_2';
    end
    
    
    
    
    
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
    
    metadata.day_correlation = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.day_correlation;
    
    
    
else
    
    metadata.day_correlation = Loaded_data.Results.(analysis_window).(Celltypes).Cluster_analysis.(Field).common_data.day_correlation;
    
    metadata.day_correlation = horzcat(old_metadata.(analysis_window).(Celltypes).(Field).day_correlation,metadata.day_correlation);
end
end



function stats = subfield_stats(data1,data2)

if kstest((data1.day_correlation-mean(data1.day_correlation))/std(data1.day_correlation)) ==0 && kstest((data2.day_correlation-mean(data2.day_correlation))/std(data2.day_correlation))  ==0
    [h,p] = ttest2(data1.day_correlation,data2.day_correlation);
    stats.day_correlation.p_value = p;
    stats.day_correlation.test_type = 'ttest';
else
    p = ranksum(data1.day_correlation,data2.day_correlation);
    stats.day_correlation.p_value = p;
    stats.day_correlation.test_type = 'ranksum';
end

stats.day_correlation.mean_1 = mean (data1.day_correlation);
stats.day_correlation.mean_2 = mean (data2.day_correlation);
stats.day_correlation.median_1 = median (data1.day_correlation);
stats.day_correlation.median_2 = median (data2.day_correlation);
stats.day_correlation.SD_1 = std (data1.day_correlation);
stats.day_correlation.SD_2 = std (data2.day_correlation);
stats.day_correlation.SEM_1 = std (data1.day_correlation)/sqrt(length((data1.day_correlation)));
stats.day_correlation.SEM_2 = std (data2.day_correlation)/sqrt(length((data2.day_correlation)));
stats.day_correlation.n_1 = length (data1.day_correlation);
stats.day_correlation.n_2 = length (data2.day_correlation);



end
