% Authors : Simon Wadle 2019-2023
%function reads coordinates from PrarieView log files and gives x, y
%coordinates in MATLAB format
function coordinates = read_coordinates_from_txt_file(txt_filename)

fid = fopen(txt_filename);
information = fscanf(fid, '%s');
fclose(fid);


x_idxs = strfind(information, 'x');
y_idxs = strfind(information, 'y');

for ii  = 1:size(x_idxs,2)
    x_cnt = 2;
    temp_number = '';
    while ~isempty(regexp(information(x_idxs(ii)+x_cnt), '[0-9-]')) && ii+x_cnt <= length(information)
        
        temp_number = [temp_number ,information(x_idxs(ii)+x_cnt)];
        x_cnt = x_cnt + 1;
        
    end
    coordinates(ii,1) = str2double(temp_number);
    y_cnt = 2;
    temp_number = '';
    
    while ~isempty(regexp(information(y_idxs(ii)+y_cnt), '[0-9-]')) && ii+y_cnt <= length(information)
        
        temp_number = [temp_number, information(y_idxs(ii)+y_cnt)];
        y_cnt = y_cnt + 1;
        if y_idxs(ii) + y_cnt > length(information)
            break
        end
    end

    
    coordinates(ii,2) = str2double(temp_number);
    
end
