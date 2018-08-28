
%randomE0 = normrnd(30,1,1,300)


surf(repmat(trait_values,size(trait_values,2),1)',repmat(trait_values,size(trait_values,2),1),invader_fitness)
  colormap(bone(2))
  colorbar
  caxis([0, 2])
view(0,90)
 xlabel('resident trait','FontSize',12,'FontWeight','bold')
 ylabel('invader trait','FontSize',12,'FontWeight','bold')
 zlabel('invader fitness','FontSize',12,'FontWeight','bold')
grid off
%  figure(2)
%   contourf(repmat(trait_values,size(trait_values,2),1)',repmat(trait_values,size(trait_values,2),1),invader_fitness,'LineStyle','none')
%   colormap(bone(2))
%   colorbar
%   caxis([0, 2])
 
 
 
 
 
 
 
%% Additional plotting options
 %invader_fitness(logical(eye(size(invader_fitness)))) = 1;
%  surf(repmat(trait_values,size(trait_values,2),1)',repmat(trait_values,size(trait_values,2),1),invader_fitness)
%  xlabel('resident trait')
%  ylabel('mutant trait')
%  zlabel('mutant fitness')
% %
% colorbar
%could also plot gradient(invader_fitness) for color to indicate steepness

%option to do contour plot
%  contourf(repmat(trait_values,size(trait_values,2),1)',repmat(trait_values,size(trait_values,2),1),invader_fitness,'LineStyle','none')
%  colormap(hot(2))
%  colorbar
%  caxis([0, 2])

%Adds projected image on x-y plane of PIP
% SX=size(repmat(trait_values,size(trait_values,2),1)');
% Z3=0.5*ones(SX);
% hold on
% surf(repmat(trait_values,size(trait_values,2),1)',repmat(trait_values,size(trait_values,2),1),Z3,invader_fitness)
