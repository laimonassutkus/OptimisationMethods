% Simulated Annealing Algorithm
function [x,fval] = SAA(func)
    addpath(genpath('./FunctionsToMinimize'))

    if isempty(func)
        figure(1); hold on; grid on;
        Levi13('graphical')
        ObjectiveFunction = Levi13('function');
    else
        ObjectiveFunction = func;
    end
    
    nvars = 2;    % Number of variables
    lb = [-64 -64];
    ub = [64 64];
    X0 = [-1 1];   % Starting point

    if isempty(func)
        options = optimoptions(@simulannealbnd,'PlotFcn',{@saplotbestf}, 'Display','iter');
    else
        options = optimoptions(@simulannealbnd, 'display','off');
    end

    [x,fval] = simulannealbnd(ObjectiveFunction,X0,lb,ub,options);

    if isempty(func)
        disp(x)
        disp(fval)
        fprintf('The number of iterations was : %d\n', output.iterations);
        fprintf('The number of function evaluations was : %d\n', output.funccount);
        fprintf('The best function value found was : %g\n', fval);

        figure(1)
        plot3(x(1), x(2), fval, 'ro', 'LineWidth', 6);
    end
end