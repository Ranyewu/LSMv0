%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------Step1:Data collection----------------------%
LoadPicture  %LoadPicture
Reclassify   %Feature discretization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------%Step2:Variables Analysis------------------%
FrHistcount    %FR method for Variables Analysis
EntIgain  %Information Gain method for Variables Analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------%Step3:Model training----------------------%
FRmethod    
ANNDNNanalysis  %Wait time Warning at least 7h
%!!!!!!!!!!!!!!!!Wait time Warning at least 7h
%The best ANN and MLP model have already packed in files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------%Step4:Model evaluation--------------------%
PRCpicture(1,28,29);%model based on LIM
PRCpicture(2,26,27);%model based on ELIM
%Index tips
%Index 1 FR based on LIM %Index 2 FR based on ELIM
%Index 28 ANN based LIM  %Index 29 DNN based LIM
%Index 26 ANN based ELIM %Index 27 DNN based ELIM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%-------------------%Step5:Model Visualization-----------------%
[~] = RecoverModelLSM(28,2);%show the picture of models 
[~] = RecoverModelLSM(29,2);
[~] = RecoverModelLSM(26,2);
[~] = RecoverModelLSM(27,2);
%Further visualization will display in Arcgis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


