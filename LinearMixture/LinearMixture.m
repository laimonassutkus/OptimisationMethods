hold on
axis([0 11 0 11])

Constraints = {[1 3] [5 10] [10 5] [7 1]};

for index = 1:length(Constraints)
    if index < length(Constraints)
        line([Constraints{index}(1) Constraints{index + 1}(1)], ...
            [Constraints{index}(2) Constraints{index + 1}(2)], 'Color', 'red', 'Linewidth', 1)
    end
    plot(Constraints{index}(1), Constraints{index}(2), 'ro')
end

line([Constraints{4}(1) Constraints{1}(1)], ...
    [Constraints{4}(2) Constraints{1}(2)], 'Color', 'red', 'Linewidth', 1)

normalizationPoints = zeros(1, 4);

for i = 1:1000
    disp(i);
   
    normalizationPoints = arrayfun(@(x) rand, normalizationPoints);
    sumNorm = sum(normalizationPoints);

    for index = 1:4
       normalizationPoints(index) = normalizationPoints(index) / sumNorm;
    end

    PointX = 0;
    PointY = 0;

    for index = 1:4
        PointX = PointX + normalizationPoints(index) * Constraints{index}(1);
        PointY = PointY + normalizationPoints(index) * Constraints{index}(2);
    end

    plot(PointX, PointY, 'ro');
end



