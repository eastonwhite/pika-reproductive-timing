
%Created by Easton White
%Last edited 13-Aug-2016

%this code looks for combinations of k and u_J that minimize the error between model predictions of 

k_values=linspace(0.01,1,100);
u_J_values=linspace(0.01,0.5,100);

for zed=1:100
    
    
    for zed2=1:100
       
       p.k =k_values(zed);
       p.u_J = u_J_values(zed2);
       
       determine_juvenile_mortality_script
       juvenile_survival(zed,zed2) = state_total(size(state_total,1),3)/max(state_total(:,3));
        
    end
end

[M,I] = min(abs(juvenile_survival(:)-0.74));
[I_row, I_col] = ind2sub(size(juvenile_survival),I);

k_values(I_row)
u_J_values(I_col)

contourf(u_J_values,k_values,abs(juvenile_survival-0.74))
ylabel('half saturation parameter')
xlabel('mild winter juvenile mortality rate')

hold on
plot(u_J_values(I_col),k_values(I_row),'*r','MarkerSize',30)