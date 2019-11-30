c0 = [0,0.17,0.33,0.5];
c1 = [0.67,0.83,1];
T = [(c0.*-1),(c1.*1)];
N = length(T);
eta = 0.1;
m = 1;
n = 1;
w = rand(m+1,n);
stem(c0,zeros(length(c0),1),'filled');
hold on;
stem(c1,zeros(length(c1),1),'filled');
stem((-w(1)/w(2)),0);
hold off;
while 1
    s = w;
    for j = 1:N
        if(T(j) > 0)
            x = [1;T(j)];
        else
            x = [-1;T(j)];
        end
        net = w.'*x;
        if (net < 0)
            w = w + eta.*x;
        end
        stem(c0,zeros(length(c0),1),'filled');
        hold on;
        stem(c1,zeros(length(c1),1),'filled');
        stem((-w(1)/w(2)),0,'filled');
        pause(0.1);
        hold off;
    end
    if (s == w)
        disp ("THE NETWORK HAS LEARNT TO CLASSIFY THE GIVEN INPUTS!!");
        break;
    end
end