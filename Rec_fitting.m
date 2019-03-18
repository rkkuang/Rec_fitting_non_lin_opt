function rec_para = Rec_fitting(X,Y,para0,plotflag,imgL,imgW)
%The Rec_fitting() function computes the five paremeters of Xc,Yx,L,W,alpha
%of a fitted rectangle from the position information of a set of points in
%the edge of the rectangle.
%   input: 
%   X,Y: The position of points in the edge of the rectangle, colum vector
%   para0: The initial estimated parameters
%   plotflag: determine whether plot the fitting results or not; 1:plot,0:otherwise 
%   output: 
%        rec_para: the result paremeter vector of the rectangle: (Xc,Yc,alpha,L,W)
% Version: 1.0 2018.09.03 by rkkuang

x0 = LW2cn(para0);
x0 = x0';

fun = @cost_func;
nonlcon = @ncon;

options = optimoptions('fmincon','Display','off','Algorithm','sqp');
% To observe the fmincon solution process, set the Display option to 'iter'. Also, try the 'sqp' algorithm, 
% which is sometimes faster or more accurate than the default 
% 'interior-point' algorithm.

tic
[minx,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)fun(x,X,Y),x0,[],[],[],[],...
    [],[],nonlcon,options);
toc

rec_para = cn2LW(minx);

if plotflag == 1
plot_fitted_rec(rec_para,imgL,imgW);
hold on;
plot(X,Y,'b.');
end
end