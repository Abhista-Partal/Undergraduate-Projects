clear all;clc;
x1 = [[1;-2;2;1],[1;-3;2;1],[1;-2;1;1],[1;-1;1;1]];
x2 = [[1;2;-2;1],[1;3;-1;1],[1;1;-3;1],[1;2;-4;1]];
x3 = [[1;2;2;1],[1;3;2;1],[1;2;3;1],[1;3;3;1]];
x4 = [[1;-2;-2;1],[1;-3;-2;1],[1;-2;-1;1],[1;-1;-4;1]];
d1 = [1;0;0;0];
d2 = [0;1;0;0];
d3 = [0;0;1;0];
d4 = [0;0;0;1];
T = [x1,x2,x3,x4];
d = [[d1,d1,d1,d1],[d2,d2,d2,d2],[d3,d3,d3,d3],[d4,d4,d4,d4]];
N = length(T);
m = 3;
n = 4;
eta = 0.5;
N = length(T);
w = rand(m+1,n);
[x y] = meshgrid(-4:4);
c = [[0,1,0];[0,1,0];[0,1,0];[0,1,0];[0,0,1];[0,0,1];[0,0,1];[0,0,1];[0,0,0];[0,0,0];[0,0,0];[0,0,0];[1,0,0];[1,0,0];[1,0,0];[1,0,0]];
surf(x,y,(-w(2,1)/w(4,1)).*x + (-w(3,1)/w(4,1)).*y - (w(1,1)/w(4,1)),'EdgeColor','yellow','Facecolor','green');
hold on;
surf(x,y,(-w(2,2)/w(4,2)).*x + (-w(3,2)/w(4,2)).*y - (w(1,2)/w(4,2)),'EdgeColor','yellow','Facecolor','blue');
surf(x,y,(-w(2,3)/w(4,3)).*x + (-w(3,3)/w(4,3)).*y - (w(1,3)/w(4,3)),'EdgeColor','yellow','Facecolor','black');
surf(x,y,(-w(2,4)/w(4,4)).*x + (-w(3,4)/w(4,4)).*y - (w(1,4)/w(4,4)),'EdgeColor','yellow','Facecolor','red');
alpha(0.2);
scatter3([x1(2,:),x2(2,:),x3(2,:),x4(2,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],50,c,'filled');
hold off;
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
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNED TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end
surf(x,y,(-w(2,1)/w(4,1)).*x + (-w(3,1)/w(4,1)).*y - (w(1,1)/w(4,1)),'EdgeColor','yellow','Facecolor','green');
hold on;
surf(x,y,(-w(2,2)/w(4,2)).*x + (-w(3,2)/w(4,2)).*y - (w(1,2)/w(4,2)),'EdgeColor','yellow','Facecolor','blue');
surf(x,y,(-w(2,3)/w(4,3)).*x + (-w(3,3)/w(4,3)).*y - (w(1,3)/w(4,3)),'EdgeColor','yellow','Facecolor','black');
surf(x,y,(-w(2,4)/w(4,4)).*x + (-w(3,4)/w(4,4)).*y - (w(1,4)/w(4,4)),'EdgeColor','yellow','Facecolor','red');
alpha(0.2);
scatter3([x1(2,:),x2(2,:),x3(2,:),x4(2,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],[x1(3,:),x2(3,:),x3(3,:),x4(3,:)],50,c,'filled');
hold off;