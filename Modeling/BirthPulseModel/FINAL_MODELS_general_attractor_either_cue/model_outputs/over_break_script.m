% 
% 
%over spring break script to run lots

%% Setup 1 environ cue with noise

 mu_h_E_vector= 18;
 sigma_h_E_vector=sort(0:0.5:10,'descend');%1*ones(1,size(mu_h_E_vector,2)); %currently respond to place in vector

 [c1,c2] = meshgrid( mu_h_E_vector, sigma_h_E_vector);
 parameter_values = [c1(:) c2(:)];

num_trials=10; % Next try 5 trials and 500 years
max_time_values=100*ones(1,size(parameter_values,1));

trait_values= round(3.1:0.0025:3.18,5); % use sigma =0 to 9
%trait_values= round(86:0.05:87.5,5);

findESS_for_different_e_environrule
% 
% %% Setup 2 timing cue with noise
% 
%  mu_h_E_vector= 18;
%  sigma_h_E_vector=0:0.5:10;%1*ones(1,size(mu_h_E_vector,2)); %currently respond to place in vector
% 
%  [c1,c2] = meshgrid( mu_h_E_vector, sigma_h_E_vector);
%  parameter_values = [c1(:) c2(:)];
% 
% num_trials=1; % Next try 5 trials and 500 years
% max_time_values=500*ones(1,size(parameter_values,1));
% 
% %trait_values= round(3.05:0.01:3.2,5); % use sigma =0 to 9
% trait_values= round(85:0.025:87.5,5);
% 
% 
% findESS_for_different_e_environrule








%% Setup 3 environ cue no noise

 mu_h_E_vector= 10:0.5:22;
 sigma_h_E_vector=0;%1*ones(1,size(mu_h_E_vector,2)); %currently respond to place in vector

 [c1,c2] = meshgrid( mu_h_E_vector, sigma_h_E_vector);
 parameter_values = [c1(:) c2(:)];

num_trials=1; % Next try 5 trials and 500 years
max_time_values=10*ones(1,size(parameter_values,1));

trait_values= round(1.9:0.01:4,5); % use sigma =0 to 9
%trait_values= round(85:0.025:87.5,5);

findESS_for_different_e_environrule

%% Setup 4 timing cue no noise

 mu_h_E_vector= 10:0.5:22;
 sigma_h_E_vector=0;%1*ones(1,size(mu_h_E_vector,2)); %currently respond to place in vector

 [c1,c2] = meshgrid( mu_h_E_vector, sigma_h_E_vector);
 parameter_values = [c1(:) c2(:)];

num_trials=1; % Next try 5 trials and 500 years
max_time_values=25*ones(1,size(parameter_values,1));

%trait_values= round(1.5:0.05:4,5); % use sigma =0 to 9
trait_values= round(80:0.1:90,5);

findESS_for_different_e_environrule