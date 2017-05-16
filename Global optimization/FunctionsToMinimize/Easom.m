function f = Easom(mode)
	if strcmp(mode, 'function')
		f = @Easomfunction;
    elseif strcmp(mode, 'graphical')
		Easomgraphical()
		f = [];
	end
end

function y = Easomfunction(x)
    y = -cos(x(1)) .* cos(x(2)) .* exp(-(x(1) - pi) .^ 2 - (x(2) - pi) .^ 2);
end

function Easomgraphical()
	[x, y] = meshgrid(-5:.1:5);
    z = -cos(x) .* cos(y) .* exp(-(x - pi) .^ 2 - (y - pi) .^ 2);
    surf(x, y, z);
end