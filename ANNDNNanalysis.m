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
