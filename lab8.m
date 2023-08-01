%Lab 8 - File Reading
%Alan Tieng
%CS 109, Spring 2020, Reckinger

clear all;
close all;
clc;

%columns to read from .xlsx file
column_read = ["E" "P" "AA" "AD" "AN" "AP" "AR" "AZ" "BA"];

%init data_pull: array for clumns pulled from .xlsx file
data_read(1:1313,1:length(column_read)) = 0;

%read columns and build array
for i = 1:length(column_read)
    data_read(:,i) = xlsread('FoodInsecurityCookData_2015.xlsx',...
        3,column_read(i)+':'+column_read(i));
end

%remove rows where population or allFoodDesert have 0 values
data_read((data_read(:,3) == 0)|(data_read(:,1) == 0),:) = [];

%split data_pull array into vectors
population = data_read(:,1);
povertyRate = data_read(:,2);
allFoodDesert = data_read(:,3);
lowIncomeFoodDesert = data_read(:,4);
whiteFoodDesert = data_read(:,5);
blackFoodDesert = data_read(:,6);
asianFoodDesert = data_read(:,7);
hispanicFoodDesert = data_read(:,8);
withoutCars = data_read(:,9);

%remove variables not to be saved
clear i data_read column_read;

%save variables into .mat file
save('CookCountyFoodInsecurity');

