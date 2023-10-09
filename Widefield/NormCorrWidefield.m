% Authors : Simon Wadle 2019-2023
%function corrects movement by utilizing the NormCorr Package
function motion_corrected_data = NormCorrWidefield(Yf)
gcp;
addpath('NoRMCorre');
%Yf = read_file(name,1,200);
Yf = single(Yf);
[d1,d2,~] = size(Yf);

%% perform some sort of deblurring/high pass filtering

gSig = 7;
gSiz = 10;
psf = fspecial('gaussian', gSiz, gSig);
ind_nonzero = (psf(:)>=max(psf(:,1)));
psf = psf-mean(psf(ind_nonzero));
psf(~ind_nonzero) = 0;   % only use pixels within the center disk
Y = imfilter(Yf,psf,'symmetric');
bound = 0;

%% apply rigid + non-rigid motion correction

options_nr = NoRMCorreSetParms('d1',d1-bound,'d2',d2-bound,'bin_width',200, ...
    'grid_size',[64,64],'mot_uf',4,'correct_bidir',false, ...
    'overlap_pre',32,'overlap_post',32,'max_shift',20, 'max_dev', [10,10,1], 'iter', 1);

template = median(Y, 3);

[~,shifts,~] = normcorre_batch(Y(bound/2+1:end-bound/2,bound/2+1:end-bound/2,:),options_nr, template);% register filtered data
motion_corrected_data = apply_shifts(Yf,shifts,options_nr,bound/2,bound/2); % apply the shifts to the removed percentile
