function NewtonsMethod
    [X,Y] = meshgrid(-3:0.1:3);
    F = 1 - exp(-X.^2 - Y.^2);

    surf(X,Y,F)
    hold on

    start_point = [0.5 0.5];
    x0 = start_point(1);
    y0 = start_point(2);

    function_val = 1 - exp(-x0^2 - y0^2);
    function_gradient = [2*x0; 2*y0];
    function_gradient = function_gradient * exp(-x0^2 - y0^2);

    H = [2-4*x0^2 -4*x0*y0; ...
         -4*x0*y0 2-4*y0^2];

    H = H * exp(-x0^2 - y0^2);

    approximated_function_val = function_val + function_gradient(1)*(X-x0) + function_gradient(2)*(Y-y0) +...
    0.5*(H(1,1)*(X-x0).^2 + 2*H(1,2)*(X-x0).*(Y-y0) + H(2,2)*(Y-y0).^2);    

    surfl(X,Y,approximated_function_val);
    hold off

    axis([-3 3 -3 3 -0.5 1.5])
end