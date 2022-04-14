
function [skyparamY, skyparamx, skyparamy] = turbidityToSkyparam(t)
MY = [0.1787 -1.4630; -0.3554 0.4275; -0.0227 5.3251; 0.1206 -2.5771; -0.0670 0.3703];
Mx = [-0.0193 -0.2592; -0.0665 0.0008; -0.0004 0.2125; -0.0641 -0.8989; -0.0033 0.0452];
My = [-0.0167 -0.2608; -0.0950 0.0092; -0.0079 0.2102; -0.0441 -1.6537; -0.0109 0.0529];

T = [t 1];
AEY = MY * T';
AEx = Mx * T';
AEy = My * T';

skyparamY = AEY;
skyparamx = AEx;
skyparamy = AEy;

end
