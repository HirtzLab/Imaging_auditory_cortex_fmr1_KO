% Authors : Simon Wadle 2019-2023
%function writes tiff stacks faster than generic MATLAB function

function fast_tiff_export(filename, image_data)
image_data = permute(image_data, [2 1 3]);
ftif = Fast_Tiff_Write(filename);
[~, ~, frames] = size(image_data);
placeholder = ['%',num2str(floor(log10(frames))+1),'d'];
backspaces = repmat('\b', 1, floor(log10(frames)+1)*2 +4);
fprintf(['exporting image ', placeholder,' of ', placeholder], 1, frames)

for ii = 1:frames
    fprintf([backspaces, placeholder, ' of ', placeholder], ii, frames)
    ftif.WriteIMG(image_data(:,:,ii));    
end
fprintf('\n')
ftif.close;