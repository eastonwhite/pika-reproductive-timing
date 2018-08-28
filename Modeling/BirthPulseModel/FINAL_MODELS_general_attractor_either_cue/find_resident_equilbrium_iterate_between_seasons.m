
%% Created by Easton R White
%Date created 28-Jun-2016
%Last edited: 10-May-2017


%% run within and between season dynamics until resident equilbrium is found
% Currently the code only solve equilbrium which is a fixed point (thus
% deterministic)

    %% RUN FIRST SEASON

    %resident_timing = q;
    %Initial conditions
    if resident_timing > 0 && resident_timing < 170
    ini = [randomE0(1) previous_resident_equilbrium 0 0 0 3 0 0 0 0]';
    options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
    times(2) = resident_timing;
    [time,state] = ode45(@WithinSeasonEquations, [times(1) times(2)], ini, options,p);

    %ini conditions from end of first part of season
    ini = state(size(state,1),:);
    %resident reproductive timing and setting juvenile body
    %condition to zero
    ini(3)=p.birth_rate*ini(2);
    ini(4)=0;
    [t_temp,x_temp] = ode45(@WithinSeasonEquations, [times(2) times(3)], ini, options,p);
    time=[time(1:(size(time,1)-1));t_temp];
    state=[state(1:(size(state,1)-1),:);x_temp];

    else
    ini = [randomE0(1) previous_resident_equilbrium 0 0 0 3 0 0 0 0]';
    options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
    [time,state] = ode45(@WithinSeasonEquations, [times(1) times(3)], ini, options,p);
    %time=[time(1:(size(time,1)-1));t_temp];
    %state=[state(1:(size(state,1)-1),:);x_temp];
    end


%% set up matrices to keep track of state and time within and bw years
%this is inialized with output from first season
state_total = state;
time_total = time;
res_ini_abundance = state(1,2);


%% RUN BETWEEN SEASON DYNAMICS
for j = 2:years


            %initialize the model with outputs from surviors from the previous
            %season

            ini = [randomE0(j) 1 0 0 0 3 0 0 0 0]'; %

            ini(2) = state(size(state,1),2)*p.sigma_A*state(size(state,1),5)/(p.k_A +state(size(state,1),5))+...
          state(size(state,1),3)*p.sigma_J*state(size(state,1),4)/(p.k_J +state(size(state,1),4));

          if q > 20
            resident_timing = q;
          else
            resident_timing = (-1/p.e)*log(q/randomE0(j));
          end

    %Initial conditions
    if resident_timing > 0 && resident_timing < 170
            %This code runs the within season dynamics from [0,r], [r,m], and [m,1]
            times(2) = resident_timing;
            %time until resident reproduction
            options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
            [t,x] = ode45(@WithinSeasonEquations, [times(1) times(2)], ini, options,p);
            time=t;
            state=x;

            %ini conditions from end of first part of season
            ini = x(size(x,1),:);
            ini(3)=p.birth_rate*ini(2);
            ini(4)=0;
            [t_temp,x_temp]=ode45(@WithinSeasonEquations, [times(2) times(3)], ini, options,p);
            time=[time(1:(size(time,1)-1));t_temp];
            state=[state(1:(size(state,1)-1),:);x_temp];
    else
            options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
            [time,state]=ode45(@WithinSeasonEquations, [times(1) times(3)], ini, options,p);
            %time=[time(1:(size(time,1)-1));t_temp];
            %state=[state(1:(size(state,1)-1),:);x_temp];
    end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Save values for plotting later
        res_ini_abundance = [res_ini_abundance;state(1,2)];
        state_total = [state_total; state];
        time_total= [time_total; (time_total(end))+time];


        %break loop if near an equilbrium, should speed things up a lot. Need
        %to be careful with error tolerance that I set. Better to be
        %conservative


        %if (abs(res_ini_abundance(j)-res_ini_abundance(j-1))/res_ini_abundance(j)) < 0.00001 %may need to change depending on scaling
            %res_ini_abundance
        %    break
        %end



end % End loop
