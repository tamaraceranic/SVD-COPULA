% The program finds the level of dependence,  copula parameter "theta" which is in
% in this program is denoted by COP.

function COP = copula_parametri_delF(x1,x2)

% inputs: x1 and x2-1D time series, 
% output: COP-copula parameter "theta" 

u1 = ksdensity(x1,x1,'function','cdf');
u2 = ksdensity(x2,x2,'function','cdf');


[n1,n2] = size(u1);
N1 = max(n1,n2);
[n1,n2] = size(u2);
N2 = max(n1,n2);
N = min(N1,N2);


for i = 1:N
    U12(i,1) = u1(i);
    U12(i,2) = u2(i);
end



 par = copulafit( 'Frank',U12); 


COP = par; 
clear u1;
clear u2;
clear x1;
clear x2;
clear U12;