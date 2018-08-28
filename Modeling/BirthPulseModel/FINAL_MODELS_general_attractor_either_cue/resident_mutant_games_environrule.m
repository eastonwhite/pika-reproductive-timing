%% Created by Easton R White
%Date created 24-Jun-2016
%Date edited 10-May-2017

%this code is now used by the findESS_for_different_e.m script to
%determinine invader fitness in a landscape set by a resident

%the code first has to determine the resident equilbrium value and only
%does so if the resident is viable (grows when small pop size)

previous_resident_equilbrium=0.001; %sets value of equilbrium to start with, speeds up code

%%
for q=round(trait_values,5)
    if q > 20
      resident_timing = q;
    else
      resident_timing = (-1/p.e)*log(q/randomE0(1));
    end

    %check to see if resident population would even be viable with
    %particular parameter combination. If not, move on to next parameter
    %combination
    if determine_viability(q,p,randomE0)<1
        invader_fitness(find(trait_values==q),:)=NaN;
       % 'broken'
    else
        %calculate the resident equilbrium value, if it does not settle to a fixed point, than mark fitness with NaN
        [resident_equilbrium, time_to_completion]=find_resident_equilbrium(100,q,p,randomE0,previous_resident_equilbrium);
        previous_resident_equilbrium = mean(resident_equilbrium);



    %%%%%Find invader fitness%%%%%
    for qq = round((q-(15*(trait_values(2)-trait_values(1)))):(trait_values(2)-trait_values(1)):(q+(15*(trait_values(2)-trait_values(1)))),5)
        %calculate invader fitness for different invader trait values with
        %current resident trait value
        q_index = find(round(trait_values,5)==q);
        qq_index = find(round(trait_values,5)==qq);
        if isempty(qq_index)==false
            [invader_fitness(q_index,qq_index),reproductive_timing_matrix(q_index,qq_index),reproductive_timing_variance_matrix(q_index,qq_index)] = calc_mutant_fitness(q, qq,p,resident_equilbrium,max_time,num_trials,randomE0);
        end
    %end
    end
    end
%q
%clock - c
end
