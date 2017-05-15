function f = Rosenbrock(mode)
	if strcmp(mode, 'function')
		f = @Rosenbrokfunction;
    elseif strcmp(mode, 'graphical')
		Rosenbrokgraphical()
		f = [];
	end
end

function y = Rosenbrokfunction(x)
    y = 100 .* (x(1) .^ 2 - x(2)) .^ 2 + (1 - x(1)) .^ 2;
end

function Rosenbrokgraphical()
	[x, y] = meshgrid(-5:.1:5);
    z = 100 .* (x .^ 2 - y) .^2 + (1 - x) .^ 2;
    surf(x, y, z);
end