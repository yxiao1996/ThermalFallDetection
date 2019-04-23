clear all
close all

walk_1 = load("top_stand0.mat");
fall_1 = load("top_fall0.mat");
walk_2 = load("top_stand1.mat");
fall_2 = load("top_fall1.mat");

[c1,c2] = labelFrames(walk_1.data,10);
[c1_,c2_] = labelFrames(walk_2.data,10);
walk = cat(1,c1,c1_);