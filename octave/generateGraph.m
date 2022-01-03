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
global FLEXIBLE_INCENTIVE
global enhancement_factor
global error
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
FLEXIBLE_INCENTIVE = 0 % 1 -> flexible incentives used
enhancement_factor = 3; % lowercase delta in the paper, must be greater than 1
normal = nchoosek(Z-1, N-1);


error = 0.1; % probability for a executor to apply the bad reward/punishment (punish a cooperator or reward a defector)

parameters = [0 0.5 1]; % For each parameter, 1 plot
legends = [];
for parameter = parameters
    alpha = parameter; % CHANGE the actual parameter
    if parameter >= 0
        local_legend = strcat("\\alpha =", num2str(parameter)); % CHANGE the format of the legend
    else
        local_legend = "No incentive";
        alpha = 1;
        pi_f = 0;
        pi_t = 0;
    end
    disp(local_legend);
    legends = [legends; local_legend]
    y = [];
    x = 0:0.05:0.5; % x value for the plot
    for var = x
        disp(strcat("var=", num2str(var)));
        error = var; % CHANGE for the actual paramater
        state_matrix = generateStateMatrix();
        stationary_distribution = getStationaryDistribution(state_matrix);

        y_val = averageGroupAchievment(stationary_distribution);
        y = [y y_val];
    end
    if parameter >= 0
        plot(x,y, "marker", "s");

    else
        plot(x,y,"color","k", "linestyle", "--");
    end
    hold on

    %stationary_distribution = getStationaryDistribution(state_matrix);
end

xlabel("Error rate, \\epsilon");
ylabel("Average group achivement, \\eta_G");

h=legend(legends, 'Location', 'northeast');
set(h, "fontsize", 15);
set(gca, "fontsize", 15);

hgsave("temp.ofig");