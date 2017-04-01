clear all
% Conjugate gradients without Gram-Schmidt ortogonalization

[X,Y] = meshgrid(-3:0.01:3);
F = 100*(Y-X.^2).^2 + (1-X).^2;

contour(X,Y,F,20,'k')
hold on

X0 = [-2; -2.5];


for epochs = 1:200
% minimization according to i
Si = [1; 0];
gamma = 0.001;
Fold = 100*(X0(2)-X0(1)^2)^2+(1-X0(1))^2;
X1 = X0 + gamma*Si;
X2 = X0 - gamma*Si;
F1 = 100*(X1(2)-X1(1)^2)^2+(1-X1(1))^2;
F2 = 100*(X2(2)-X2(1)^2)^2+(1-X2(1))^2;

Xold = X0;

if F2<F1
    gamma = -gamma;
    Fnew = F2; Xnew = X2;
else
    Fnew = F1; Xnew = X1;
end

while (Fnew<Fold)
   Xold = Xnew;
   Fold = Fnew;
   Xnew = Xold + gamma*Si;
   Fnew = 100*(Xnew(2)-Xnew(1)^2)^2+(1-Xnew(1))^2;
end

plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'or')
hold on
plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'r')
hold on
X0 = Xnew;
XC1 = X0;

% descent according to j
Sj = [0; 1];
gamma = 0.001;
Fold = 100*(X0(2)-X0(1)^2)^2+(1-X0(1))^2;
X1 = X0 + gamma*Sj;
X2 = X0 - gamma*Sj;
F1 = 100*(X1(2)-X1(1)^2)^2+(1-X1(1))^2;
F2 = 100*(X2(2)-X2(1)^2)^2+(1-X2(1))^2;

Xold = X0;

if F2<F1
    gamma = -gamma;
    Fnew = F2; Xnew = X2;
else
    Fnew = F1; Xnew = X1;
end

while (Fnew<Fold)
   Xold = Xnew;
   Fold = Fnew;
   Xnew = Xold + gamma*Sj;
   Fnew = 100*(Xnew(2)-Xnew(1)^2)^2+(1-Xnew(1))^2;
end

plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'or')
hold on
plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'r')
hold on
X0 = Xnew;

% descent according to i
Si = [1; 0];
gamma = 0.001;
Fold = 100*(X0(2)-X0(1)^2)^2+(1-X0(1))^2;
X1 = X0 + gamma*Si;
X2 = X0 - gamma*Si;
F1 = 100*(X1(2)-X1(1)^2)^2+(1-X1(1))^2;
F2 = 100*(X2(2)-X2(1)^2)^2+(1-X2(1))^2;

Xold = X0;

if F2<F1
    gamma = -gamma;
    Fnew = F2; Xnew = X2;
else
    Fnew = F1; Xnew = X1;
end

while (Fnew<Fold)
   Xold = Xnew;
   Fold = Fnew;
   Xnew = Xold + gamma*Si;
   Fnew = 100*(Xnew(2)-Xnew(1)^2)^2+(1-Xnew(1))^2;
end

plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'or')
hold on
plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'r')
hold on
X0 = Xnew;
XC3 = X0;

S31 = XC3-XC1;
plot([XC1(1) XC3(1)],[XC1(2) XC3(2)],'or')
hold on
plot([XC1(1) XC3(1)],[XC1(2) XC3(2)],'b')
hold on

% descent according to S31
gamma = 0.001;
Fold = 100*(X0(2)-X0(1)^2)^2+(1-X0(1))^2;
X1 = X0 + gamma*S31;
X2 = X0 - gamma*S31;
F1 = 100*(X1(2)-X1(1)^2)^2+(1-X1(1))^2;
F2 = 100*(X2(2)-X2(1)^2)^2+(1-X2(1))^2;

Xold = X0;

if F2<F1
    gamma = -gamma;
    Fnew = F2; Xnew = X2;
else
    Fnew = F1; Xnew = X1;
end

while (Fnew<Fold)
   Xold = Xnew;
   Fold = Fnew;
   Xnew = Xold + gamma*S31;
   Fnew = 100*(Xnew(2)-Xnew(1)^2)^2+(1-Xnew(1))^2;
end

plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'og')
hold on
plot([X0(1) Xnew(1)],[X0(2) Xnew(2)],'g')
hold on
X0 = Xnew;

end

hold off

