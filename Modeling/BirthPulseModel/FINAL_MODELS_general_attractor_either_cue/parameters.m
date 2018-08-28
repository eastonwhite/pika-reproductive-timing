%% Created by Easton White
%Created on: 22-Jul-2016
%Last edited: 10-May-2017

%This code defines parameter values to be used in adaptive dynamics models
%of pikas


%% Parameter values estimated for per day values (see Supp Mat file and main text)
function p=parameters

  % Environmental parametes
  %p.epsilon = 0.2;
  %p.E_max = 18;
  %p.h_E = 30;
  p.e =0.02;

  % Within-year pika survival parameters
  p.mu_A =0.001;
  p.k=1; % e3rqul5 =0.1
  p.u_J = 0.001; % need to estimate these parameters
  p.u_E = 0.005; % default 0.005

  % Resource and resource-uptake parameters
  p.w_J = 1/3;
  p.beta_J = 0.0015;
  p.w_A = 1/3;
  p.beta_A = 0.0015;
  p.a_A=3;
  p.h_A=0;%0.002;%0.00625; %non fixed point when handling time>0
  p.a_J=3;%3 ;
  p.h_J=0;%0.002;%0.00625;
  p.r=0.044;
  p.K=150;

  % Pika birth rate (number females per female)
  p.birth_rate=1.5;


  % Over-winter survival parameters
  p.sigma_A=0.9;%max survival from COSEWIC 2011
  p.k_A=2500;
  p.sigma_J=0.9; %max survival from COSEWIC 2011
  p.k_J=2500;


end
