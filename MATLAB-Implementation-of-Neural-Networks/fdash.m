function y = fdash(x)
    y = sigmf(x,[1,0]).*(1 - sigmf(x,[1,0]));
end