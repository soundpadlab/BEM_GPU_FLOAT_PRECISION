%% This script illustrates the relationship between two axis-aligned rectangles
clear; close all; clc;

hFig = figure;
hAx = axes(hFig);

daspect(hAx,[1,1,1]);

%% draw two rectangles

drawAARect(hAx,[1,1],0.5,1);
drawAARect(hAx,[3,3],1.5,2);

xlim(hAx,[-1,5]);
ylim(hAx,[-1,5]);
%set(hAx,'tight');

%h.pos = [1,1,totwidth,totheight];
%setfig(hFig,hAx,h);
%set(hAx,'visible','off');