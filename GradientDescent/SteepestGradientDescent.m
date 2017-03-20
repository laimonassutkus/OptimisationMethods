function SteepestGradientDescent
    hold on;
    grid on;
    figure(1);
    [X, Y] = meshgrid(-5:.1:5);
    Z = given_function(X, Y);
    
    surf(X, Y, Z);

    start_point = [-4 -3];
    antigradiento_kryptis = -function_gradient(start_point);
    
    for i = 1:5
        local_minimum_point = D_iterate(start_point, antigradiento_kryptis, @given_function, 0.1);
        antigradiento_kryptis = -function_gradient(local_minimum_point) / norm(function_gradient(local_minimum_point));
        start_point = local_minimum_point;
    end
    
    local_minimum_point
    given_function(local_minimum_point(1), local_minimum_point(2))
    
    plot(local_minimum_point(1), local_minimum_point(2), 'go');
end

function z = given_function(x, y)
    z = 100 .* (y - x .^ 2) .^ 2 + (1 - x) .^ 2;
end

function g = function_gradient(x)
    g(1) = 400 * x(1) ^ 3 - 400 * x(1) * x(2) + 2 * x(1) - 2;
    g(2) = -200 * x(1) * 2 + 200 * x(2);
end

function minimum = D_iterate(current_coordinates, antigradient, our_function, step_size)
    if step_size <= 0.001
       minimum = current_coordinates
       return
    end

    next_coordinates = current_coordinates + step_size .* antigradient;
    
    current_value = our_function(current_coordinates(1), current_coordinates(2));
    next_value = our_function(next_coordinates(1), next_coordinates(2));
    
    while  next_value < current_value
        current_coordinates = next_coordinates;
        next_coordinates = current_coordinates + step_size .* antigradient;
        plot(current_coordinates(1), current_coordinates(2), 'ro');
        current_value = next_value;
        next_value = our_function(next_coordinates(1), next_coordinates(2));
    end
    minimum = D_iterate(current_coordinates, antigradient, our_function, step_size / 10);
end