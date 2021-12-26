# Results

The figures in this directory have been computed with the code in the directory [octave](/octave).

## Opening a figure

To open a figure, in octave: `hgload(filename)`

## Used parameters

The default parameters that are used are the following (when the plot doesn't indicate other values):

```MATLAB
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
```