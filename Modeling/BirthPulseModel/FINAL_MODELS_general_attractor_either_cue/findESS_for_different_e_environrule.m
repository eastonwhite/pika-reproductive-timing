%% Created by Easton R White
%Date created 24-Jun-2016
%Last updated 14-Nov-2017

%%This script calculates the evolutionary stable strategy (ESS) for
%%different combinations of the timing of spring. The ESS is
%%calculated by looking at the minumum point of the gradient of a pairwise
%%invasibility plot
c=clock;
tic
%rng(12345)

%% Set of trait values for mutant and resident combinations to try
trait_values= round(1.25:0.005:1.33,5);%round(3.11:0.01:3.18,5); % use sigma =0 to 9
%trait_values= round(129.5:0.5:130,5);

%% Define vectors for values of E0 and var(E0), noise_values, to try
  mu_h_E_vector= 18;
  sigma_h_E_vector=[10];%*ones(1,size(mu_h_E_vector,2)); %currently respond to place in vector
% 
  [c1,c2] = meshgrid( mu_h_E_vector, sigma_h_E_vector);
  parameter_values = [c1(:) c2(:)];

% Set up number of trials and max_time
num_trials=1; % Next try 5 trials and 500 years
max_time_values=[100];%*ones(1,size(parameter_values,1));

%% Set up vectors to keep track of calculated ESSs and invader fitness
invader_fitness=zeros(size(trait_values,2),size(trait_values,2));
reproductive_timing_matrix =zeros(size(trait_values,2),size(trait_values,2));
reproductive_timing_variance_matrix =zeros(size(trait_values,2),size(trait_values,2));
ESS_output = zeros(size(parameter_values,1),5);
invader_fitness_matrices = zeros(size(trait_values,2),size(trait_values,2),size(parameter_values,1));
reproductive_timing_matrices  = zeros(size(trait_values,2),size(trait_values,2),size(parameter_values,1));

% Load model parameters
p=parameters;

%% Run model for different parameter values

for index=1:size(parameter_values,1)
    rng(12345+index+1) %should this be here? - it should not matter
   %randomE0 = normrnd(parameter_values(index,1),parameter_values(index,2),1,900);
   a = parameter_values(index,1) - parameter_values(index,2);
   b = parameter_values(index,1) + parameter_values(index,2);

   %rare_events = vertcat(8*ones(50,1),28*ones(50,1));
   randomE0 =  a + (b-a).*rand(900,1);
   %randomE0 = [randomE0' , rare_events'];
   %randomE0 = randomE0(randperm(length(randomE0)));
   %randomE0 = poissrnd(parameter_values(index,1),1000,1);
   
   max_time = max_time_values(index);

    %run code to try different resident and mutant trait combinations
    resident_mutant_games_environrule

    %calculate gradient in x and y directions of pairwise invasibility
    invader_fitness(invader_fitness==0)=NaN;
    invader_fitness(invader_fitness<0.95)=NaN;
    [gradx,grady]=gradient(invader_fitness);
    [tmin,tI]=min((min(abs(grady)+abs(gradx),[],2)),[],1);

    if tI==1 || tI==size(trait_values,2) %|| max(max(invader_fitness))<1
        %save model outputs
        ESS_output(index,1) = NaN;
        ESS_output(index,2) = NaN;
        ESS_output(index,3) = NaN;
        ESS_output(index,4) = parameter_values(index,1);
        ESS_output(index,5) = parameter_values(index,2)
    else
        %save model outputs
        ESS_output(index,1) = trait_values(tI);
        ESS_output(index,2) = reproductive_timing_matrix(tI,tI);
        ESS_output(index,3) = reproductive_timing_variance_matrix(tI,tI);
        ESS_output(index,4) = parameter_values(index,1);
        ESS_output(index,5) = parameter_values(index,2)
    end


    invader_fitness_matrices(:,:,index) = invader_fitness;
    reproductive_timing_matrices(:,:,index) = reproductive_timing_matrix;


    %figure(index)
   % plot_new
    %clock - c
    %trait_values = round(trait_values + 0.005,5);
end

beep % Create sound when script is finished
time = clock-c;
toc


%% Save model results so I can export them to R and the main manuscript
% 
% if size(sigma_h_E_vector,2) < 2 
%     if q > 20
%          findESS_table_environ_rule = table(ESS_output(:,1), ESS_output(:,2), ESS_output(:,3),ESS_output(:,4),ESS_output(:,5));
%          findESS_table_environ_rule.Properties.VariableNames= {'ESS' 'RT' 'RT_variability' 'Eini' 'Eini_variability' };
%          writetable(findESS_table_environ_rule, 'model_outputs/findESS_output_table_timing_cue_no_noise.csv','Delimiter',',','QuoteStrings',true)
% 
%          save('model_outputs/findESS_output_invader_fitness_timing_cue_no_noise.mat') %I can pull this into R to work with it
%     else
%          findESS_table_environ_rule = table(ESS_output(:,1), ESS_output(:,2), ESS_output(:,3),ESS_output(:,4),ESS_output(:,5));
%          findESS_table_environ_rule.Properties.VariableNames= {'ESS' 'RT' 'RT_variability' 'Eini' 'Eini_variability' };
%          writetable(findESS_table_environ_rule, 'model_outputs/findESS_output_table_environmental_cue_no_noise.csv','Delimiter',',','QuoteStrings',true)
% 
%          save('model_outputs/findESS_output_invader_fitness_environmental_cue_no_noise.mat') %I can pull this into R to work with it
%     end
% else
%        if q > 20
%          findESS_table_environ_rule = table(ESS_output(:,1), ESS_output(:,2), ESS_output(:,3),ESS_output(:,4),ESS_output(:,5));
%          findESS_table_environ_rule.Properties.VariableNames= {'ESS' 'RT' 'RT_variability' 'Eini' 'Eini_variability' };
%          writetable(findESS_table_environ_rule, 'model_outputs/findESS_output_table_timing_cue_with_noise.csv','Delimiter',',','QuoteStrings',true)
% 
%          save('model_outputs/findESS_output_invader_fitness_timing_cue_with_noise.mat') %I can pull this into R to work with it
%     else
%          findESS_table_environ_rule = table(ESS_output(:,1), ESS_output(:,2), ESS_output(:,3),ESS_output(:,4),ESS_output(:,5));
%          findESS_table_environ_rule.Properties.VariableNames= {'ESS' 'RT' 'RT_variability' 'Eini' 'Eini_variability' };
%          writetable(findESS_table_environ_rule, 'model_outputs/findESS_output_table_environmental_cue_with_noise.csv','Delimiter',',','QuoteStrings',true)
% 
%          save('model_outputs/findESS_output_invader_fitness_environmental_cue_with_noise.mat') %I can pull this into R to work with it
%     end 
% end

