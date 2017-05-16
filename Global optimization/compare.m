function compare
% compare Genetic Algorithm, Simulated Annealing Algorithm and Particle Swarm Algorithm

disp('================= Ackley function: =================')
single_compare(Ackley('function'))
disp('================= Easom function: =================')
single_compare(Easom('function'))
disp('================= Levi N13 function: =================')
single_compare(Levi13('function'))
disp('================= Rosenbrock function: =================')
single_compare(Rosenbrock('function'))

end

function single_compare(func)
    tic; [ga_x, ga_val] = GA(func); ga_time = toc;
    tic; [saa_x, saa_val] = SAA(func); saa_time = toc;
    tic; [psa_x, psa_val] = PS(func); psa_time = toc;

    disp('------------------ time ------------------')
    disp(sprintf('%f - Genetic Algorithm', ga_time))
    disp(sprintf('%f - Simulated Annealing Algorithm', saa_time))
    disp(sprintf('%f - Particle Swarm Algorithm', psa_time))
    disp('------------------ values ------------------')
    disp(sprintf('x:%f  \t  y:%f  \t  z:%f - Genetic Algorithm', ga_x(1), ga_x(2), ga_val))
    disp(sprintf('x:%f  \t  y:%f  \t  z:%f - Simulated Annealing Algorithm', saa_x(1), saa_x(2), saa_val))
    disp(sprintf('x:%f  \t  y:%f  \t  z:%f - Particle Swarm Algorithm', psa_x(1), psa_x(2), psa_val))
end