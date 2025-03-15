%Exotic Combined Cycle Generator Optimization Test
%4/17/2021

%{
This script will calculate the states of the combined cycle generator and
test the thermal efficiency for different combinations of 3 variables: 
The pressure ratio between states one and two (P1/P2), the pressure at
at state 8 (P8), the temperature at state 8 (T8), and the pressure at state
9 (P9). The saturated liquid at state 11 will be assumed to have a quality 
of 'Q'=0.

The script will perform the above for the following 3 working fluids in the
organic Rankine cycle: propane, R134a, and water.

Pressures (P) in Pa
Temperatures (T) in K
Enthalpies (H) in J/kg
Entropies (S) in J/(kg*K)

The desired values will be stored in:
n_final for the maximum efficiency
sel2 = [P2/P1 P9 P8 T8 n_final] for the variable values 

GTC = Gas Turbine Cycle
ORC = Organic Rankine Cycle
%}

close all
clear all
clc

%**************************************************************************
%**************************************************************************
%**************************************************************************
%evaluate which fluids? 
%1 - Propane 
%2 - R134a 
%3 - Water 
%Enter number(s) into array as separate elements in the order they are to 
%be evaluated. Ex: [3 1] for Water, then Propane or [2] for only R134a.
run_fluid = [1];

%Use full range and default increments?
def_grid_bool = true;

%User specified values:
%P2/P1 Ratios
ratio_range = [4];
%Increment temperature, range 
T_inc = 10; %K
T_min = [290 169.85 273.16];%MIN[85.525 169.85 273.16]
T_max = [300 669.770 669.770]; % MAX[669.770 669.770 669.770]
%Increment pressure, range
%MIN[0.001718484089308612 389.564 611.655]
%MAX[4251200 4059280 22064000]
P_inc = 10000; %Pa
P_range8 = [855100 389.564 611.655; 855500 4059280 22064000];
P_range9 = [2900 389.564 611.655; 3300 4059280 22064000];
%**************************************************************************
%**************************************************************************
%**************************************************************************


%Given variable and constraints
%**************************************************************************
n_reg = 0.80; %regenerator efficiency (GTC)
n_comp = 0.85; %compressor efficiency (GTC)
n_turb = 0.85; %turbine efficiency (GTC and ORC)
n_pump = 0.85; %pump efficiency (ORC)
n_gen = 0.95; %generator efficiency (GTC and ORC)

%given values for states in GTC
T1 = 300; %K
P1 = 100000; %Pa
P5 = P1;
P6 = P1;
P7 = P1;
T4 = 1200; %K
w_e_GTC = 100000; %W
w_GTC = w_e_GTC/n_gen; %W
H1 = 300190; %J/kg
S1 = 1702.03; %J/(kg*K)

%no given values for ORC, only the relations:
%P7=P1 and T7=T8+20K

fluid = ["Propane" "R134a" "Water"];

%set default values
if def_grid_bool
    [P_range8, P_range9, T_min, T_inc, ratio_range, P_inc] = default_range();
end
%**************************************************************************


