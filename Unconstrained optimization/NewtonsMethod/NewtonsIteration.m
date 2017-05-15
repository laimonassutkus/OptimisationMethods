function NewtonsIteration()
    close all
    clear
    clc

    [x, y] = meshgrid(-6:.1:6);
    z = 100.*(y - x.^2).^2 + (1 - x).^2;

    x0 = [2, 2];
    iterations = 1000;
    
    contour(x, y, z, 20, 'k')
    hold on
    plot(1, 1, 'go')
    plot(x0(1), x0(2), 'ko')

    for i = 1:iterations
        grad = grad(x0);
        if norm(grad) < eps
            break
        end

        x1 = x0 - grad/hesse(x0);
        
        plot([x0(1) x1(1)], [x0(2) x1(2)], 'r')
        plot([x0(1) x1(1)] ,[x0(2) x1(2)], 'r*')
        x0 = x1;
    end
    
    if i == iterations
        fprintf('Minimumo taskas nebuvo pasiektas per %d iteraciju. ', i)
        disp('Paskutinis minimumo taskas')
        disp(x1)
        disp('Gradiento reiksme taske')
        disp(grad)
    else
        fprintf('Minimumas buvo pasiektas per %d iteraciju. ', i)
        disp('Minimumo taskas')
        disp(x1)
    end
    
end

function g = grad(x)
    % daline funkcijos isvestine pagal x(1)
    g(1) = - 400.*(x(2) - x(1).^2).*x(1) - 2 + 2.*x(1);
    % daline funkcijos isvestine pagal x(2)
    g(2) = 200.*(x(2) - x(1).^2);
end

function h = hesse(x)
    h(1, 1) = - 400.*(x(2) - 3.*x(1).^2) + 2;
    h(1, 2) = - 400;
    h(2, 1) = - 400;
    h(2, 2) = 200;
end