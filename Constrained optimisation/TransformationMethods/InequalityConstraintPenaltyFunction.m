% Minimize f(x) = x1 ^ 2 + x2 ^ 2 
% Subject to h(x) = x1 + x2 - 2 >= 0 
% Penalty function is selected to be the quadric function
% P(x, R) = x1 ^ 2 + x2 ^ 2 + (x1 + x2 - 2) ^ 2 * miu

function InequalityConstraintPenaltyFunction
    hold on; grid on; axis([-10 10 -10 10])
    
    epsl = 1e-5;
    
    [X, Y] = meshgrid(-10:.5:10);
    start_point = [-4 -8];

    objFun = X .^ 2 + Y .^ 2;  
    
    zerosMatrix = zeros(size(objFun));
    penFun = X + Y - 2;
    quadricIneqPenFun = min(penFun, zerosMatrix);
        
    dist = Inf;
    index = 1;
    miu = -0.25; % small hack for the upcoming iteration miu = miu * 4 + 1;
    while dist >= epsl
        miu = miu * 4 + 1;
        minimum = gradientDescent(@(x, miu) penaltyFunctionGradient(x, miu), miu, epsl, start_point);
        dist = pdist([minimum; start_point], 'euclidean');
        disp('Minimum: '); disp(minimum)
        start_point = minimum;
        
        % plot object function transformed by penalty function
        transFun = objFun + quadricIneqPenFun .* miu;
            
        if index <= 9
            subplot(3, 3, index);
            title(sprintf('Miu = %d', miu));
            hold on; grid on; axis([-10 10 -10 10])
            contour(X, Y, transFun, 50, 'Color', [0.75 0 0.9], 'LineWIdth', 1.25);


            % plot constraint function
            x = -10:.5:10;
            y = 2 - x;
            plot(x, y, 'r');

            % plot object function
            contour(X, Y, objFun, 50, 'Color', [0.8 0.9 0.65], 'LineWIdth', 0.75);

            index = index + 1;
        end
    end
    disp(sprintf('Does Karush-Kuhn-Tucker Theorem hold true? C(x) = %d', start_point(1) + start_point(2) - 2))
end

function G = penaltyFunctionGradient(X, miu)
    G(1) = 2 .* X(1) + min(0, 2 * miu .* (X(1) + X(2) - 2));
    G(2) = 2 .* X(2) + min(0, 2 * miu .* (X(1) + X(2) - 2));
end

function localMinimum = gradientDescent(objFunction, miu, epsl, start_point)
    previous_point = start_point;
    next_point = start_point;
    delta = Inf;
    
    while delta >= epsl
        next_point = previous_point - (epsl / 10) .* objFunction(previous_point, miu);
        delta = pdist([next_point; previous_point], 'euclidean');
        
        %plot([previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'r', ...
        %    [previous_point(1), next_point(1)], [previous_point(2), next_point(2)],'ro')
        
        previous_point = next_point;
    end
    localMinimum = next_point;
    plot(localMinimum(1), localMinimum(2), 'ro');
end














