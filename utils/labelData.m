clear all
close all

walk_1 = load("data_walk0.mat");
fall_1 = load("data_fall3.mat");
walk_2 = load("data_walk1.mat");
fall_2 = load("data_fall4.mat");

[c1,c2] = labelFrames(fall_1.data,10);
[c1_,c2_] = labelFrames(fall_2.data,10);
fall = cat(1,c2,c2_);