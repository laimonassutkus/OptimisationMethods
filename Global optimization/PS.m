% Particle Swarm
function [x,fval] = PS(func)
    addpath(genpath('./FunctionsToMinimize'))

    if isempty(func)
        figure(1); hold on; grid on;
        Easom('graphical')
        fun = Easom('function')
    else
        fun = func;
    end

    lb = [-10,-15];
    ub = [15,20];
    
    if isempty(func)
        options = optimoptions(@particleswarm,'SwarmSize',100,'HybridFcn',@fmincon);
    else
        options = optimoptions(@particleswarm, 'display','off');
    end
        
    nvars = 2;
    [x,fval] = particleswarm(fun,nvars,lb,ub, options);

    if isempty(func)
       disp(x)
       disp(fval)
       figure(1)
       plot3(x(1), x(2), fval, 'ro', 'LineWidth', 6);
    end
end