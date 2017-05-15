% main entry point
function FunctionMinimumValue3D()

    f1 = @(x) x(1) .^2 + 100 .* x(2) .^ 2;
    f2 = @(x) 100 .* (x(2) - x(1) .^ 2) .^ 2 + (1 - x(1)) .^ 2;
    f3 = @(x) sin(x(1) .^2 + 3 .* x(2) .^2 + 1) ./ (x(1) .^2 + 3 .* x(2) .^ 2 + 1);
    f4 = @(x) x(1) .* exp(-x(1) .^ 2 - x(2) .^ 2);
    f5 = @(x) x(1) .^ 2 + x(2) .^ 2;
    
    func = {f1 f2 f3 f4 f5};
    options = optimoptions(@fminunc,'Display','iter');
    
    for f = func
       fminunc(f{1}, [1, 1], options); 
    end

    [x, y] = meshgrid(-3:0.1:3);    
    functions = {@fun1, @fun2, @fun3, @fun4, @fun5};
    evalFunctions(functions, x, y);
end


function evalFunctions(functions, x, y)
    index = 1;
    for func = functions
        z = func{1};
        [dx, dy] = gradient(z(x, y));
        subplot(2,3,index);
        hold on; grid on;
        contour(x, y, z(x, y));
        quiver(x, y, dx, dy);
        index = index + 1;
    end
end


function f1 = fun1(x, y)
    f1 = x .^2 + 100 .* y .^ 2;
end

function f2 = fun2(x, y)
    f2 = 100 .* (y - x .^ 2) .^ 2 + (1 - x) .^ 2;
end

function f3 = fun3(x, y)
    f3 = sin(x .^2 + 3 .* y .^2 + 1) ./ (x .^2 + 3 .* y .^ 2 + 1);
end

function f4 = fun4(x, y)
    f4 = x .* exp(-x .^ 2 - y .^ 2);
end

function f5 = fun5(x, y)
    f5 = x .^ 2 + y .^ 2;
end















