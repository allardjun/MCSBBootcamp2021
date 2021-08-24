% Jun Allard jun.allard@uci.edu
% Compute the Julia Set
% for z0, does the mapping z(n+1)=z(n)^2+c, z(0)=z0 go to infinity or
% remain finite? If it goes to infinity, we define z0 as in the Julia set. 
% https://en.wikipedia.org/wiki/Julia_set

%% Plot

load('juliaSet.mat');

juliaSet = exitTime<ntMax; % Julia set is defined as z0 values that mapped to infinity (here defined as abs(z)>2).

% plot black and white
figure(1); clf; hold on; box on;
plot(real(z0(juliaSet)), imag(z0(juliaSet)), '.k');

%%

% plot coloring according to exit number
figure(2); clf; hold on; box on;
scatter(real(z0(juliaSet)), imag(z0(juliaSet)), 10, exitTime(juliaSet));
colormap(cool);    

% plot coloring according to exit number
figure(2); clf; hold on; box on;
scatter(x0(juliaSet), x0(juliaSet), 10, exitTime(juliaSet));
colormap(cool); 