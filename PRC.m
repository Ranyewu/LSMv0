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


end

