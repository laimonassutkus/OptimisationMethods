function f = Levi13(mode)
	if strcmp(mode, 'function')
		f = @Levi13function;
    elseif strcmp(mode, 'graphical')
		Levi13graphical()
		f = [];
	end
end

function y = Levi13function(x)
    y = sin(3 .* pi .* x(1)) .^ 2 + (x(1) - 1) .^ 2 .* (1 + sin(3 * pi * x(2)) .^ 2) ...
        + (x(2) - 1) .^ 2 .* (1 + sin(2 .* pi .* x(2)) .^ 2);
end

function Levi13graphical()
	[x, y] = meshgrid(-5:0.1:5);
    z = sin(3 .* pi .* x) .^ 2 + (x - 1) .^ 2 .* (1 + sin(3 * pi * y) .^ 2) ...
        + (y - 1) .^ 2 .* (1 + sin(2 .* pi .* y) .^ 2);
    surf(x, y, z);
end