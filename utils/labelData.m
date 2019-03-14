clear all
close all

walk_1 = load("data_walk0.mat");
squat_1 = load("data_squat0.mat");
walk_2 = load("data_walk1.mat");
squat_2 = load("data_squat1.mat");

[c1,c2] = labelFrames(squat_1.data,50);