clear all
[X,Y] = meshgrid(-3:0.01:3);
F = X.^2 + Y.^2;
figure(1)
contour(X,Y,F,20,'k')
axis equal

% subject to h(x,y)= -x-y+3 = 0
% penalty p(x,y) = h(x,y).^2
% transformed function T(x,y) = F(x,y) + miu*p(x,y); miu>0

P = (-X-Y+3).^2;
miu = 2;
T = F + miu*P;
figure(2)
contour(X,Y,T,20,'k')
hold on
x = -3:0.01:3;
y = 3-x;
plot(x,y,'r')
axis([-3 3 -3 3])
axis equal





