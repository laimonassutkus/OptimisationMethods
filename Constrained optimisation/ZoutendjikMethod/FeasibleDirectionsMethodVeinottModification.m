
function [minimum_point, time_elapsed] = FeasibleDirectionsMethodVeinottModification(X0, precision, debug_mode)   
    if debug_mode ~= DebugMode.NONE
        hold on; grid on; axis([-10 10 -10 10])
    end

    [X, Y] = meshgrid(-10:.1:10);
    
    Z = (X - 3) .^ 2 + (Y - 3) .^ 2;
    
    % Constraint 1: 0 >= 2 .* X - Y .^ 2 - 1;
    % Constraint 2: 0 >= 9 - 0.8 .* X .^ 2 - 2 .* Y;
    
    constraint1_x = (-Y.^2 -1) ./ -2;
    constraint2_y = (9 - 0.8 .* X .^ 2) ./ 2;
     
    if debug_mode == DebugMode.GRAPHS || debug_mode == DebugMode.ALL
        contour(X, Y, Z, 20, 'k');
        plot(X(1, :), constraint2_y(1, :), 'r'); 
        plot(constraint1_x(:, 1), Y(:, 1), 'r');
    end
      
    % Minimize theta: f = -1t + 0d1 + 0d2
    f = [-1; 0; 0];
    b = [0 0 1];
    lb = [-1; -1; -1];
    ub = [10; 1; 1];
    x = Inf;
    
    tic
    while eps <= x(1)
        constrGrad1 = derivConstrFun1(X0);
        constrGrad2 = derivConstrFun2(X0);
        objFunGrad = derivObjFun(X0);

        if getActiveConstr(X0) == 1
            A = [1 -constrGrad1(1) -constrGrad1(2); 1 objFunGrad(1) objFunGrad(2); 1 -constrGrad1(1) constrGrad1(2)];
        else
            A = [1 -constrGrad2(1) -constrGrad2(2); 1 objFunGrad(1) objFunGrad(2); 1 -constrGrad2(1) constrGrad2(2)];
        end

        x = linprog(f,A,b,[],[],lb,ub);
        feasDir = x(2:3) ./ norm(x(2:3));

        if debug_mode == DebugMode.ALL
            quiver(X0(1), X0(2), feasDir(1), feasDir(2), 0, 'k', 'MaxHeadSize', 1.5)
        end
        Xnext = specifyLimit(feasDir, X0, precision, 0.1, debug_mode);
        
       if max(abs(Xnext - X0)) <= precision
           break 
        end
        
        X0 = Xnext;
        
        if debug_mode == DebugMode.ALL || debug_mode == DebugMode.CLIMITS
            plot(X0(1), X0(2), 'ro')
        end
    end
    
    time_elapsed = toc;
    minimum_point = X0;
    
    if debug_mode ~= DebugMode.NONE
        legend('Function to minimize', 'Constraint 1', 'Constraint 2', 'Feasible direction')
    end
    clearvars -except A dmode minimum_point time_elapsed
end

function G = derivObjFun(X)
    G(1) = 2 .* (X(1) - 3);
    G(2) = 2 .* (X(2) - 3);
end

function value = constraint1(X)
    %Constraint 1: 0 >= 2 .* X - Y .^ 2 - 1;
    value = 2 .* X(1) - X(2) .^ 2 - 1;
end

function value = constraint2(X)
    % Constraint 2: 10 >= 9 - 0.8 .* X .^ 2 - 2 .* Y;
    value = 9 - 0.8 .* X(1) .^ 2 - 2 .* X(2);
end

function G = derivConstrFun1(X)
    G(1) = 2;
    G(2) = -2 .* X(2);
end

function G = derivConstrFun2(X)
    G(1) = -1.6 .* X(1);
    G(2) = -2;
end

function specifiedPoint = specifyLimit(directionVector, point, epsl, stepSizeMultiplier, debug_mode)
    if stepSizeMultiplier <= epsl
        specifiedPoint = point;
        return
    end
    
    next_point = point + directionVector(1:2)' .* stepSizeMultiplier;

    while constraint1(next_point) > 0 && constraint2(next_point) > 0
       next_point = next_point + directionVector(1:2)' * stepSizeMultiplier;
       if debug_mode == DebugMode.ALL
           plot(next_point(1), next_point(2), 'ro', 'MarkerSize', 2)
       end
    end
    next_point = next_point - directionVector(1:2)' * stepSizeMultiplier;
    specifiedPoint = specifyLimit(directionVector, next_point, epsl, stepSizeMultiplier / 10, debug_mode);
end

function index = getActiveConstr(point)
    if constraint1(point) < constraint2(point)
        index = 1;
    else
        index = 2;
    end
end



















