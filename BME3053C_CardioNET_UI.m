%% CardioNet
% Author: Madeleine McCreary
% Group Members: Kylie Butler, Andrew Dodds
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2023
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida
% Email: mmccreary@ufl.edu
% December 4, 2023

fprintf(['Welcome to CardioNet! Begin entering patient info below \n']);

%% Ask for user inputs
age = input('Age: ');
sex = input('Sex (M or F): ', 's');
if strcmp(sex,'M') == 1
    sex = 1;
else
    sex = 0;
end
chest_Pain = input('Chest Pain Type (0-3): ');
rest_BP = input('Resting Blood Pressure [mmHg]: ');
cholesterol = input('Serum Cholesterol [mg/dl]: ');
fasting_BS = input('Fasting Blood Sugar > 120 mg/dl (Y or N): ', 's');
if strcmp(fasting_BS,'Y') == 1
    fasting_BS = 1;
else
    fasting_BS = 0;
end
max_HR = input('Maximum Heartrate: ');
exInd_Angina = input('Exercise Induced Angina (Y or N): ', 's');
if strcmp(exInd_Angina,'Y') == 1
    exInd_Angina = 1;
else
    exInd_Angina = 0;
end
thal = input('Thalamus Stress results (0-7): ');

Heart_Data = readtable("Cleveland_Heart_Data.xlsx");
Age = [table2array(Heart_Data(:,1)); age];
Sex = [table2array(Heart_Data(:,2)); sex];
Chest_Pain = [table2array(Heart_Data(:,3)); chest_Pain];
Rest_BP = [table2array(Heart_Data(:,4)); rest_BP];
Cholesterol = [table2array(Heart_Data(:,6)); cholesterol]; 
Fasting_BS = [table2array(Heart_Data(:,5)); fasting_BS];
Max_HR = [table2array(Heart_Data(:,8)); max_HR];
ExInd_Angina = [table2array(Heart_Data(:,9)); exInd_Angina];
Thal = [table2array(Heart_Data(:,13)); thal];

    
%% Normalize features
Features1 = [Age, Sex, Chest_Pain, Rest_BP, Cholesterol, Fasting_BS, Max_HR, ExInd_Angina, Thal];
Features1 = mapminmax(Features1)';

%% Load pre-trained Neural Network and run new data
load('CardioNet_90.mat');

output = CardioNet(Features1(1:9,298));

%% Interpretation of neural network results
if output<0.3
    fprintf('The patient is not at risk of Coronary Artery Disease \n')
elseif output>=0.3&&output<=0.7
    fprintf('The patient has a moderate risk of Coronary Artery Disease. Further testing required. \n')
else 
    fprintf('The patient is at high risk of Coronary Artery Disease. Please refer to cardiologist. \n')
end
