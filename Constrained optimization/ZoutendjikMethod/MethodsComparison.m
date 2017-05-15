
A = [];

FeasibleDirectionsMethod([1 1], eps, DebugMode.ALL);
FeasibleDirectionsMethodVeinottModification([1 1], eps, DebugMode.ALL);

for i = 1:10
    dmode = DebugMode.NONE;
    [~, time1] = FeasibleDirectionsMethod([1 1], eps, dmode);
    [~, time2] = FeasibleDirectionsMethodVeinottModification([1 1], eps, dmode);
    
    A = [A; time1 time2];
end

figure(2);
bar(A)
legend('Without veinott modification', 'With veinott modification','Location','southwest')
title(sprintf('Comparison between Zoutendjik method and \n Zoutendjik method with Veinott modification'))
xlabel('Methods')
ylabel('Elapsed time')

avg1 = sprintf('Average execution time of Zoutendjik without Veinott modification: %d', sum(A(1, :)) / length(A(1, :)));
avg2 = sprintf('Average execution time of Zoutendjik with Veinott modification: %d', sum(A(2, :)) / length(A(2, :)));

disp(avg1)
disp(avg2)

clear all