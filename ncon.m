function [c,ceq] = ncon(x)
%The ncon function is used for Matlab function: fmincon, which determine
%the relation between free parameters of a cost function to be optimized.
c = [];
ceq = x(5)^2 + x(6)^2 - 1;%right angle constraint
end