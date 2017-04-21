% minimize - f(x) = exp(x(1)) * (4x(1) + 2x(2) + 4x(1) * x(2) + 2x(2) + 1)
% subject to 1.5 + x(1) * x(2) - x(1) - x(2) <= 0
%            -x(1) * x(2) <=0
function OptimisationWithFmincon
    hold on
    grid on
    axis ([-10 10 -10 10 -10 20])
    % initial guess
    x0 = [-2 0];

    options = optimset('LargeScale', 'off', 'Display', 'iter');

    % non-explicit constraints are replaced by []
    [x, fval, exitflag, output] = fmincon(@(x) objfun(x), x0, [], [], [], [], [], [], @(x) confun(x), options);
    
    disp('Exit flag: '); disp(exitflag)
    disp('Output: '); disp(output)
    disp('Function value: '); disp(fval)
    disp('XY values: '); disp(x)
    
    [X, Y] = meshgrid(-11:.5:11);
    % plot objfun
    Z = exp(X) .* (4 .* X .^ 2 + 2 .* Y .^ 2 + 4 .* X .* Y + 2 .* Y + 1);
    surf(X, Y, Z, 'FaceColor', [0.5 0 1]);
    
    % plot constraints
    Z1 = 1.5 + X .* Y - X - Y;
    surf(X, Y, Z1, 'FaceColor', [1 0 0.5]);
    
    Z2 = -X .* Y;
    surf(X, Y, Z2, 'FaceColor', [1 0 0.5]);  
    
    % print answer
    plot3(x(1), x(2), fval, 'go', 'LineWidth', 2);
end


function f = objfun(x)
    f = exp(x(1)) .* (4 .* x(1) .^ 2 + 2 .* x(2) .^ 2 + 4 .* x(1) .* x(2) + 2 .* x(2) + 1);
end

function [c, ceq] = confun(x)
    c = [1.5 + x(1) .* x(2) - x(1) - x(2); -x(1) .* x(2)  - 10];
    % no equality constraints
    ceq = [];
end
