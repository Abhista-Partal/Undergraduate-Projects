%Program to classify 2 class with a unit circle as the decision boundary
clear;clc;
%Generate the required points
c = randn([2,200]);
o = (c(1,:).^2+c(2,:).^2)<=1;
%Split the input into 2 classes
c1 = c(:,(o == 1));
c2 = c(:,(o == 0));
%Add bias to the inputs
x1 = [ones(1,size(c1,2)) ; c1]; 
x2 = [ones(1,size(c2,2)) ; c2];
x = [x1,x2];
%Initialize the desired output
d = [ones(size(x1,2),1);zeros(size(x2,2),1)];
%prerequisits
in = 2;         %input dimension
out = 1;        %number of classes(out = 1 for function approximation)
q = 1;          %number of RBF functions
mean = [0,0];   %mean of the respective gaussian functions
sigma = 0.8;    %spread of the respective gaussian functions
%Code to compute the weights of the RBF network
gaussx = exp(-((hypot(x(2,:),mean(1)).^2)/(2*(sigma.^2))));
gaussy = exp(-((hypot(x(3,:),mean(2)).^2)/(2*(sigma.^2))));
phi = [x(1,:).',(gaussx).',(gaussy).'];
w = ((((phi.'*phi)^-1)*phi.')*d);
%Plot the gaussian bell
a = -4:0.1:4;
b = (-4:0.1:4).';
[a,b] = meshgrid(-4:0.1:4);
z = exp(-((((a-mean(1)).^2)+((b-mean(2)).^2))/(2*((sigma).^2))));
surf(a,b,z);
alpha(0.6);
hold on;
%Plot the graph with 2 classes
plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r');
plot(c2(1,:),c2(2,:),'gd','MarkerFaceColor','g');
%Plots a unit circle for reference
viscircles(mean,1,'color','w');
hold off;
%Find the accuracy of the network
y = heaviside(phi*w-0.5);       %Network output
correct = sum(y == d);          %Number of correct predictions
acc = (correct/length(c))*100;