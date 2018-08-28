
% Uniforom
a = 12.5;
b = 23.5;
randomE0 =  a + (b-a).*rand(1000,1);
randomE0 = randomE0(randperm(length(randomE0)));
findESS_for_different_e_environrule
%mean(randomE0)
%hist(randomE0)
%hold on

% Normal
variance =3.2;
randomE0 = normrnd(18,variance,1,1000);
randomE0 = randomE0(randperm(length(randomE0)));
findESS_for_different_e_environrule
%mean(randomE0)
%hist(randomE0)
%hold on

% Single point with fat tails
   rare_events = vertcat(8*ones(50,1),28*ones(50,1));
   randomE0 =  18.001 + (18.001-17.999).*rand(900,1);
   randomE0 = [randomE0 ; rare_events];
   randomE0 = randomE0(randperm(length(randomE0)));
   findESS_for_different_e_environrule
%   mean(randomE0)
%   hist(randomE0)
%   hold on

   
% Normal with fat tails
rare_events = vertcat(8*ones(50,1),28*ones(50,1));
variance =0.3;
randomE0 = normrnd(18,variance,1,900);
randomE0 = [randomE0' ; rare_events];
randomE0 = randomE0(randperm(length(randomE0)));
findESS_for_different_e_environrule
%mean(randomE0)
%hist(randomE0)
%hold on


% Only fat tails
randomE0 = vertcat(14.8*ones(500,1),21.2*ones(500,1));
randomE0 = randomE0(randperm(length(randomE0)));
findESS_for_different_e_environrule
%mean(randomE0)
%hist(randomE0)


% Skew to right distributions
% rare_events = 28*ones(100,1);
% meaniance =1.07;
% randomE0 = normrnd(18,meaniance,1,900);
% randomE0 = [randomE0' ; rare_events];
% mean(randomE0)
% hist(randomE0)
% hold on
% 
% 
% % Skew to left distributions
% rare_events = 8*ones(100,1);
% meaniance =1.07;
% randomE0 = normrnd(18,meaniance,1,900);
% randomE0 = [randomE0' ; rare_events];
% mean(randomE0)
% hist(randomE0)
% hold on
