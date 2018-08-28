%Created by Easton R White
%Date created 24-Jun-2016
%Date edited 15-Aug-2016

%This code tests to see if a particular parameter set is even viable for a
%resident population. This helps prevent trying to find the resident
%equilibrium if the trait combination is not even viable

function [viable] = determine_viability(q,p,randomE0)
    %condition where if timing is less than or greater than season
    %boundaries, then the population cannot give birth and is not viable
    %if resident_timing>=170 || resident_timing<=0
       % viable=0;
    %else
         %this condition looks at the growth rate of a very small
         %population, which should be positive if it is viable
         %plot(find_resident_equilbrium(100,q,p,randomE0,initial_pop))
        pop_size = find_resident_equilbrium(100,q,p,randomE0,0.0000001); 
        if prod(pop_size(2:size(pop_size,1))./pop_size(1:(size(pop_size,1)-1)))^(1/size(pop_size,1))>1
             viable=1;
         else
             viable=0;
             %'not viable timing'
         end
     %end
end
