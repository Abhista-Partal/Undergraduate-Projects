clear;clc;
x = -5:0.1:5;
y = [-5:0.1:5].';
mean = [0,0];
sigma = 2;
z = exp(-((((x-mean(1)).^2)+((y-mean(2)).^2))/(2*((sigma).^2))));
surf(x,y,z);