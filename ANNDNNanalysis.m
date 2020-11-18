clear all
load('basic.mat')
load('DatasetReclassify.mat')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%For Histroical Landslide 
[trainsample,indexs,input,output]=ReduceSample(trainRe1,fix(0.8*count(1,2)),fix(0.8*count(1,2)));

[~,net,ResultANN] = LearningAnnre(input,output,15,100);
[Roc,AUC,Ytest] = TestingANNre(net,anninRe,annout,annout2);
CovertRocToExcel(Roc,AUC,1,net,15,100,Ytest)

[~,net,ResultANN] = LearningDnnre(input,output,15,100);
[Roc,AUC,Ytest] = TestingANNre(net,anninRe,annout,annout2);
CovertRocToExcel(Roc,AUC,2,net,15,100,Ytest)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%For Earhquake-induced Landslide  
[trainsample,indexs,input,output]=ReduceSample(trainRe2,fix(0.8*count2(1,1)),fix(0.8*count2(1,2)));

[~,net,ResultANN] = LearningAnnre(input,output,15,100);
[Roc,AUC,Ytest] = TestingANNre(net,annin2Re,annout,annout2);
CovertRocToExcel(Roc,AUC,3,net,15,100,Ytest)

[~,net,ResultANN] = LearningDnnre(input,output,15,100);
[Roc,AUC,Ytest] = TestingANNre(net,annin2Re,annout,annout2);
CovertRocToExcel(Roc,AUC,4,net,15,100,Ytest)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [random,index1] = Randomselect(matrixs,numbers)
random = zeros(numbers,size(matrixs,2));
index1 = randperm(size(matrixs,1),numbers)';
for i = 1 : numbers
    random(i,:)=matrixs(index1(i,1),:);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [trainsample,indexs,input,output]=ReduceSample(train,a,b)
%reduce the number of samples
A = arrayfun(@(x) train(train(:,1) == x, :), unique(train(:,1)), 'uniformoutput', false);
[nls,index1]=Randomselect(A{1},a);
[ls,index2]=Randomselect(A{2},b);
trainsample=[nls;ls];
indexs=[index1;index2];
input=trainsample(:,2:end);
output=trainsample(:,1);
clear A
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CovertRocToExcel(Roc,AUC,x,net,N,MaxEpoch,Ytest)

RocT = array2table(Roc,...
    'VariableNames',{'i','CM1Dec1','CM1Dec2','CM1Dec3','CM1Dec4','AccPPVDecls1','AccALLDecls1',...
                         'CM1Per1','CM1Per2','CM1Per3','CM1Per4','AccPPVPerls1','AccALLPerls1',...
                         'CM2Dec1','CM2Dec2','CM2Dec3','CM2Dec4','AccPPVDecls2','AccALLDecls2',...
                         'CM2Per1','CM2Per2','CM2Per3','CM2Per4','AccPPVPerls2','AccALLPerls2'})
AucT = array2table(AUC,...
    'VariableNames',{'AUCDecinls1','AUCPerinls1','AUCDecinls2','AUCPerinls2'})
                     
filename = [pwd,'\ResultRoc.xlsx'];
currentFolder = pwd



Modelname=['AnnModel',num2str(x)];
Modelname2=[currentFolder,'\PRCResult\Model',num2str(x),'.mat'];
save(Modelname2,'net','Roc','AUC')
Modelname3=[currentFolder,'\LSIResult\Model',num2str(x),'.mat'];
save(Modelname3,'Ytest')

Result=[x,N,MaxEpoch,AUC];
sheetname=['A',num2str(x+1)];
writematrix(Result,filename,'Sheet','Modelname','Range',sheetname)
writetable(AucT,filename,'Sheet',Modelname,'Range','A1')
writetable(RocT,filename,'Sheet',Modelname,'Range','A3')


end
