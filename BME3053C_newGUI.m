%% Test Run
start = 0;
OpeningGUI = uifigure('Name', 'OpeningGUI');  
    %Changes mouse to crosshair   
    OpeningGUI.Pointer = 'crosshair';    
    %The following 3 lines add text to the GUI   
    label1 = uilabel(OpeningGUI, 'Position', [25 375 500 50], 'Text', 'CardioNet');    
    label2 = uilabel(OpeningGUI, 'Position', [25 350 500 50], 'Text', 'Comp Apps Final Project - Risk Analysis of Coronary Artery Disease');    
    label3 = uilabel(OpeningGUI, 'Position', [25 325 500 50], 'Text', 'By: Kylie Butler, Andrew Dodds, Madeleine McCreary ');    
    %Construct button 
    StartBtn = uibutton(OpeningGUI, 'Text', 'Start Program', 'Position', [25 310 100 25],'ButtonPushedFcn', @(btn,event) Inputs);    
    %The following 4 lines add an image the size of the GUI to OpeningGUI   
    OpeningGUIBackgroundImage = imread('CAD.jpeg');   
    ax = uiaxes(OpeningGUI);   
    image(OpeningGUIBackgroundImage, "Parent", ax);   
    ax.Visible = 'off';  
    function [features1] = Inputs() 
        %InputsGUI = uifigure('Name', 'User Inputs');
        %Changes mouse to crosshair   
        %InputsGUI.Pointer = 'crosshair'; 
    
        %label4 = uilabel(InputsGUI, 'Position', [25 375 500 50], 'Text', 'Enter Patient Data Here'); 
        features1 = inputdlg({'Age', 'Sex (M or F)', 'Chest Pain (Y or N)', 'Resting Blood Pressure [mmHg]', 'Serum Cholesterol [mg/dl]', 'Fasting BS', 'Maximum Heartrate', 'Exercise Induced Agina (Y or N)', 'Thalamus Stress results'})
        
    end
    %Age, Sex, Chest_Pain, Rest_BP, Cholesterol, Fasting_BS, Max_HR, ExInd_Agnia, Thal