%% Training the CardioNet Neural Network
% Author: Madeleine McCreary
% Group Members: Kylie Butler, Andrew Dodds
% Course: BME 3053C Computer Applications for BME
% Term: Fall 2023
% J. Crayton Pruitt Family Department of Biomedical Engineering
% University of Florida
% Email: mmccreary@ufl.edu
% December 4, 2023

%% Import dataset
Heart_Data = readtable("Cleveland_Heart_Data.xlsx");
Age = table2array(Heart_Data(:,1));
Sex = table2array(Heart_Data(:,2));
Chest_Pain = table2array(Heart_Data(:,3));
Rest_BP = table2array(Heart_Data(:,4));
Cholesterol = table2array(Heart_Data(:,6)); 
Fasting_BS = table2array(Heart_Data(:,5));
Max_HR = table2array(Heart_Data(:,8));
ExInd_Agnia = table2array(Heart_Data(:,9));
Thal = table2array(Heart_Data(:,13));
Disease = table2array(Heart_Data(:,14));
    
%% Normalize features
features = [Age, Sex, Chest_Pain, Rest_BP, Cholesterol, Fasting_BS, Max_HR, ExInd_Agnia, Thal];
features = mapminmax(features)';
    
%% Neural Network Training
CardioNet = feedforwardnet([10 5]);
CardioNet.trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation
CardioNet.trainParam.showWindow = true;
targets = Disease(1:267)';
[CardioNet, tr] = train(CardioNet, features(:,1:267), targets);

%% Specify Division of Data
CardioNet.divideParam.trainRatio = 0.7;
CardioNet.divideParam.valRatio = 0.15;
CardioNet.divideParam.testRatio = 0.15;
    
%% Test
count = 0;
true_pos = 0;
true_neg = 0;
false_neg = 0;
false_pos = 0;

for ii = 268:297
    output = CardioNet(features(:,ii))
    real = Disease(ii)
    if output<0.5 && real==0
        true_neg = true_neg + 1;
        fprintf('Successful Prediction')
        count = count + 1;
    elseif output>=0.5 && real==1
        true_pos = true_pos + 1;
        fprintf('Successful Prediction')
        count = count + 1;
    elseif output>=0.5 && real==0;
        fprintf('Incorrect Prediction')
        false_pos = false_pos + 1;
    elseif output<0.5 && real==1
        fprintf('Incorrect Prediction')
        false_neg = false_neg + 1;
    end
end
succcess_rate = count/(297-267);
filename = 'CardioNet.mat';
save(filename, 'CardioNet');
%     %% View the trained network
%     view(net);
%     
%     %% Display information about the first and second layers
%     net.layers{1}
%     net.layers{2}
%     
%     %% Display the learned weights and biases
%     LWeights = net.LW
%     biases = net.b