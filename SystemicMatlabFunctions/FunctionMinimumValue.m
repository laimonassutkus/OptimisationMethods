% main entry point
function FunctionMinimumValue()
    x = -1.5:0.1:2;
    
    hold on;
    grid on;
    
    functions = {@fun1, @fun2, @fun3};
    evalFunctions(functions, x);
    legend(get(gca, 'children'), get(get(gca, 'children'), 'userdata'))
end

function f1 = fun1(x)
    f1 = (x .^ 6) / 6 - x .^ 3 + 2 * x;
end

function f2 = fun2(x)
    f2 = x + (1 ./ exp(x - 1) - 1);
end

function f3 = fun3(x)
    f3 = x - sin(x);
end

function evalFunctions(functions, x)
    for func = functions
        y = func{1};
        plot(x, y(x), 'userdata', func2str(y));
        
        fminbnd(y, x(1), x(end), optimset('Display','iter', 'TolX', 1e-12));
    end
end















