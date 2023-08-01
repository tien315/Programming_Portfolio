%Lab 10 - Applying Numerical Integration to Lift
%Alan Tieng
%CS 109, Spring 2020, Reckinger

%This function lab10 loads a dataset of pressures across an airfoil surface
%at 4 different angles of attack.  It plots p vs. x for four sets of data
%and calculates and plots overall force using built in function trapz and
%my_trapz, a user created function that is similar to trapz.

function lift_force = lab10(file)
    load(file);
    
    %combine data into 2D array for easy looping/manipulation
    comb_array = [pBOT_0; pTOP_0; pBOT_4; pTOP_4; pBOT_8; pTOP_8;...
        pBOT_16; pTOP_16; x'];
    angles = [0, 4, 8, 16];%the angles of attack
    
    
    
    %step 2****************************************************************
    %plot pressures for all four angles of attacks across wing surface
    for i = 1:4
        plot_step2(i, comb_array(i*2-1, :), comb_array(i*2, :),...
            comb_array(end, :), angles(i));
    end
    %**********************************************************************
    
    
    
    %step 3****************************************************************
    %calculate overall force using function trapz
    lift_force_step3 = 1:length(angles);
    for i = 1:length(angles)
        lift_force_step3(i) = -sind(90-angles(i))*...
            (trapz(comb_array(end, :), comb_array(i*2-1, :) )...
            + trapz(comb_array(end, :), comb_array(i*2, :)));
    end
    figure;
    plot(angles, lift_force_step3, 'bs', 'MarkerFaceColor', 'black');
    ylabel("Lifting Force");
    xlabel("Angle of Attack (degrees)");
    grid on;
    %**********************************************************************
    
    
    
    %step 4****************************************************************
    %repeat step 3 with function my_trapz
    lift_force = 1:length(angles);
    for i = 1:length(angles)
        lift_force(i) = -sind(90-angles(i))*...
            (my_trapz(comb_array(end, :), comb_array(i*2-1, :) )...
            + my_trapz(comb_array(end, :), comb_array(i*2, :)));
    end
    
    figure;
    plot(angles, lift_force, 'bs', 'MarkerFaceColor', 'black');
    ylabel("Lifting Force");
    xlabel("Angle of Attack (degrees)");
    grid on;
    %**********************************************************************
end

%This function plot_step2 is called in a loop that builds a 4x4 plot of 
%p vs. x data on 4 different angles of attack.
%INPUTS
%sub_pos - The loop that will call this function will input the subplot
%position on a 4x4 grid here.
%y_data_bot - the pressure data array for the bottom
%y_data_top - the pressure data array for the top
%x_data - the position data array
%angle_title - the angle of attack
%OUTPUT
%This function does not have an output.
function plot_step2(sub_pos, y_data_bot, y_data_top, x_data, angle_title)
    subplot(2,2,sub_pos);
    hold on;
    plot(x_data',y_data_bot, 'b-')
    plot(x_data',y_data_top, 'r--')
    legend("Bottom", "Top", 'Location', 'southeast');
    ylim([-2.5 1])
    ylabel('Pressure');
    xlabel('Airfoil chord length (%)');
    title("\alpha = " + angle_title + "\circ");
end

%This function my_trapz calculates the approximation of an integral using
%the trapezoidal method.
%INPUTS
%x - x data
%y - y data
%OUTPUT
%approx_integral - the approximated integral of y with respect to x using
%the trapezoidal method.
function approx_integral = my_trapz(x,y)

    approx_integral = 0;
    for i = 1:length(x)-1
       approx_integral = approx_integral + (y(i)+y(i+1))/2 * (x(i+1)-x(i)); 
    end

end
