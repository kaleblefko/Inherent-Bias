addpath("./utils");
close all; clear all; clc

l = 3;
mode = 1;
N_min = 350;
N_max = 5000;
mean_min = 1;
mean_max = 200;
cov_min = 10;
cov_max = 80;

number_hidden_layers = 5;
max_neurons = 30;
train_fnc = 'traingd';

% todo: generate N random datasets and train new model on each one, keeping
% track of the amount of times bias is found. preferrably save out
% datasets, model, and p values for each bias detection example.