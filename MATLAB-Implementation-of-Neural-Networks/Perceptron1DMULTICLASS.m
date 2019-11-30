c0 = [0.1,0.2,0.3];
c1 = [0.4,0.5,0.6];
c2 = [0.7,0.8,0.9];
c3 = [1,1.1,1.2,1.3];
d0 = [1;0;0;0];
d1 = [0;1;0;0];
d2 = [0;0;1;0];
d3 = [0;0;0;1];
lc0 = length(c0);
lc1 = length(c1);
lc2 = length(c2);
lc3 = length(c3);
m = 1;
n = 4;
eta = 0.1;
w = rand(m+1,n);
T = zeros(2,(lc0 + lc1 + lc2 + lc3));
d = zeros(n,(lc0 + lc1 + lc2 + lc3));
for m = 1:lc0
    T(:,m) = [1;c0(m)];
    d(:,m) = [d0];
end
for m = 1:lc1
    T(:,(m + lc0)) = [1;c1(m)];
    d(:,(m + lc0)) = [d1];
end
for m = 1:lc2
    T(:,(m + lc0 + lc1)) = [1;c2(m)];
    d(:,(m + lc0 + lc1)) = [d2];
end
for m = 1:lc3
    T(:,(m + lc0 + lc1 + lc2)) = [1;c3(m)];
    d(:,(m + lc0 + lc1 + lc2)) = [d3];
end
N = length(T);
stem(c0,zeros(1,lc0),'filled');
hold on;
stem(c1,zeros(1,lc1),'filled');
stem(c2,zeros(1,lc2),'filled');
stem(c3,zeros(1,lc3),'filled');
stem((-w(1,1)/w(2,1)),0);
stem((-w(1,2)/w(2,2)),0);
stem((-w(1,3)/w(2,3)),0);
stem((-w(1,4)/w(2,4)),0);
hold off;
while 1
    s = w;
    for i = 1:N
        x = T(:,i);
        net = w.'*x;
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
                    w(:,j) = w(:,j) + eta.*x;
                else
                    w(:,j) = w(:,j) - eta.*x;
                end
            end
        end
        w
        stem(c0,zeros(1,lc0),'filled');
        hold on;
        stem(c1,zeros(1,lc1),'filled');
        stem(c2,zeros(1,lc2),'filled');
        stem(c3,zeros(1,lc3),'filled');
        stem((-w(1,1)/w(2,1)),0);
        stem((-w(1,2)/w(2,2)),0);
        stem((-w(1,3)/w(2,3)),0);
        stem((-w(1,4)/w(2,4)),0);
        hold off;
        pause(0.1);
    end    
    if(s == w)
        disp ("THE NETWORK HAS LEARNT TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end