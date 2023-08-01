%Lab 8 - File Reading
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

column_pull = ["E" "P" "AA" "AD" "AN" "AP" "AR" "AZ" "BA"];
%{
column_names = ["population" "povertyRate" "allFoodDesert" 
    "lowIncomeFoodDesert" "whiteFoodDesert" "blackFoodDesert" 
    "asianFoodDesert" "hispanicFoodDesert" "withoutCars"];
%}
data_pull(1:1313,1:length(column_pull)) = 0;
for i = 1:length(column_pull)
    data_pull(:,i) = xlsread('FoodInsecurityCookData_2015.xlsx',...
        3,column_pull(i)+':'+column_pull(i));
end
data_pull((data_pull(:,3) == 0)|(data_pull(:,1) == 0),:) = [];
%{
for i = 1:length(column_pull)
    assignin('base', char(column_names(i)), data_pull(:,i));
end
%}
population = data_pull(:,1);
povertyRate = data_pull(:,2);
allFoodDesert = data_pull(:,3);
lowIncomeFoodDesert = data_pull(:,4);
whiteFoodDesert = data_pull(:,5);
blackFoodDesert = data_pull(:,6);
asianFoodDesert = data_pull(:,7);
hispanicFoodDesert = data_pull(:,8);
withoutCars = data_pull(:,9);
clear i data_pull_array column_pull;
save('CookCountyFoodInsecurity');

