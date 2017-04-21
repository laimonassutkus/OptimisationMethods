
function FeasibleDirectionsMethodVeinottModification
    figure(1); hold on; grid on
    figure(2); hold on; grid on

    [X, Y] = meshgrid(-5:.25:5);
    X0 = [0 0];
    
    Z = (X - 3) .^ 2 + (Y - 3) .^ 2;
    G1 = 2 .* X - Y .^ 2 - 1;
    G2 = 9 - 0.8 .* X .^ 2 - 2 .* Y;
    
    figure(1)
    surf(X, Y, Z, 'FaceColor', [0.4 0 1]);
    surf(X, Y, G1, 'FaceColor', [1 0 0.4]);
    surf(X, Y, G2, 'FaceColor', [1 0 0.4]);
    plot3(X0(1), X0(2), objFun(X0), 'go');
    
    figure(2)
    plot3(X0(1), X0(2), objFun(X0), 'go');
    contour(X, Y, Z, 20);
    
    funGradient = derivObjFun(X0) ./ norm(derivObjFun(X0));
    constGradient1 = derivConstFun1(X0) ./ norm(derivConstFun1(X0));
    constGradient2 = derivConstFun2(X0) ./ norm(derivConstFun2(X0));
    
    quiver(X0(1), X0(2), funGradient(1), funGradient(2), 0, 'MaxHeadSize', 5);
    quiver(X0(1), X0(2), -funGradient(1), -funGradient(2), 0, 'MaxHeadSize', 5);
    quiver(X0(1), X0(2), constGradient1(1), constGradient1(2), 0, 'MaxHeadSize', 5);
    quiver(X0(1), X0(2), constGradient2(1), constGradient2(2), 0, 'MaxHeadSize', 5);
       
    f = [-1; 0; 0];
    A = [1 constGradient1(1) constGradient1(2); 1 constGradient2(1) constGradient2(2)];
    b = [0; 0];
    lb = [-1; -1; -1];
    ub = [1000; 1; 1];
    
    x = linprog(f,A,b,[],[],lb,ub);
    feasDir = x ./ norm(x);

    quiver(X0(1), X0(2), feasDir(1), feasDir(2), 0, 'MaxHeadSize', 5);
    
    % veinott modification
    Amod = [1 constGradient1(1) constGradient1(2); 1 constGradient2(1) constGradient2(2); 1 constGradient2(1) -constGradient2(2)];
    bmod = [0; 0; 1];
    xmod = linprog(f,A,b,[],[],lb,ub);
    feasDirmod = x ./ norm(x);
    
    quiver(X0(1), X0(2), feasDirmod(1), feasDirmod(2), 0, 'MaxHeadSize', 5);
    
    legend('Start point', 'Function', 'Gradient', 'Antigradient', 'Constraint1 gradient', 'Constraint2 gradient', 'Feasible direction', 'Feasible Veinott direction')
end

function F = objFun(X)
    F = (X(1) - 3) .^ 2 + (X(2) - 3) .^ 2;
end

function G = derivConstFun1(X)
    G(1) = 2;
    G(2) = -2 .* X(2);
end

function G = derivConstFun2(X)
    G(1) = -1.6 .* X(1);
    G(2) = -2;
end

function D = derivObjFun(X)
    D(1) = 2 .* (X(1) - 3);
    D(2) = 2 .* (X(2) - 3);
end




















