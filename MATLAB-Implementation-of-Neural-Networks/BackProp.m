%Program to classify 2 class with a unit circle as the decision boundary
clear;clc;
%Generate the required points
c = randn([2,300]);
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
brk = 2000;
m = 2;
h = 6;
n = 1;
eta = 0.1;
w1 = randn(m+1,h);
w2 = randn(h+1,n);
run = 0;
%Code to run the backpropagation algorithm
while(1)
    if(run == brk)
        break;
    end
    for i = 1:length(x)
        net1 = w1.'*x(:,i);
        z1 = sigmf(net1,[1,0]);
        z = [1;z1];
        net2 = w2.'*z;
        y = sigmf(net2,[1,0]);
        ek = d(i)-y;
        w = w2 + (eta*(ek.*fdash(net2)*z.').');
        w1 = w1 + (eta*(w2(2:end,:)*ek.*fdash(net1).*fdash(net2)*x(:,i).').');
        w2 = w;
    end
    run = run + 1;
end
%Plot the graph with 2 classes
plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r');
hold on;
plot(c2(1,:),c2(2,:),'gd','MarkerFaceColor','g');
l1 = -4:4;
for i = 1:h
    l2 = ((-w1(2,i)/w1(3,i)).*l1 + (-w1(1,i)/w1(3,i)));
    plot(l1,l2,'k-.');
end
%Plots a unit circle for referance
viscircles([0,0],1,'color','b');
axis([-4,4,-4,4]);
hold off;
grid on;
%Find the accuracy of the network
correct = 0;
for i = 1:length(x)
    net1 = w1.'*x(:,i);
    z1 = sigmf(net1,[1,0]);
    z = [1;z1];
    net2 = w2.'*z;
    y = sigmf(net2,[1,0]);                  %Network output
    if(heaviside(y-0.5) == d(i))
        correct = correct + 1;              %Number of correct predictions
    end
end
acc = (correct/length(c))*100;

%Function definition of the diffrentiation of sigmoid function
function y = fdash(x)
    y = sigmf(x,[1,0]).*(1 - sigmf(x,[1,0]));
end