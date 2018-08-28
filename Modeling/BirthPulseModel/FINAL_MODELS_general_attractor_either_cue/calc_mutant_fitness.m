
%% Created by Easton R White
%Date created 24-Jun-2016
%Date edited 10-May-2017

%This code runs the model defined by `WithinSeasonsEquations.m` for several
%years. The code then calculates the fitness of an initially rare mutant
%(this is the invader fitness)


%% Define function calc_mutant_fitness
function [mutant_fitness, reproductive_timing_mean, reproductive_timing_variance] = calc_mutant_fitness(q, qq,p,resident_equilbrium,max_time,num_trials,randomE0_vector)

    %set up matrices to keep track of the abundance at the beginning of
    %each season
     rng(12345)
        mutant_fitness_trials = zeros(1,num_trials);
        reproductive_timing_trials = zeros(1,num_trials);
     for trial = 1:num_trials

    % TEMPORARY, trial to reshuffle randomE0 here

    randomE0 =randomE0_vector(randperm(length(randomE0_vector)));

    reproductive_timing = zeros(1,max_time);
    mut_ini_abundance = ones(1,max_time)*0.000001;
    res_ini_abundance = ones(1,max_time)*mean(resident_equilbrium);

    %loop to track dynamics over multiple years
    for year = 2:max_time

        %set up initial conditions which depend on random E[0], and the
        %suriving adult populations after one year
        ini = [18 res_ini_abundance(year-1) 0 0 0 3 mut_ini_abundance(year-1) 0 0 0]';
        time = zeros(1,1);
        ini(1) = randomE0(year);
        state = ini';
        % Testing new snow model

        %Calculate the timing of reproduction (dependent on model
        %parameters, strategy value (q), and initial conditions)
        if q > 20
          resident_timing = q;
          mutant_timing  = qq; %needed to use randomE0 not E_ini here
        else
          resident_timing = (-1/p.e)*log(q/randomE0(year));
          mutant_timing  = (-1/p.e)*log(qq/randomE0(year));
        end


        %conditions for times to run the model -- run model between days 0
        %(march 15th, arbitrary start day)and 170 (end of summer, start of winter)
        if resident_timing>0 && mutant_timing>0 && resident_timing<170 && mutant_timing<170 && resident_timing ~= mutant_timing
            times=sort([0, resident_timing, mutant_timing, 170]);
        elseif or(mutant_timing<=0 && resident_timing<=0, mutant_timing>=170 && resident_timing>=170)
            times=[0, 170];
        elseif resident_timing==mutant_timing
            times=[0, resident_timing, 170];
        elseif or(resident_timing<=0, resident_timing>=170) && mutant_timing>0
            times=[0, mutant_timing, 170];
        elseif or(mutant_timing<=0,mutant_timing>=170) && resident_timing>0
            times=[0, resident_timing, 170];
        end


        % this runs the within season dynamics by stopping the ODE solver
        % at various points to allow for a pulse of reproduction by either
        % the mutant or the resident. In other words, the ODE solver runs
        % chunks of the reproductive season and glues them together.
        season_part_number=1;
        while season_part_number<5
        ini = state(size(state,1),:);

           if times(season_part_number)<170  %loop is killed after time>1 (end of season), %what happens in stochastic setting if mutant or resident should give birth before season
                if times(season_part_number)==resident_timing && times(season_part_number)==mutant_timing
                    ini(3)=p.birth_rate*ini(2);
                    ini(4)=0;
                    ini(8)=p.birth_rate*ini(7);
                    ini(9)=0;
                elseif times(season_part_number)==resident_timing
                    ini(3)=p.birth_rate*ini(2);
                    ini(4)=0;
                elseif times(season_part_number)==mutant_timing
                     ini(8)=p.birth_rate*ini(7);
                     ini(9)=0;
                end

                % Define model options and solve using ode45
                options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
                [t,x] = ode45(@WithinSeasonEquations, [times(season_part_number) times(season_part_number+1)], ini, options,p);
                time=[time(1:(size(time,1)-1));t];
                state=[state(1:(size(state,1)-1),:);x];

                season_part_number=season_part_number+1; % Advance to next part of summer
           else
               %at the end of the season (before winter), this code calculates the over
               %winter survival probability for adults and juveniles (note
               %that all juveniles become adults or die in the case of
               %pikas)
               mut_ini_abundance(year) = state(size(state,1),7)*p.sigma_A*state(size(state,1),10)/(p.k_A +state(size(state,1),10))+...
                  state(size(state,1),8)*p.sigma_J*state(size(state,1),9)/(p.k_J +state(size(state,1),9));
               res_ini_abundance(year) = state(size(state,1),2)*p.sigma_A*state(size(state,1),5)/(p.k_A +state(size(state,1),5))+...
                  state(size(state,1),3)*p.sigma_J*state(size(state,1),4)/(p.k_J +state(size(state,1),4));
              season_part_number=5;
              reproductive_timing(year)=resident_timing;
           end
        end




     csvwrite(strcat('example_pop_dyn', num2str(year),'.txt'),[time,state])
      %hold on
    end
    %plot(res_ini_abundance(2:max_time))

    %% calculate mutant fitness, which is the geometric growth rate over time
    temp_mutant_fitness = (prod(mut_ini_abundance(2:max_time)./mut_ini_abundance(1:(max_time-1)))^(1/(max_time-1)));
    temp_resident_fitness = (prod(res_ini_abundance(2:max_time)./res_ini_abundance(1:(max_time-1)))^(1/(max_time-1)));
%    for time_point = 5:5:max_time
%         temp_mutant_fitness = mean([temp_mutant_fitness,(prod(mut_ini_abundance(2:time_point)./mut_ini_abundance(1:(time_point-1)))^(1/(time_point-1)))]);
%         temp_resident_fitness = mean([temp_resident_fitness,(prod(res_ini_abundance(2:time_point)./res_ini_abundance(1:(time_point-1)))^(1/(time_point-1)))]);
%     end

    mutant_fitness_trials(trial) = temp_mutant_fitness/temp_resident_fitness;

    
    reproductive_timing_trials(trial) = mean(reproductive_timing(2:max_time));

    end %end of trial loop
    mutant_fitness = mean(mutant_fitness_trials);
    reproductive_timing_variance = var(reproductive_timing(2:max_time));
    reproductive_timing_mean = mean(reproductive_timing_trials);


%% Various plotting and data export options
 

 %   subplot(1,2,1)
   %plot(time,state(:,3),'ok')
   
 %  placeholder=find(state(:,3)>0);
 %  state(size(state,1),3)/state(placeholder(1),3)
   %state
 %      subplot(1,2,2)
 %  plot(time,state(:,6),'ok')

  %  hold on
  % plot(reproductive_timing(1:30))
% mean(reproductive_timing(2:30))
%  var(reproductive_timing(2:30))
end
