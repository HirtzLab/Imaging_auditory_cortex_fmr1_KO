% Authors : Simon Wadle 2019-2023
%function reads time point from PrairieView voltage recording files and
%converts it to frame time points

function time_points = voltage_time_points_frames_random_order(csv_filename, varargin)
% normalizes frames to real time points in ms and frames
% output is a cell array with time points & frame number of each presented stimulus and
% all start and end times & frames for calculating baseline and activity

narginchk(1,9)


if nargin >= 2; tone_duration_ms = varargin{1}; else; tone_duration_ms = 500; end
if nargin >= 3; pause_duration_ms = varargin{2}; else; pause_duration_ms = 5000; end
if nargin >= 4; repetitions = varargin{3}; else; repetitions = 3; end
if nargin >= 5; baseline_ms_start = varargin{4}; else; baseline_ms_start = 500; end
if nargin >= 6; baseline_ms_end = varargin{5}; else; baseline_ms_end = 300; end
if nargin >= 7; activity_ms_start = varargin{6}; else; activity_ms_start = 0; end
if nargin >= 8; activity_ms_end = varargin{7}; else; activity_ms_end = 1000; end
if nargin == 9; first_tone_ms = varargin{8}; else; first_tone_ms = 3000; end

[voltage_time_points,~] = time_points_WF_imaging(csv_filename);
%function gives time points in ms, where a frame was recorded

voltage_time_points_norm_temp = zeros(size(voltage_time_points{1,1}(:,:),1),1);
for ii = 1:size(voltage_time_points,1)
    voltage_time_points_norm_temp(:,ii) = voltage_time_points{ii,1} - voltage_time_points{ii,1}(1,1);
end

voltage_time_points_norm = zeros(0,0);
for ii = 0:size(voltage_time_points_norm_temp,2)-1
    if ii == 0
        voltage_time_points_norm = voltage_time_points_norm_temp(:,1);
    else
        voltage_time_points_norm(end+1:end+size(voltage_time_points_norm_temp,1),1) = voltage_time_points_norm_temp(:,ii)+size(voltage_time_points_norm_temp,1)*ii;
    end       
end

duration_ms = tone_duration_ms + pause_duration_ms;
time_points_tone_ms = zeros(4,repetitions);

for j = 0:repetitions-1
    time_points_tone_ms(1,j+1) = first_tone_ms + duration_ms * 6 * j;
    time_points_tone_ms(2,j+1) = first_tone_ms + duration_ms * 6 * j + duration_ms;
    time_points_tone_ms(3,j+1) = first_tone_ms + duration_ms * 6 * j + duration_ms * 2;
    time_points_tone_ms(4,j+1) = first_tone_ms + duration_ms * 6 * j + duration_ms * 3;
    time_points_tone_ms(5,j+1) = first_tone_ms + duration_ms * 6 * j + duration_ms * 4;
    time_points_tone_ms(6,j+1) = first_tone_ms + duration_ms * 6 * j + duration_ms * 5;
end

% convert baseline & activity time points from ms in corresponding nearest frame
time_points.baseline_time_points_start_ms = time_points_tone_ms - baseline_ms_start;
time_points.baseline_time_points_end_ms = time_points_tone_ms - baseline_ms_end;
time_points.activity_time_points_start_ms = time_points_tone_ms + activity_ms_start;
time_points.activity_time_points_end_ms = time_points_tone_ms + activity_ms_end;

% search nearest neighbor frame of each played tone
time_points.baseline_time_points_start_f = reshape(knnsearch(voltage_time_points_norm, reshape(time_points.baseline_time_points_start_ms,[],1)), 6,[]);
time_points.baseline_time_points_end_f = reshape(knnsearch(voltage_time_points_norm, reshape(time_points.baseline_time_points_end_ms,[],1)), 6,[]);
time_points.activity_time_points_start_f = reshape(knnsearch(voltage_time_points_norm, reshape(time_points.activity_time_points_start_ms,[],1)), 6,[]);
time_points.activity_time_points_end_f = reshape(knnsearch(voltage_time_points_norm, reshape(time_points.activity_time_points_end_ms,[],1)), 6,[]);

time_points.time_points_tone_f = reshape(knnsearch(voltage_time_points_norm, reshape(time_points_tone_ms,[],1)), 6,[]);
