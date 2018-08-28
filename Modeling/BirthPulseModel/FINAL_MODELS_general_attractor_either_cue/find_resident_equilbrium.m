%% Created by Easton White
%Date created 24-Jun-2016
%Last edited: 22-Jul-2016

%% this is a function to find the equilbrium resident strategy for any set of
%values. Currently, it is only set up to find fixed pount equilbriums, but
%this could be easily relaxed


%% Define function. Returns resident equilibrium and time to completion
function [resident_equilbrium, time_to_completion] = find_resident_equilbrium(years,q,p,randomE0,previous_resident_equilbrium)

    if q > 20
      resident_timing = q;
    else
      resident_timing = (-1/p.e)*log(q/randomE0(1));
    end

      times = [0 resident_timing 170];
      years=years;

      find_resident_equilbrium_iterate_between_seasons
     %plot(res_ini_abundance,'ro');
      resident_equilbrium = res_ini_abundance(round(0.4*years):years) ;
      time_to_completion = size(res_ini_abundance,1); %number of years to loop break

end
