clear all;clc;
R = 120;
offset = 2.5;
x1 = [ones(1,R);[randn(1,R) + offset];[randn(1,R) + offset]];
x2 = [ones(1,R);[randn(1,R) - offset];[randn(1,R) + offset]];
x3 = [ones(1,R);[randn(1,R) + offset];[randn(1,R) - offset]];
x4 = [ones(1,R);[randn(1,R) - offset];[randn(1,R) - offset]];
d1 = [1;0;0;0];
d2 = [0;1;0;0];
d3 = [0;0;1;0];
d4 = [0;0;0;1];
T = [x1,x2,x3,x4];
d = zeros(4,(R*4));
j = 1:R
d(1,:) = (j<=R/4);
d(2,:) = (j>R/4) & (j<=R/2);
d(3,:) = (j>R/2) & (j<=3*R/4);
d(4,:) = (j>3*R/4) & (j<=R);
N = length(T);
m = 2;
n = 4;
eta = 0.5;
N = length(T);
x = [-3:0.1:3];
w = rand(m+1,n);
%{
scatter([x1(2,:),x2(2,:),x3(2,:),x4(2,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],50,c,'filled');
hold on;
plot(x,(-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1)));
plot(x,(-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2)));
plot(x,(-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3)));
plot(x,(-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4)));
hold off;
%}
while 1
    s = w;
    for i = 1:N
        in = T(:,i);
        net = w.'*in;
        for j = 1:n
            if (net(j) >= 0)
                net(j) = 1;
            else
                net(j) = 0;
            end
            if (net(j) == d(j,i))
                w(:,j) = w(:,j);
            else
                if((d(j,i) - net(j)) >= 0)
                    w(:,j) = w(:,j) + eta.*in;
                else
                    w(:,j) = w(:,j) - eta.*in;
                end
            end
        end
        %{
        %shows the animation of the plot while the preceptron finds the best solution
        scatter([x1(2,:),x2(2,:),x3(2,:),x4(2,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],50,c,'filled');
        hold on;
        plot(x,(-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1)));
        plot(x,(-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2)));
        plot(x,(-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3)));
        plot(x,(-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4)));
        hold off;
        pause(0.1);
        %}
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNED TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end
subplot(2,2,1);
plot(A(1,:),A(2,:),'bs');hold on;grid on;
plot(B(1,:),B(2,:),'r+');
plot(C(1,:),C(2,:),'go');
plot(D(1,:),D(2,:),'m*');
legend('Class 1','Class 2','Class 3','Class 4');
axis([-2,4,-3,3]);
subplot(2,2,2);
plot(A(1,:),A(2,:),'bs');hold on;grid on;
plot(B(1,:),B(2,:),'r+');
plot(C(1,:),C(2,:),'go');
plot(D(1,:),D(2,:),'m*');
plot(x,(-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1)),'g');
plot(x,(-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2)),'b');
plot(x,(-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3)),'k');
plot(x,(-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4)),'r');
grid on;
axis([-2,4,-3,3]);
legend('Class 1','Class 2','Class 3','Class 4','Decision Boundary 1','Decision Boundary 2','Decision Boundary 3','Decision Boundary 4');
hold off;
y1 = (-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1));
y2 = (-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2));
y3 = (-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3));
y4 = (-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4));
line = [y1;y2;y3;y4];
inter = zeros(2,1);
for i = 1:3
    for j = (i+1):4
        [mini,pos] = min(abs(line(i,:)-line(j,:)));
        if (mini < 0.15)
            inter = [inter,[x(pos);line(i,pos)]];
        end
    end
end
inter = inter(:,2:end);
p1 = inter(:,1);
p2 = inter(:,2);
p3 = inter(:,3);
p4 = inter(:,4);
x = -3:3;
l1 = polyfit([p2(1),p3(1)],[p2(2),p3(2)],1);
l2 = polyfit([p1(1),p4(1)],[p1(2),p4(2)],1);
ny1 = l1(1).*x + l1(2);
ny2 = l2(1).*x + l2(2);
subplot(2,2,4);
plot(A(1,:),A(2,:),'bs');hold on;grid on;
plot(B(1,:),B(2,:),'r+');
plot(C(1,:),C(2,:),'go');
plot(D(1,:),D(2,:),'m*');
legend('Class 1','Class 2','Class 3','Class 4','New Boundary 1','New Boundary 2');
axis([-2,4,-3,3]);
hold off;
subplot(2,2,3);
plot(A(1,:),A(2,:),'bs');hold on;grid on;
plot(B(1,:),B(2,:),'r+');
plot(C(1,:),C(2,:),'go');
plot(D(1,:),D(2,:),'m*');
plot(x,(-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1)),'g');
plot(x,(-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2)),'b');
plot(x,(-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3)),'k');
plot(x,(-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4)),'r');
grid on;
plot(x,ny1,'y');
plot(x,ny2,'c');
axis([-2,4,-3,3]);
legend('Class 1','Class 2','Class 3','Class 4','Decision Boundary 1','Decision Boundary 2','Decision Boundary 3','Decision Boundary 4','New Boundary');
hold off;