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
%%%%%parameters
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
normal = nchoosek(Z-1, N-1);

parameters = [0.5 0.2 0]; % For each parameter, 1 plot
legends = [];
for parameter = parameters
    r = parameter; % CHANGE the actual parameter
    local_legend = strcat("r=",num2str(r)); % CHANGE the format of the legend
    disp(local_legend);
    legends = [legends; local_legend]
    y = [];
    x = 0:0.1:1; % x value for the plot
    for var = x
        disp(strcat("var=", num2str(var)));
        alpha = var; % CHANGE for the actual paramater
        state_matrix = generateStateMatrix();
        stationary_distribution = getStationaryDistribution(state_matrix);

        y_val = institutionPrevalence(stationary_distribution);
        y = [y y_val];
    end
    plot(x,y, "marker", "s");
    hold on
    xlabel("Mixed coefficient, \\alpha");
    ylabel("Institution prevalence, \\eta_l");
    %stationary_distribution = getStationaryDistribution(state_matrix);
end

legend(legends, 'Location', 'southeast');
print out.tex -dtikz %generate tikz file
