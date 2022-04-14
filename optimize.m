
x0 = [17 1 3]; %beta, kappa, turbidity
% log intensity domain - [4 0 6] -> problem..
% intensity domain - []

% set boundary
lb = [0 0 1];
ub = [];

% constraint
% each RGB value must be positive

[x, fval] = fmincon('objectiveFun',x0,[],[],[],[],lb,ub)
