function GradientDescentConstantStepSize
    figure(1);
    [X, Y] = meshgrid(-5:.1:5);
    Z = 100 .* (Y - X .^ 2) .^ 2 + (1 - X) .^ 2;
    subplot(1, 2, 1);
    surf(X, Y, Z);
    subplot(1, 2, 2);
    hold on;
    contour(X, Y, Z);
    [dX, dY] = gradient(Z, .1, .1);
    quiver(X, Y, dX, dY);
    
    start_point = [-4, -4];
    previous_point = start_point;
    next_point = start_point; 
    
    iterations = 1000;
    step_size = 0.05;
    
    for i = 1:iterations
       next_point = previous_point - step_size .* (function_gradient(previous_point) / norm(function_gradient(previous_point)));
       plot([previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'r', ...
            [previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'ro')
       previous_point = next_point;
    end
    next_point
end

function g = function_gradient(x)
    g(1) = 400 * x(1) ^ 3 - 400 * x(1) * x(2) + 2 * x(1) - 2;
    g(2) = -200 * x(1) * 2 + 200 * x(2);
end