%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Code For save files and training FR model
tiffpath=[pwd,'\PictureResult'];
LSIpath=[pwd,'\LSIResult'];
PRCpath=[pwd,'\PRCResult'];

[~,~,~,FrLSI] = FR(anninRe,annout,count);
[image1] = recover3(FrLSI,index,sizes);
[Roc1,Auc1] = PRC(FrLSI,annout,annout2);

temp=[tiffpath,'\FRLIM.tiff'];
imwrite(image1,temp)
temp=[LSIpath,'\FRLIM.mat'];
save(temp,'FrLSI')
temp=[PRCpath,'\FRLIM.mat'];
save(temp,'Roc1','Auc1')

[~,~,~,FrLSI] = FR(annin2Re,annout2,count2);
[image1] = recover3(FrLSI,index,sizes);
[Roc1,Auc1] = PRC(FrLSI,annout,annout2);

temp=[tiffpath,'\FRELIM.tiff'];
imwrite(image1,temp)
temp=[LSIpath,'\FRELIM.mat'];
save(temp,'FrLSI')
temp=[PRCpath,'\FRELIM.mat'];
save(temp,'Roc1','Auc1')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear Roc1 Auc1 temp tiffpath LSIpath PRCpath FrLSI 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%FunctionsFunctionsFunctionsFunctions%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [FRvalue,FRper,FRnumber,Y] = FR(anninRe,annout,count)
FRnumber=zeros(size(anninRe,2),max(max(anninRe)));
for i = 1 : size(anninRe,1)
    if annout(i,1)==1
       for j = 1 : size(anninRe,2)
          FRnumber(j,anninRe(i,j))=FRnumber(j,anninRe(i,j))+1;
       end
    end
end
FRper=zeros(size(anninRe,2),max(max(anninRe)));
for i = 1 : size(anninRe,1)
       for j = 1 : size(anninRe,2)
          FRper(j,anninRe(i,j))=FRper(j,anninRe(i,j))+1;
       end
end
FRper2=FRper./count(1,1);
FRls=FRnumber./count(1,2);
FRvalue=FRls./FRper2;
Y=zeros(size(anninRe,1),1);

for i = 1 : size(anninRe,1)
    for j = 1 : size(anninRe,2)
        temp =[1:size(anninRe,2);anninRe(i,:)];
    Y(i,1)=Y(i,1)+FRvalue(temp(1,j),temp(2,j));
    end
end
clear temp
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Roc,AUC] = PRC(Yresult,landslide1,landslide2)
Ynor=normalize(Yresult,'range');
[~,indexY] = sort(Yresult);
[~,Ytrainrank] = sort(indexY);
Yresultranknor = normalize(Ytrainrank,'range');
Roc=zeros(1,25);
for i = 1:100 
    Y_Out=zeros(size(Yresult,1),2);
    for j = 1:size(Yresult,1)
        if Ynor(j,1)>=(1-i/100)
           Y_Out(j,1)=1;
        end
        
        if Yresultranknor(j,1)>=(1-i/100)
           Y_Out(j,2)=1;
        end
    end
      
    CMDecls1 = ConfusionMatrix1(Y_Out(:,1),landslide1);%calculate by 0-1
    CMPerls1 = ConfusionMatrix1(Y_Out(:,2),landslide1);%calculate by 0-100%
    CMDecls2 = ConfusionMatrix1(Y_Out(:,1),landslide2);%calculate by 0-1
    CMPerls2 = ConfusionMatrix1(Y_Out(:,2),landslide2);%calculate by 0-100%
    
    temp = [i,CMDecls1,AccPPV(CMDecls1),AccAll(CMDecls1),CMPerls1,AccPPV(CMPerls1),AccAll(CMPerls1),...
              CMDecls2,AccPPV(CMDecls2),AccAll(CMDecls2),CMPerls2,AccPPV(CMPerls2),AccAll(CMPerls2)];   
    
    Roc = [Roc;temp];     
end
AUC=[sum(Roc(:,6))/100,sum(Roc(:,12))/100,sum(Roc(:,18))/100,sum(Roc(:,24))/100];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [image1] = recover3(Y,index,sizes)
Y=normalize(Y,'range');
length = sizes(1,1)*sizes(1,2);
imageline=zeros(length,1);
n=size(index,1);
for i = 1:n
   imageline(index(i),1)=Y(i);
end
image1=reshape(imageline,sizes);
imshow(image1)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ConfusionMatrix] = ConfusionMatrix1(Y,Ytrue)
ConfusionMatrix=zeros(1,4);
for i = 1 : size(Y,1)
    if (Y(i,1)==1&&Ytrue(i,1)==1)
        ConfusionMatrix(1,1)=ConfusionMatrix(1,1)+1;
    elseif (Y(i,1)==1&&Ytrue(i,1)==0)
        ConfusionMatrix(1,2)=ConfusionMatrix(1,2)+1;
    elseif (Y(i,1)==0&&Ytrue(i,1)==1)
        ConfusionMatrix(1,3)=ConfusionMatrix(1,3)+1;
    elseif (Y(i,1)==0&&Ytrue(i,1)==0)
        ConfusionMatrix(1,4)=ConfusionMatrix(1,4)+1;
    end
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Acc] = AccAll(ConfusionMatrix)
Acc=(ConfusionMatrix(1,1)+ConfusionMatrix(1,4))/sum(ConfusionMatrix);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Acc] = AccPPV(ConfusionMatrix)
Acc=ConfusionMatrix(1,1)/(ConfusionMatrix(1,3)+ConfusionMatrix(1,1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
