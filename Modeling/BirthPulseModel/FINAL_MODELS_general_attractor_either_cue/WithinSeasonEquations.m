%% set of odes for within season dynamics

%Created by Easton White
%Date created 24-Jun-2016
%Last edited: 10-May-2017

%This code sets up 10 ODEs. The function is called by other scripts to run
%within-season population dynamics
    
    
% % Holling type two funciton (unless h_A is set to zero, then it is type
% I)
     function dx = WithinSeasonEquations(t, x,p)
  %set of 10 ODEs in vector dx
      dx = [-p.e*x(1);                                                                 %environment
           -p.mu_A * x(2) ;                                                            %adult abundance
           -(p.u_J + p.u_E*x(1)/(p.k+x(1)))*x(3);                                      %juvenile abundance
            p.w_J*x(6)*p.a_J/(1+p.a_J*p.h_J*x(6)) - p.beta_J*x(4);                     %juvenile body condition
            p.w_A*x(6)*p.a_A/(1+p.a_A*p.h_A*x(6)) - p.beta_A*x(5);                     %adult body condition
            p.r*x(6)*(1- (x(6)/p.K)) - x(2)*x(6)*p.a_A/(1+p.a_A*p.h_A*x(6)) - x(3)*x(6)*p.a_J/(1+p.a_J*p.h_J*x(6)); %plant density
            -p.mu_A * x(7) ;                                                           %mutant adult abundance
           -(p.u_J + p.u_E*x(1)/(p.k+x(1)))*x(8);                                      %mutant juvenile abundance
            p.w_J*x(6)*p.a_J/(1+p.a_J*p.h_J*x(6)) - p.beta_J*x(9);                     %mutant juvenile body condition
            p.w_A*x(6)*p.a_A/(1+p.a_A*p.h_A*x(6)) - p.beta_A*x(10)];                   %mutant adult body condition

