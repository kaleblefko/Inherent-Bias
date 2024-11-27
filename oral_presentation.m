addpath("./utils");

close all;clear all;clc

load("Good/perfect/C1.mat", "C1");
load("Good/perfect/C2.mat", "C2");
load("Good/perfect/net.mat", "net");

generate_visualization(C1, C2, net, net.numLayers-1, 3);