clear all;
close all;
clc;

%% Make phase plots

syms y x

%% 1-1
figure(1)
y = 4*x^2 - 16;

fplot(y, '-b', "LineWidth", 2)
hold on
yline(0, '--k', "LineWidth", 2)

xint = solve(y==0);
plot(xint, 0, '.k', 'MarkerSize', 25)

hold off

%% 1-2
figure(2)
y = x - x^3;

fplot(y, '-b', "LineWidth", 2)
hold on
yline(0, '--k', "LineWidth", 2)

xint = solve(y==0);
plot(xint, 0, '.k', 'MarkerSize', 25);

hold off;

%% 1-3
figure(3)
y = 1+1/2*cos(x);

fplot(y, '-b', "LineWidth", 2)
hold on;
yline(0, '--k', "LineWidth", 2);

xint = solve(y==0);
plot(xint, 0, '.k', "MarkerSize", 25);

hold off;

%% 1-4
figure(4)
y = exp(-x)*sin(x);

fplot(y, '-b', "LineWidth", 2);
hold on;
yline(0, '--k', "LineWidth", 2);

xint = solve(y==0);
plot(xint, 0, '.k', "MarkerSize", 25);

hold off;