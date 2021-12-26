clc
clear all
close all

%%%%%%%%%
global Z
global N
global c
global n_pg
global r
global b
global pi_t
global pi_f
global n_p
global mu
global belta
global s
global maxLen
global len
global normal
global alpha
global executor_threshold
global M
global LOCAL_SCHEME

%%%%%parameter
LOCAL_SCHEME = 1 % 1 -> local scheme applied, 0 -> global scheme applied
Z = 100;
N = 4;
mu = 1/Z;
belta = 5;
s = 2;%s+1=3
maxLen =Z+1;
b = 1;
c = 0.1;
n_p = 25;%global
pi_t = 0.03;
pi_f = 0.3; % pi_e in the article
r = 0.2; %risk
alpha = 1;
executor_threshold = 0.25; % n_e = executor_threshold * N
M = 0.75*N;
%%%%%%%
len = (Z+1) * (Z+2) /2;
normal = nchoosek(Z-1, N-1);


state_matrix = generateStateMatrix();
stationary_distribution = getStationaryDistribution(state_matrix);
