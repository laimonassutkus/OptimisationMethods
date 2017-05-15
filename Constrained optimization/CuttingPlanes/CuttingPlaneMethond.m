function CuttingPlaneMethond
    close all
    
    addpath('.\..\..\Utility')
    addpath('.\..\..\Utility\APMonitor toolbox')

    figure(1); hold on; grid on; axis([-1 6 -1 6])
    
    [X, Y] = meshgrid(-1:0.1:6);
    Z = objFun({X Y});
    
    % Constraint 1: 0 <= 2 .* X - Y .^ 2 - 1;
    % Constraint 2: 0 <= 9 - 0.8 .* X .^ 2 - 2 .* Y;
    
    constraint1_x = (-Y.^2 -1) ./ -2;
    constraint2_y = (9 - 0.8 .* X .^ 2) ./ 2;
    
    % plot functions
    contour(X, Y, Z, 20, 'k');
    plot(X(1, :), constraint2_y(1, :), 'r'); 
    plot(constraint1_x(:, 1), Y(:, 1), 'r');

    rectangle('Position', [0 0 5 4])
    
    legend('Main function', 'Constraint 2x-y^2-1>=0', 'Constraint 9-0.8x^2-2y>=0')
    
    for i = 1:5
        drawnow;
        apm_ans = apm_solve('objFun', 3);
        minimum = [apm_ans.values(1) apm_ans.values(2)];
        plot(apm_ans.values(1), apm_ans.values(2), 'go');

        % identify mostly violated constraint
        C1 = conFun1({apm_ans.values(1) apm_ans.values(2)});
        C2 = conFun2({apm_ans.values(1) apm_ans.values(2)});

        if C1 > C2
            G2 = conFun2Gradient({apm_ans.values(1) apm_ans.values(2)});
            syms x y
            f = simplify(sym(C2+G2(1)*(x-minimum(1))+G2(2)*(y-minimum(2))));
            AddConstraint('objFun.apm', char(vpa(f, 3)));
        else
            G1 = conFun1Gradient({apm_ans.values(1) apm_ans.values(2)});
            syms x y
            f = simplify(sym(C1+G1(1)*(x-minimum(1))+G1(2)*(y-minimum(2))));
            AddConstraint('objFun.apm', char(vpa(f, 3)));
        end
        
        vpa(f, 3)
        h = ezplot(vpa(f, 3));
        set(h, 'Color', 'blue')
    end
end

function F = objFun(X)
    F = -X{1} - X{2};
end

function G = conFun1(X)
    G = 2 .* X{1} - X{2} .^ 2 - 1;
end

function G = conFun1Gradient(X)
    G(1) = 2;
    G(2) = -2 .* X{2};
end

function G = conFun2(X)
    G = 9 - 0.8 .* X{1} .^ 2 - 2 .* X{2};
end

function G = conFun2Gradient(X)
    G(1) = -1.6 .* X{1};
    G(2) = -2;
end









