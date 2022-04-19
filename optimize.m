
x0 = [6 0 2]; %beta, kappa, turbidity

% set boundary
lb = [0 0 2];
ub = [inf inf 30];

% constraint
% each RGB value must be positive??
% options = optimoptions('fmincon');
% options.StepTolerance = 1e-10;

[x, fval, ~, output] = fmincon('objectiveFun',x0,[],[],[],[],lb,ub)

