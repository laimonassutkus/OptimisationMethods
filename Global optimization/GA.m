% Genetic Algorithm
function [x,fval] = GA(func)
    addpath(genpath('./FunctionsToMinimize'))
    
    if isempty(func)
        figure(1); hold on; grid on;
        Ackley('graphical')
        ObjectiveFunction = Ackley('function');
    else
        ObjectiveFunction = func;
    end
    
    nvars = 2;    % Number of variables
    LB = [0 0];   % Lower bound
    UB = [1 13];  % Upper bound
    ConstraintFunction = [];
    
    if isempty(func)
        options = optimoptions(@ga,'MutationFcn',@mutationadaptfeasible);
        options = optimoptions(options,'PlotFcn',{@gaplotbestf}, 'Display','iter');
    else
        options = optimoptions(@ga, 'display','off');
    end
    
    X0 = [0.5 0.5]; % Start point
    options.InitialPopulationMatrix = X0;
    
    % Next we run the ga solver.
    [x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ConstraintFunction,options);
    
    if isempty(func)
        disp(x)
        disp(fval)
        figure(1)
        plot3(x(1), x(2), fval, 'ro', 'LineWidth', 6);
    end
end

