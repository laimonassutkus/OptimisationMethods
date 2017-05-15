clear all
x = -1:0.01:3;
f = x.^2;
g = 2-x;
p1 = max(zeros(size(x)),g);
p = p1.^2;

figure (1)
plot(x,f,x,p)

figure (2)

for i = 1:10
c=i^2;
q = f + c*p;
plot(x,q)
hold on
end

hold off
axis([-1 3 0 10])