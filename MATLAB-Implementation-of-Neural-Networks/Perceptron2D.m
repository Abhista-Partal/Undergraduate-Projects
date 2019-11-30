x1 = [1;1;1.5];
x2 = [1;2;0.5];
x3 = [1;0;0];
x4 = [1;1;-0.5];
c0 = [x1,x2];
c1 = [x3,x4];
T = [(c0.*-1),(c1.*1)];
N = length(T);
eta = 0.05;
m = 2;
n = 1;
co1 = [0.7962,0.0987,0.2619];
co2 = [0.3354,0.6797,0.1366];
w = rand(m+1,n);
z = [-3:3];
scatter([x1(2);x2(2);x3(2);x4(2)],[x1(3);x2(3);x3(3);x4(3)],50,[co1;co1;co2;co2],'filled');
hold on;
plot(z,(-w(2)/w(3)).*z + (-w(1)/w(3)));
hold off;
while 1
    s = w;
    for j = 1:N
        x = T(:,j);
        net = w.'*x;
        if (net < 0)
            w = w + eta.*x;
        end
    scatter([x1(2);x2(2);x3(2);x4(2)],[x1(3);x2(3);x3(3);x4(3)],50,[co1;co1;co2;co2],'filled');
    hold on;
    plot(z,(-w(2)/w(3)).*z + (-w(1)/w(3)));
    pause(0.1);
    hold off;
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNT TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end