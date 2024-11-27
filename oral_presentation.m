addpath("./utils");

close all;clear all;clc

load("Examples/example_1/C1.mat", "C1");
load("Examples/example_1/C2.mat", "C2");
load("Examples/example_1/net.mat", "net");

generate_visualization(C1, C2, net, net.numLayers, 3);gith