% Authors : Simon Wadle 2019-2023
%function exports tif with the generic MATLAB function
function tiff_export(image_data, path)

output_file = Tiff(path, 'w');

[height, width, frames] = size(image_data);
export_data = uint16(image_data);
% export_data = reshape(export_data, height, width, 1, frames);

placeholder = ['%',num2str(floor(log10(frames))+1),'d'];
backspaces = repmat('\b', 1, floor(log10(frames)+1)*2 +4);
fprintf(['exporting image ', placeholder,' of ', placeholder], 1, frames)
for ii = 1:frames
    fprintf([backspaces, placeholder, ' of ', placeholder], ii, frames)
    setTag(output_file,'Photometric',Tiff.Photometric.MinIsBlack);
    setTag(output_file,'Compression',Tiff.Compression.None);
    setTag(output_file,'BitsPerSample',16);
    setTag(output_file,'SamplesPerPixel',1);
    setTag(output_file,'SampleFormat',Tiff.SampleFormat.UInt);
    setTag(output_file,'ImageLength',height);
    setTag(output_file,'ImageWidth',width);
    setTag(output_file,'PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);

    output_file.write(export_data(:,:,ii));
    if ii ~= frames        
        output_file.writeDirectory();
    end    
end
fprintf('\n')
close(output_file);