function GA
    addpath(genpath('./FunctionsToMinimize'))
    
    Rosenbrock('graphical')

    ObjectiveFunction = Rosenbrock('function');
    nvars = 2;    % Number of variables
    LB = [0 0];   % Lower bound
    UB = [1 13];  % Upper bound
    ConstraintFunction = @simple_constraint;
    
    options = optimoptions(@ga,'MutationFcn',@mutationadaptfeasible);
    options = optimoptions(options,'PlotFcn',{@gaplotbestf,@gaplotmaxconstr}, 'Display','iter');
    
    X0 = [0.5 0.5]; % Start point
    options.InitialPopulationMatrix = X0;
    
    % Next we run the ga solver.
    [x,fval] = ga(ObjectiveFunction,nvars,[],[],[],[],LB,UB, ConstraintFunction,options)
    disp(x)
    disp(fval)
end

function [c, ceq] = simple_constraint(x)
    c = [1.5 + x(1)*x(2) + x(1) - x(2);
    -x(1)*x(2) + 10];
    ceq = [];
end