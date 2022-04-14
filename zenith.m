kai = (4/9 - t/120)*(pi - 2*thetaSun);
Yz = (4.0453*t - 4.9710)*tan(kai) - 0.2155*t + 2.4192; % zenith luminance

theta = [thetaSun^3 thetaSun^2 thetaSun 1];
xz = [t^2 t 1] * [0.0017 -0.0037 0.0021 0.000; -0.0290 0.0638 -0.0320 0.0039; 0.1169 -0.2120 0.0605 0.2589]*theta';
yz = [t^2 t 1] * [0.0028 -0.0061 0.0032 0.000; -0.0421 0.0897 -0.0415 0.0052; 0.1535 -0.2676 0.0667 0.2669]*theta';