clear;clc;
R = 100;
offset = 3.8;
val = 500;
x1 = [ones(1,R);(randn(1,R) + offset);(randn(1,R) + offset)];
x2 = [ones(1,R);(randn(1,R) - offset);(randn(1,R) + offset)];
x3 = [ones(1,R);(randn(1,R) + offset);(randn(1,R) - offset)];
x4 = [ones(1,R);(randn(1,R) - offset);(randn(1,R) - offset)];
d1 = [1;0;0;0];
d2 = [0;1;0;0];
d3 = [0;0;1;0];
d4 = [0;0;0;1];
T = [x1,x2,x3,x4];
d = [[ones(1,R),zeros(1,3*R)];[zeros(1,R),ones(1,R),zeros(1,2*R)];[zeros(1,2*R),ones(1,R),zeros(1,R)];[zeros(1,3*R),ones(1,R)]];
N = length(T);
m = 2;
n = 4;
eta = 0.1;
bl = 0;
x = (-8:0.01:8);
w = rand(m+1,n);
c = [[ones(R,1),zeros(R,2)];[zeros(R,1),ones(R,1),zeros(R,1)];[zeros(R,2),ones(R,1)];(zeros(R,3))];
while 1
    s = w;
    bl = bl+1;
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
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNED TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    else
        if(bl == val)
            disp ("THE NETWORK HAS LEARNED TO PARTIALLY CLASSIFY THE GIVEN INPUTS!!");
            break;
        end
    end
end
subplot(2,2,1);
scatter(T(2,:),T(3,:),10,c,'filled');
axis([-8,8,-8,8]);
grid on;
subplot(2,2,2);
scatter(T(2,:),T(3,:),10,c,'filled');
hold on;
plot(x,(-w(2,1)/w(3,1)).*x + (-w(1,1)/w(3,1)),'r');
plot(x,(-w(2,2)/w(3,2)).*x + (-w(1,2)/w(3,2)),'g');
plot(x,(-w(2,3)/w(3,3)).*x + (-w(1,3)/w(3,3)),'b');
plot(x,(-w(2,4)/w(3,4)).*x + (-w(1,4)/w(3,4)),'k');
grid on;
axis([-8,8,-8,8]);
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
            inter = [inter,[x(pos);line(i,pos)]]; %#ok<AGROW>
        end
    end
end
inter(:,end+1) = [0;0];
i = 1;
while(i<6)
    if((abs(inter(1,i))> offset && abs(inter(2,i))>offset))
        inter = [inter(:,1:i-1),inter(:,i+1:end)];
        i = i-1;
    end
    i = i+1;
end
inter = inter(:,2:end-1);
p1 = inter(:,1);
p2 = inter(:,2);
p3 = inter(:,3);
p4 = inter(:,4);
x1 = -8:8;
l1 = polyfit([p2(1),p3(1)],[p2(2),p3(2)],1);
l2 = polyfit([p1(1),p4(1)],[p1(2),p4(2)],1);
ny1 = l1(1).*x1 + l1(2);
ny2 = l2(1).*x1 + l2(2);
subplot(2,2,4);
scatter(T(2,:),T(3,:),10,c,'filled');
hold on;
plot(x1,ny1,'m');
plot(x1,ny2,'m');
grid on;
axis([-8,8,-8,8]);
hold off;
subplot(2,2,3);
scatter(T(2,:),T(3,:),10,c,'filled');
hold on;
plot(x1,ny1,'m');
plot(x1,ny2,'m');
plot(x1,(-w(2,1)/w(3,1)).*x1 + (-w(1,1)/w(3,1)),'r');
plot(x1,(-w(2,2)/w(3,2)).*x1 + (-w(1,2)/w(3,2)),'g');
plot(x1,(-w(2,3)/w(3,3)).*x1 + (-w(1,3)/w(3,3)),'b');
plot(x1,(-w(2,4)/w(3,4)).*x1 + (-w(1,4)/w(3,4)),'k');
grid on;
axis([-8,8,-8,8]);
hold off;