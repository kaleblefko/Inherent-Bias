addpath("./utils");

close all;clear all;clc

set(0,'defaultfigurecolor',[1 1 1])

load("Good/perfect/C1.mat", "C1");
load("Good/perfect/C2.mat", "C2");
load("Good/perfect/net.mat", "net");

[idxs, ratios] = generate_visualization(C1, C2, net, net.numLayers-1, 3, true);
disp(ratios);