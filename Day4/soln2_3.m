% ------------------------------------------------------
A     = 1.1; % fluorescence intensity units
omega = 2.6; % rad/s
A_0   = 0.01;

u=@(t) A*sin(omega*t)+A_0;

tArray = linspace(0,1.6,200);
uArray = u(tArray); % an array of samples of u
% ------------------------------------------------------

% analytical solutions (in real life, we might not know these)
dudtExact      =  A*omega*cos(omega*tArray);
du2dt2Exact    = -A*omega^2*sin(omega*tArray);
du3dt3Exact    = -A*omega^3*cos(omega*tArray);

noiseMagnitudeArray = [10.^(-1:-1:-14) 0];

figure(2);clf; hold on; box on;
set(gca,'xscale','log','yscale','log')

for noiseMagnitude = noiseMagnitudeArray
    
    % Take the sample and add a bit of noise
    uObserved = u(tArray) + noiseMagnitude*randn(size(tArray));
    
    % create finite-difference derivatives for first derivative, second derivative and third derivative
    dudt   = diff(uObserved)./diff(tArray);
    du2dt2 = diff(dudt)./diff(tArray(1:end-1));
    du3dt3 = diff(du2dt2)./diff(tArray(1:end-2));
    
    relativeError = max(abs(du3dt3-du3dt3Exact(1:end-3)))/max(uObserved);
    
    figure(2); 
    plot(noiseMagnitude,relativeError,'+');
    
    if 0 % convenient way to comment-out a block of code
        % and plot them
        figure;
        subplot(3,1,1); hold on;
        plot(tArray(1:end-1), dudt);
        plot(tArray, dudtExact, '-r');
        xlabel('t');
        ylabel('dudt');
        
        subplot(3,1,2); hold on;
        plot(tArray(1:end-2), du2dt2);
        plot(tArray, du2dt2Exact, '-r');
        xlabel('t');
        ylabel('du2dt2')
        
        subplot(3,1,3); hold on;
        plot(tArray(1:end-3), du3dt3);
        plot(tArray, du3dt3Exact, '-r');
        xlabel('t');
        ylabel('du3dt3')
    end
    
end % finished loop through noiseMagnitude