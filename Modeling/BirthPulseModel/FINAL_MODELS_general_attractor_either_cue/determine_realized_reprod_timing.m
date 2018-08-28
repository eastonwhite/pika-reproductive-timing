
mean_timing=zeros(1,13);
trait_values_vector=[repmat(0.51,1,6),0.53,0.51,0.53,0.51,repmat(0.53,1,3)];
for i=8:20
%script to calculate average realized reproductive timing
load('simulated_snow.mat')
E_ini=18;
noise=i;
trait_values=trait_values_vector(i-7);
q=trait_values;
max_time=300;
qq=q;
p=parameters;

previous_resident_equilbrium=4.0e-05;
resident_timing = (-1/p.e)*log(q/E_ini);
[resident_equilbrium, time_to_completion]=find_resident_equilbrium(5000,resident_timing,p,E_ini,previous_resident_equilbrium);

[mutant_fitness, reproductive_timing] = calc_mutant_fitness(q, qq,p,E_ini,resident_equilbrium,max_time,noise,randomE0);

mean_timing(i-7)=mean(reproductive_timing(50:max_time));

%plot(reproductive_timing(50:max_time))

end