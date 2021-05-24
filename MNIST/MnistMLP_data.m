clear all
clc
%% Load Data and Visualizing
load mnist_all.mat 
% subplot(1,2,1);
% plot_original = MnistDataPlot(test3,32,1);
% shuffle_test = MnistShuffle(test3,length(test3));
% subplot(1,2,2);
% plot_shuffle = MnistDataPlot(shuffle_test,32,1);

%% Shuffle Train Data and Select some

train_shuffle0 = MnistShuffle(train0,1000,0);
train_shuffle1 = MnistShuffle(train1,1000,1);
train_shuffle2 = MnistShuffle(train2,1000,2);
train_shuffle3 = MnistShuffle(train3,1000,3);
train_shuffle4 = MnistShuffle(train4,1000,4);
train_shuffle5 = MnistShuffle(train5,1000,5);
train_shuffle6 = MnistShuffle(train6,1000,6);
train_shuffle7 = MnistShuffle(train7,1000,7);
train_shuffle8 = MnistShuffle(train8,1000,8);
train_shuffle9 = MnistShuffle(train9,1000,9);

train_total = [train_shuffle0; train_shuffle1; train_shuffle2; ...
               train_shuffle3; train_shuffle4; train_shuffle5; ...
               train_shuffle6; train_shuffle7; train_shuffle8; train_shuffle9;];
train_mine = MnistShuffle(train_total,length(train_total),11);

%% Shuffle Test Data and Select some
test_shuffle0 = MnistShuffle(test0,100,0);
test_shuffle1 = MnistShuffle(test1,100,1);
test_shuffle2 = MnistShuffle(test2,100,2);
test_shuffle3 = MnistShuffle(test3,100,3);
test_shuffle4 = MnistShuffle(test4,100,4);
test_shuffle5 = MnistShuffle(test5,100,5);
test_shuffle6 = MnistShuffle(test6,100,6);
test_shuffle7 = MnistShuffle(test7,100,7);
test_shuffle8 = MnistShuffle(test8,100,8);
test_shuffle9 = MnistShuffle(test9,100,9);

test_total = [test_shuffle0; test_shuffle1; test_shuffle2; ...
               test_shuffle3; test_shuffle4; test_shuffle5; ...
               test_shuffle6; test_shuffle7; test_shuffle8; test_shuffle9;];
test_mine = MnistShuffle(test_total,length(test_total),11);

