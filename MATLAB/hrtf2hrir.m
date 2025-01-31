%% This script converts hrtfs to hrirs
clear; close all; clc;

%% setting up parameters
low_freq = 25;
up_freq = 12000;
freq_interp = 25;
low_phi = 0;
up_phi = 355;
phi_interp = 5;
low_theta = 0;
up_theta = 135;
theta_interp = 5;

numFreqs = floor((up_freq-low_freq)/freq_interp)+1;
numHorizontalSrcs = floor((up_phi-low_phi)/phi_interp)+1;
numVerticalSrcs = floor((up_theta-low_theta)/theta_interp)+1;

%% read files
folder = '/media/ziqi/HardDisk/Lab/BEM_GPU_FLOAT_PRECISION/MATLAB/';
filename = 'left_hrtfs';
format = '(%f,%f) ';
path = [folder,filename];
fileID = fopen(path,'r');
temp = fscanf(fileID,format);
left_hrtfs = zeros(numHorizontalSrcs+numVerticalSrcs,numFreqs);
for i = 1 : numHorizontalSrcs+numVerticalSrcs
    for j = 1 : numFreqs
        idx = (i-1)*numFreqs+j;
        x = temp(2*(idx-1)+1);
        y = temp(2*(idx-1)+2);
        left_hrtfs(i,j) = complex(x,y);
    end
end
fclose(fileID);

filename = 'right_hrtfs';
format = '(%f,%f) ';
path = [folder,filename];
fileID = fopen(path,'r');
temp = fscanf(fileID,format);
right_hrtfs = zeros(numHorizontalSrcs+numVerticalSrcs,numFreqs);
for i = 1 : numHorizontalSrcs+numVerticalSrcs
    for j = 1 : numFreqs
        idx = (i-1)*numFreqs+j;
        x = temp(2*(idx-1)+1);
        y = temp(2*(idx-1)+2);
        right_hrtfs(i,j) = complex(x,y);
    end
end
fclose(fileID);

%% convert hrtfs to hrirs
% adding an element for the 0Hz
temp = left_hrtfs;
left_hrtfs = ones(size(left_hrtfs,1),size(left_hrtfs,2)+1);
left_hrtfs(:,2:end) = temp;

temp = right_hrtfs;
right_hrtfs = ones(size(right_hrtfs,1),size(right_hrtfs,2)+1);
right_hrtfs(:,2:end) = temp;

% adding another half of the frquency content
temp = conj(flip(left_hrtfs,2));
left_hrtfs_full_freq = [left_hrtfs,temp(:,2:end)];
temp = conj(flip(right_hrtfs,2));
right_hrtfs_full_freq  = [right_hrtfs,temp(:,2:end)];

left_hrirs = ifft(left_hrtfs_full_freq,2);
right_hrirs = ifft(right_hrtfs_full_freq,2);



