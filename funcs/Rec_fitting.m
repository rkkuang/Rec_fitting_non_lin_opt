function rec_para = Rec_fitting(X,Y,para0,plotflag,imgL,imgW,L0coe)
%The Rec_fitting() function computes the five paremeters of Xc,Yx,L,W,alpha
%of a fitted rectangle from the position information of a set of points in
%the edge of the rectangle.
%   input: 
%   X,Y: The position of points in the edge of the rectangle, colum vector
%   para0: The initial estimated parameters
%   plotflag: determine whether plot the fitting results or not; 1:plot,0:otherwise 
%   LOcoe: control the estimation of sigma0, L0coe=1 for simulation,
%   L0coe~2 for processing real life image
%   output: 
%        rec_para: the result paremeter vector of the rectangle: (Xc,Yc,alpha,L,W)
% Version: 1.0 2018.09.03 by rkkuang
options = optimoptions('fmincon','Display','off','Algorithm','sqp');
para0(4) = para0(4)+1;
if mod(para0(5),90)<0.05 || isnan(para0(5))
%para0(5) = 0;
%rec_para = para0;% not simply get result like this, but construct another cost function.
disp('angle euq 0');
fun = @cost_func4ang0;
[minx,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)fun(x,X,Y),para0,[],[],[],[],...
    [],[],[],options);
rec_para = minx;
para2 = rec_para;
para2(4) = para2(4)+1;
[minx2,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)fun(x,X,Y),para2,[],[],[],[],...
    [],[],[],options);
rec_para = minx2;


else
x0 = LW2cn(para0);

L0 = estimate_L(x0,X,Y);
L0 = sqrt(2*L0)/L0coe;
% L0 = sqrt(2*L0)/2 in experimental 
% L0 = sqrt(2*L0) in simulation

x0 = x0';
fun = @cost_func;
nonlcon = @ncon;
% To observe the fmincon solution process, set the Display option to 'iter'. Also, try the 'sqp' algorithm, 
% which is sometimes faster or more accurate than the default 
% 'interior-point' algorithm.
tic
[minx,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)fun(x,X,Y,L0),x0,[],[],[],[],...
    [],[],nonlcon,options);
toc
rec_para = cn2LW(minx);

% second search/optimize
% para2 = rec_para;
% para2(3:4) = para2(3:4)+2;
% x2 = LW2cn(para2);
% x2 = x2';
% [minx2,fval,exitflag,output,lambda,grad,hessian] = fmincon(@(x)fun(x,X,Y),x2,[],[],[],[],...
%     [],[],nonlcon,options);
% rec_para = cn2LW(minx2);

end

%L>=W
if plotflag == 1
plot_fitted_rec(rec_para,imgL,imgW);
hold on;
scatter(X,Y,'k.');
end
L = max(rec_para(3),rec_para(4));
W = min(rec_para(3),rec_para(4));
rec_para(5) = -rec_para(5);
rec_para(3) = L;
rec_para(4) = W;
rec_para(2) = imgW - rec_para(2);
end