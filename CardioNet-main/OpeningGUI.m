OpeningGUIFn();  
function OpeningGUIFn()  
    OpeningGUI = uifigure('Name', 'OpeningGUI');  
    %Changes mouse to crosshair   
    OpeningGUI.Pointer = 'crosshair';    
    %The following 3 lines add text to the GUI   
    label1 = uilabel(OpeningGUI, 'Position', [25 375 500 50], 'Text', 'CardioNet');    
    label2 = uilabel(OpeningGUI, 'Position', [25 350 500 50], 'Text', 'Comp Apps Final Project - Risk Analysis of Coronary Artery Disease');    
    label3 = uilabel(OpeningGUI, 'Position', [25 325 500 50], 'Text', 'By: Kylie Butler, Andrew Dodds, Madeleine McCreary ');    
    %Construct button 
    StartBtn = uibutton(OpeningGUI, 'Text', 'Start Program', 'Position', [25 310 100 25], 'ButtonPushedFcn', @(btn,event) Read_data_and_Variables);    
    %The following 4 lines add an image the size of the GUI to OpeningGUI   
    OpeningGUIBackgroundImage = imread('CAD.jpeg');   
    ax = uiaxes(OpeningGUI);   
    image(OpeningGUIBackgroundImage, "Parent", ax);   
    ax.Visible = 'off';  
end  