for f = run_fluid
    n_final = 0; %initialize to lowest possible value for each fluid
    %For whole number iterations of P2/P1, it was determined that at above 
    %14, the heat flow for the regenerator was reversed.
    for i = ratio_range
       P2 = i*P1;
       P3 = P2;
       P4 = P2;
       T2s = T1*i^(0.4/1.4);
       T2 = T1-(T1-T2s)/n_comp;
       H2s = 1.005*(T2s-T1)*1000+H1;
       H2 = H1-(H1-H2s)/n_comp;
       H4 = 1277790;
       T5s = T4*(1/i)^(0.4/1.4);
       T5 = T4-(T4-T5s)*n_turb;
       H5s = 1.005*(T5s-T4)*1000+H4;
       H5 = H4-n_turb*(H4-H5s);
       T3 = T2+n_reg*(T5-T2);
       H3 = H2+n_reg*(H5-H2);
       T6 = T5-(T3-T2);
       H6 = H5-(H3-H2);
       
       mdot_GTC = w_GTC/(H4-H5-H2+H1);
       q_in = mdot_GTC*(H4-H3);
       clc;

       for j = P_range9(1,f):P_inc:P_range9(2,f)
           P9 = j;
           P10 = P9;
           if(P_range8(1,f)>j)
               P8_low = P_range8(1,f);
           else
               P8_low = j;
           end
           for k = P8_low:P_inc:P_range8(2,f)
               P8 = k;
               P11 = P8;
               clc;
               fprintf('Processing %s...\n',fluid(f));
               fprintf('Processing P2/P1 ratio %d...\n',i);
               fprintf('Processing P9 %d...\n',j);
               fprintf('Processing P8 %d...\n',k);

               %the loop begins at the lowest temperature pre turbine that
               %still allows temperature post turbine to be above freezing.
               if (def_grid_bool)
                   T_max = [T6-20 T6-20 T6-20];
               end
               
               for l = T_min(f):T_inc:T_max
                   T8 = l;
                   if py.CoolProp.CoolProp.PhaseSI('T',T8,'P',P8,fluid(f))=='gas'||...
                           py.CoolProp.CoolProp.PhaseSI('T',T8,'P',P8,fluid(f))=='supercritical_gas'
                           
                       T7 = T8+20;
                       H7 = H6-1.005*(T6-T7)*1000;
                       H8 = py.CoolProp.CoolProp.PropsSI('H','P',P8,'T',T8,fluid(f));
                       S8 = py.CoolProp.CoolProp.PropsSI('S','P',P8,'T',T8,fluid(f));
                       H9s = py.CoolProp.CoolProp.PropsSI('H','P',P9,'S',S8,fluid(f));
                       H9 = H8-n_turb*(H8-H9s);
                       T9 = py.CoolProp.CoolProp.PropsSI('T','P',P9,'H',H9,fluid(f));
                       T10 = py.CoolProp.CoolProp.PropsSI('T','P',P10,'Q',0,fluid(f));
                       H10 = py.CoolProp.CoolProp.PropsSI('H','P',P10,'Q',0,fluid(f));
                       S10 = py.CoolProp.CoolProp.PropsSI('S','P',P10,'Q',0,fluid(f));
                       H11s = py.CoolProp.CoolProp.PropsSI('H','P',P11,'S',S10,fluid(f));
                       H11 = H10+(H11s-H10)/n_pump;
                       T11 = py.CoolProp.CoolProp.PropsSI('T','P',P11,'H',H11,fluid(f));
                       mdot_ORC = mdot_GTC*(H6-H7)/(H8-H11);
                       w_ORC = mdot_ORC*(H8-H9-H11+H10);
                       w_e_ORC = w_ORC*n_gen;
                       n_system = (w_e_GTC + w_e_ORC)/q_in;
                       if (n_final < n_system) && is_valid(mdot_ORC,...
                               mdot_GTC,T2,T3,T4,T5,T6,T7,T8,T9,T11,P9,P10,H9,H10,S8,S10,fluid(f),w_GTC,w_ORC)
                           n_final = n_system;
                           
                           sel2(f,1) = i;
                           sel2(f,2) = j;
                           sel2(f,3) = k; 
                           sel2(f,4) = l;
                           sel2(f,5) = n_final;


                           sel(2,f+1) = P1;
                           sel(3,f+1) = P2;
                           sel(4,f+1) = P2;
                           sel(5,f+1) = P3;
                           sel(6,f+1) = P4;
                           sel(7,f+1) = P5;
                           sel(8,f+1) = P5;
                           sel(9,f+1) = P6;
                           sel(10,f+1) = P7;
                           sel(11,f+1) = P8;
                           sel(12,f+1) = P9;
                           sel(13,f+1) = P9;
                           sel(14,f+1) = P10;
                           sel(15,f+1) = P11;
                           sel(16,f+1) = P11;
                           
                           sel(2,f+2) = T1;
                           %sel(3,f+2) = T2s;
                           sel(4,f+2) = T2;
                           sel(5,f+2) = T3;
                           sel(6,f+2) = T4;
                           %sel(7,f+2) = T5s;
                           sel(8,f+2) = T5;
                           sel(9,f+2) = T6;
                           sel(10,f+2) = T7;
                           sel(11,f+2) = T8;
                           %sel(12,f+2) = T9s;
                           sel(13,f+2) = T9;
                           sel(14,f+2) = T10;
                           %sel(15,f+2) = T11s;
                           sel(16,f+2) = T11;
                           
                           sel(2,f+3) = H1;
                           sel(3,f+3) = H2s;
                           sel(4,f+3) = H2;
                           sel(5,f+3) = H3;
                           sel(6,f+3) = H4;
                           sel(7,f+3) = H5s;
                           sel(8,f+3) = H5;
                           sel(9,f+3) = H6;
                           sel(10,f+3) = H7;
                           sel(11,f+3) = H8;
                           sel(12,f+3) = H9s;
                           sel(13,f+3) = H9;
                           sel(14,f+3) = H10;
                           sel(15,f+3) = H11s;
                           sel(16,f+3) = H11;
                           
                           sel(2,f+4) = S1;
                           %sel(6,f+4) = S4;
                           sel(11,f+4) = S8;
                           sel(14,f+4) = S10;
                           
                           sel(11,f+5) = w_GTC;
                           sel(12,f+5) = w_e_ORC;
                           sel(13,f+5) = w_ORC;
                           sel(14,f+5) = mdot_GTC;
                           sel(15,f+5) = mdot_ORC;
                           sel(16,f+5) = q_in;
                           sel(17,f+5) = n_final;
                           
                       end
                   end
               end          
           end
       end
    end
