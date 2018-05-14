clc
clear all
close all
warning off all

%% load the data

load n1
load n2
load n3
load n4
load n5

load b1
load b2
load b3
load b4
load b5

load r1
load r2
load r3
load r4
load r5

load ru1
load ru2
load ru3
load ru4

load s1
load s2
load s3
load s4
load s5

T = [n1,n2,n3,n4,n5,b1,b2,b3,b4,b5,r1,r2,r3,r4,r5,ru1,ru2,ru3,ru4,s1,s2,s3,s4,s5];
x = [0 0 0 0 0 1 1 1 1 1 2 2 2 2 2 3 3 3 3 4 4 4 4 4];

%% create a feed forward neural network

net1 = newff(minmax(T),[30 20 1],{'logsig','logsig','purelin'},'trainrp');
net1.trainParam.show = 1000;
net1.trainParam.lr = 0.04;
net1.trainParam.epochs = 7000;
net1.trainParam.goal = 1e-5;

%% Train the neural network using the input,target and the created network
[net1] = train(net1,T,x);

%% save the network
save net1 net1

%% simulate the network for a particular input
y = round(sim(net1,T))

