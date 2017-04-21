function CuttingPlaneMethond
    addpath('.\..\..\Utility')
    addpath('.\..\..\Utility\APMonitor toolbox')

    subplot(1,2,1); hold on; grid on; axis([0 5 0 4 -20 10])
    subplot(1,2,2); hold on; grid on; axis([-1 6 -1 6 -20 10])
    
    [minimum, Y] = meshgrid(0:0.5:5);
    Z = objFun({minimum Y});
    C1 = conFun1({minimum Y});
    C2 = conFun2({minimum Y});
    
    subplot(1,2,1);
    surf(minimum, Y, Z, 'FaceColor', [0 0 1]);
    surf(minimum, Y, C1, 'FaceColor', [1 0.4 0]);
    surf(minimum, Y, C2, 'FaceColor', [1 0 0.4]);
    alpha(0.9)
    legend('Main function', 'Constraint 2x-y^2-1>=0', 'Constraint 9-0.8x^2-2y>=0')
    
    subplot(1,2,2);
    [x1, y1, z1] = Intersection(minimum, Y, Z, C1);
    line(x1, y1, arrayfun(@(x) 0, z1), 'Color', [1 0.4 0], 'LineWidth', 3)
    
    [x2, y2, z2] = Intersection(minimum, Y, Z, C2);
    line(x2, y2, arrayfun(@(x) 0, z2), 'Color', [1 0 0.4], 'LineWidth', 3)
    
    rectangle('Position', [0 0 5 4])
    for i = 1:20
        apm_ans = apm_solve('objFun', 3);
        minimum = [apm_ans.values(1) apm_ans.values(2)];
        plot(apm_ans.values(1), apm_ans.values(2), 'go', 'LineWidth', 2);

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
        ezplot(vpa(f, 3));
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