end

%This function check the validity of the cycle by verifying no impossible
%or undesired conditions occur.
function check = is_valid(mdot_ORC,mdot_GTC,T2,T3,T4,T5,T6,T7,T8,T9,T11,...
    P9,P10,H9,H10,S8,S10,fluid,w_GTC,w_ORC)

check = true;

%Check if ORC turbine exhaust quality >= .9
if (py.CoolProp.CoolProp.PropsSI('Q','P',P9,'H',H9,fluid)<.9)&&...
        ((py.CoolProp.CoolProp.PhaseSI('P',P9,'H',H9,fluid)~='gas')&&...
        (py.CoolProp.CoolProp.PhaseSI('P',P9,'H',H9,fluid)~='supercritical_gas'))
    fprintf("FAIL 1")   
    check = false;
    return
end

%the check for vapor state in state 8 is built in to the temperature loop
%to reduce computation time.

%check for reverse flows
if (mdot_ORC<0)||(mdot_GTC<0)
    check = false;
    return
end

%check for correct heat flow direction in regenerator (pre-combustor)
if (T3-T2)<0
    check = false;
    return
end

%check for correct heat flow direction in combustor
if (T4-T3)<0
    check = false;
    return
end

%check for correct heat flow direction in regenerator (turbine exhaust)
if (T5-T6)<0
    check = false;
    return
end

%check for correct heat flow direction in evaporator (turbine exhaust)
if (T6-T7)<0
    check = false;
    return
end

%check for correct heat flow direction in evaporator (ORC)
if (T8-T11)<0
    check = false;
    return
end

%check correct heat flow direction in condenser
if T9<py.CoolProp.CoolProp.PropsSI('T','P',P10,'Q',0,fluid)
    check = false;
    return
end

%check negative value in H10
if H10<0
    check = false;
    return
end


%check that neither cycle is drawing electricity
if (w_GTC<0)||(w_ORC<0)
    check = false;
    return
end

if S8<0
    check = false;
    return
end

if S10<0
    check = false;
    return
end

if mdot_ORC > 6
    check = false;
    return
end

end

%This function will set pressure and temperature test ranges and increments
%to the default values.
function [P_range8, P_range9, T_min, T_inc, ratio_range, P_inc] = default_range()
%determining upper and lower pressure bounds for the condenser based on T1

P_range9 = [py.CoolProp.CoolProp.PropsSI('PTRIPLE','Propane')...
           py.CoolProp.CoolProp.PropsSI('PTRIPLE','R134a')...
           py.CoolProp.CoolProp.PropsSI('PTRIPLE','Water');...
           py.CoolProp.CoolProp.PropsSI('PCRIT','Propane')...
           py.CoolProp.CoolProp.PropsSI('PCRIT','R134a')...
           py.CoolProp.CoolProp.PropsSI('PCRIT','Water')];
P_range8 = P_range9;
T_min = [py.CoolProp.CoolProp.PropsSI('TTRIPLE','Propane')...
        py.CoolProp.CoolProp.PropsSI('TTRIPLE','R134a')...
        py.CoolProp.CoolProp.PropsSI('TTRIPLE','Water')];
T_inc = 10;   
ratio_range = [2:14];
P_inc = 100000;
end
