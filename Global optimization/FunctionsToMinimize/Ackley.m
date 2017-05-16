function f = Ackley(mode)
	if strcmp(mode, 'function')
		f = @Ackleyfunction;
    elseif strcmp(mode, 'graphical')
		Ackleygraphical()
		f = [];
	end
end

function y = Ackleyfunction(x)
	n = 2;
	sum1 = 0;
	sum2 = 0;
	sum1 = sum1 + x(1) .^ 2;
	sum2 = sum2 + cos((2 .* pi) .* x(1));
	sum1 = sum1 + x(2) .^ 2;
	sum2 = sum2 + cos((2 .* pi) .* x(2));
	y = 20 + exp(1) - 20 .* exp(-0.2 .* sqrt(1 ./ n .* sum1)) - exp(1 ./ n .* sum2);
end

function Ackleygraphical()
	[x, y] = meshgrid(-5:.1:5);
	n = 2;
	sum1 = 0;
	sum2 = 0;
	sum1 = sum1 + x .^ 2;
	sum2 = sum2 + cos((2 .* pi) .* x);
	sum1 = sum1 + y .^ 2;
	sum2 = sum2 + cos((2 .* pi) .* y);
	z = 20 + exp(1) - 20 .* exp(-0.2 .* sqrt(1 ./ n .* sum1)) - exp(1 ./ n .* sum2);
	surf(x, y, z)
end