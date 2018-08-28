%Calculate juvenile mortality rate and find parameter values
 
resident_timing=0.7;
 times = [0 resident_timing 1];

       %% RUN FIRST SEASON
            
            %Initial conditions 
            ini = [E_ini 40.19 0 0 0 3 0 0 0 0]';
            options = odeset('RelTol',1e-8,'AbsTol',1e-8, 'NonNegative', (1:10)');
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


            
%% set up matrices to keep track of state and time within and bw years
%this is inialized with output from first season
state_total = state;
time_total = time;


%state_total(size(state_total,1),3)/max(state_total(:,3));