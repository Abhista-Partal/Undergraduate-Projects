x1 = [1;1;0;0];
x2 = [1;1;0;1];
x3 = [1;1;1;0];
x4 = [1;1;1;1];
x5 = [1;0;0;0];
x6 = [1;0;0;1];
x7 = [1;0;1;0];
x8 = [1;0;1;1];
c0 = [x1,x2,x3,x4];
c1 = [x5,x6,x7,x8];
T = [(c0.*-1),(c1.*1)];
N = length(T);
eta = 0.05;
m = 3;
n = 1;
co1 = [0.7962,0.0987,0.2619];
co2 = [0.3354,0.6797,0.1366];
w = rand(m+1,n);
[x y] = meshgrid(-2:2);
scatter3([x1(2);x2(2);x3(2);x4(2);x5(2);x6(2);x7(2);x8(2)],[x1(3);x2(3);x3(3);x4(3);x5(3);x6(3);x7(3);x8(3)],[x1(4);x2(4);x3(4);x4(4);x5(4);x6(4);x7(4);x8(4)],50,[co1;co1;co1;co1;co2;co2;co2;co2],'filled');
hold on;
surf(x,y,(-w(2)/w(4)).*x + (-w(3)/w(4)).*y - (w(1)/w(4)));
hold off;
while 1
    s = w;
    for j = 1:N
        in = T(:,j);
        net = w.'*in;
        if (net < 0)
            w = w + eta.*in;
        end
    scatter3([x1(2);x2(2);x3(2);x4(2);x5(2);x6(2);x7(2);x8(2)],[x1(3);x2(3);x3(3);x4(3);x5(3);x6(3);x7(3);x8(3)],[x1(4);x2(4);x3(4);x4(4);x5(4);x6(4);x7(4);x8(4)],50,[co1;co1;co1;co1;co2;co2;co2;co2],'filled');
    hold on;
    surf(x,y,(-w(2)/w(4)).*x + (-w(3)/w(4)).*y - (w(1)/w(4)));
    pause(0.1);
    hold off;
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNT TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end