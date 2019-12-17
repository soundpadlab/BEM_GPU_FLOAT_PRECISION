%% This script visualizes data generated from the data generator
clear; close all; clc;

%% specify the path
inputbase = '../data/validation/input/raw/';
outputbase = '../data/validation/output/raw/';

gridnamebase = 'vox0';
fieldnamebase = 'field0';

gridpath = [inputbase,gridnamebase];
numOct = 4;
numSrc = 8;
fig1 = figure;
ax1 = axes(fig1);
daspect(ax1,[1,1,1]);
set(ax1,'visible','off');
fig2 = figure;
ax2 = axes(fig2);
for i=1:numOct
    for j=1:numSrc
        fieldname = [fieldnamebase,'_oct',num2str(i-1),'_src',num2str(j-1)];
        fieldpath = [outputbase,fieldname];
        [grid,field] = ProcessRawData(gridpath,fieldpath,100,-4);
        %save([field_path,'slow.mat'],'field');
        if i==1 && j==1
            imagesc(ax2,grid);
            set(ax2,'visible','off');
            daspect(ax2,[1,1,1]);
        end
        caxis(ax1,[-5,12]);
        imagesc(ax1,field);
        set(ax1,'visible','off');
        daspect(ax1,[1,1,1]);
        pause(3.0);
    end
end
