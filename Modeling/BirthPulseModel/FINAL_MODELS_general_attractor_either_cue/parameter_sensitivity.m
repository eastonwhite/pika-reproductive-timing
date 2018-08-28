
tic 
%% Set of trait values for mutant and resident combinations to try
%trait_values= round(2.5:0.1:4,5); % use sigma =0 to 9
trait_values= round(25:2:120,5);

%% Define vectors for values of E0 and var(E0), noise_values, to try
p=parameters;
%parameter_values_to_try = (0.0001:0.00025:0.03)';
parameter_values_to_try = (0.0001:0.001:0.02)'; %u_E
%parameter_values_to_try = (0.1:0.3:5)'; %birth_rate,k, attack rate
%parameter_values_to_try = (0.7:0.02:0.99)';

% Set up number of trials and max_time
num_trials=1;
max_time_values=5*ones(1,size(parameter_values_to_try,1));

%% Set up vectors to keep track of calculated ESSs and invader fitness
invader_fitness=zeros(size(trait_values,2),size(trait_values,2));
reproductive_timing_matrix =zeros(size(trait_values,2),size(trait_values,2));
reproductive_timing_variance_matrix =zeros(size(trait_values,2),size(trait_values,2));
ESS_output = zeros(size(parameter_values_to_try,1),5);
invader_fitness_matrices = zeros(size(trait_values,2),size(trait_values,2),size(parameter_values_to_try,1));
reproductive_timing_matrices  = zeros(size(trait_values,2),size(trait_values,2),size(parameter_values_to_try,1));

 

%%  



for index = 1:size(parameter_values_to_try,1)
    max_time = 5;
    randomE0 = 18*ones(1000,1);
     p.u_E = parameter_values_to_try(index);
     %p.sigma_J = parameter_values_to_try(index);

    resident_mutant_games_environrule
    
%calculate gradient in x and y directions of pairwise invasibility
    invader_fitness(invader_fitness==0)=NaN;
    invader_fitness(invader_fitness<0.95)=NaN;
    [gradx,grady]=gradient(invader_fitness);
    [tmin,tI]=min((min(abs(grady)+abs(gradx),[],2)),[],1);

    if tI==1 || tI==size(trait_values,2)
        %save model outputs
        ESS_output(index,1) = NaN;
        ESS_output(index,2) = NaN;
        ESS_output(index,3) = NaN;
        ESS_output(index,4) = parameter_values_to_try(index)
        %break
        %ESS_output(index,5) = parameter_values_to_try(index,2)
    else
        %save model outputs
        ESS_output(index,1) = trait_values(tI);
        ESS_output(index,2) = reproductive_timing_matrix(tI,tI);
        ESS_output(index,3) = reproductive_timing_variance_matrix(tI,tI);
        ESS_output(index,4) = parameter_values_to_try(index)
        %ESS_output(index,5) = parameter_values_to_try(index,2)
    end


    invader_fitness_matrices(:,:,index) = invader_fitness;
    reproductive_timing_matrices(:,:,index) = reproductive_timing_matrix;


    %clock - c
    %trait_values = round(trait_values + 0.005,5);
end
toc
timing_rule_sensitivity_analysis = table(ESS_output(:,1), ESS_output(:,2),ESS_output(:,4));
timing_rule_sensitivity_analysis.Properties.VariableNames= {'ESS' 'RT' 'param_value'};
writetable(timing_rule_sensitivity_analysis, 'model_outputs/timing_rule_sensitivity_analysis_u_E.csv','Delimiter',',','QuoteStrings',true)

save('model_outputs/timing_rule_sensitivity_analysis_u_E.mat')
