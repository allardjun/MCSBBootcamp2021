% Jun Allard jun.allard@uci.edu
% Compute the Julia Set
% for z0, does the mapping z(n+1)=z(n)^2+c, z(0)=z0 go to infinity or
% remain finite? If it goes to infinity, we define z0 as in the Julia set. 
% https://en.wikipedia.org/wiki/Julia_set

% Algorithm choices: 
% (1) This code uses variables that are complex number. One
% could alternatively use just real numbers, and represent complex numbers
% as a pair of real numbers.
% (2) We explore z0 values randomly uniformly in a rectangular range. We could
% alternatively explore z0 values in a grid.

% Model parameter
c = -0.8 + 0.156*1i;

% Algorithm parameters
NStartingPoints = 1e5; % number of point on the complex plane to sample
ntMax = 22; % max time iteration. If escape has not happened by ntMax, the point is defined as not in the Julia set.

% random starting points z0, uniform in a rectangular region of the complex
% plane
z0ReMin = -2;
z0ReMax = +2;
z0ImMin = -2;
z0ImMax = +2;

z0 = z0ReMin + (z0ReMax-z0ReMin)*rand(1,NStartingPoints) + ...
     (z0ImMin + (z0ImMax-z0ImMin)*rand(1,NStartingPoints))*1i;

% initialize a vector to store the escape timestep (or ntMax, if it never
% escaped)
exitTime = 0*z0; 
 
tic;
for iStartingPoint=1:NStartingPoints

    % initial condition
    z = z0(iStartingPoint);

    % time loop!
    nt=0;
    while (nt<ntMax && abs(z)<2)
    
        z = z.^2 + c;
        
        nt=nt+1;
    
    end % finished timestep loop
    
    exitTime(iStartingPoint) = nt;

end % finished loop through starting points
toc

% Save to file
save('juliaSet.mat', 'z0', 'exitTime');


