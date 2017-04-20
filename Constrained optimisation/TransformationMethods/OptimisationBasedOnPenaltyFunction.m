% Minimize f(x) = x1 ^ 2 + x2 ^ 2 
% Subject to h(x) = x1 + x2 - 2 = 0 
% Penalty function is selected to be the quadric function
% P(x, R) = x1 ^ 2 + x2 ^ 2 + (x1 + x2 - 2) ^ 2 * miu

function OptimisationBasedOnPenaltyFunction
    figure(1); hold on; grid on
    figure(2); hold on; grid on; axis([-10 10 -10 10 -1 100])
    
    miu = 1;
    epsl = 0.001;
    
    [X, Y] = meshgrid(-10:.5:10);
    
    F = X .^ 2 + Y .^ 2;
    
    figure(1)
    contour(X, Y, F, 50, 'Color', [0.5 0.6 0.35], 'LineWIdth', 2);
    
    figure(2)
    surf(X, Y, F, 'FaceColor', [0.5 0.6 0.35]);
    alpha(0.75)
    view(15, 30)
    
    start_minimum = gradientDescent(@(x, miu) penaltyFunctionGradient(x, miu), miu, epsl, [-4 -8]);
        disp('Minimum: '); disp(start_minimum)
        
    dist = Inf;
    while dist >= epsl
        miu = 1 + miu * 2;
        minimum = gradientDescent(@(x, miu) penaltyFunctionGradient(x, miu), miu, epsl, start_minimum);
        dist = pdist([minimum; start_minimum], 'euclidean');
        disp('Minimum: '); disp(minimum)
        start_minimum = minimum;
    end
    
    P = X .^ 2 + Y .^ 2 + (X + Y - 2) .^ 2 .* miu;
    
    figure(1)
    contour(X, Y, P, 50, 'Color', [0.75 0 0.9]);
    
    figure(2)
    surf(X, Y, P, 'FaceColor', [0.75 0 0.9]);
    alpha(0.75)
    view(15, 30)
end

function G = penaltyFunctionGradient(X, miu)
    G(1) = 2 * (miu * (X(1) + X(2) - 2) + X(1));
    G(2) = 2 * (miu * (X(1) + X(2) - 2) + X(2));
end

function localMinimum = gradientDescent(objFunction, miu, epsl, start_point)
    previous_point = start_point;
    next_point = start_point;
    delta = Inf;
    
    while delta >= epsl
        next_point = previous_point - (epsl / 10) .* objFunction(previous_point, miu);
        delta = pdist([next_point; previous_point], 'euclidean');
        
        figure(1)
        plot([previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'r', ...
            [previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'ro')
        
        previous_point = next_point;
    end
    localMinimum = next_point;
end














