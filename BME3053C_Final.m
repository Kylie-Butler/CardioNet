%% Retrying 
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
    
    %Normalize features
    features = [Age, Sex, Chest_Pain, Rest_BP, Cholesterol, Fasting_BS, Max_HR, ExInd_Agnia, Thal];
    features = mapminmax(features)';
    
    %% Neural Network Training
    CardioNet = feedforwardnet([10 5]);
    CardioNet.trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation
    CardioNet.trainParam.showWindow = true;
    targets = Disease(1:275)';
    [CardioNet, tr] = train(CardioNet, features(:,1:275), targets);
    
    %% Specify Division of Data
    CardioNet.divideParam.trainRatio = 0.7;
    CardioNet.divideParam.valRatio = 0.15;
    CardioNet.divideParam.testRatio = 0.15;
    
%% Test
count = 0;
for ii = 276:297
    output = CardioNet(features(:,ii))
    real = Disease(ii)
    if (output<0.5 && real==0) || (output>=0.05 && real==1)
        fprintf('Successful Prediction')
        count = count + 1;
    else
        fprintf('Incorrect Prediction')
    end
end
succcess_rate = count/(297-275);
save CardioNet
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