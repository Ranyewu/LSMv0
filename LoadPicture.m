%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Wait time = 190s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
currentFolder = pwd                           %Load the current file path
filename =[currentFolder,'\a0.tif'];          %Write the file name
importfile(filename);                         %Function to read file
sizes = size(a0);                             %Read the size of picture
%Code to load the size of picture 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 0 : 13           
        filename = [currentFolder,'\a',num2str(i),'.tif']; 
        importfile(filename);        
        expression = ['a',num2str(i),'=double(','a',num2str(i),');'];
        eval(expression);        
        expression = ['a',num2str(i),'=a',num2str(i),'(:);'];
        eval(expression);
end
%Code to load all of the picture dataset 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 0 : 13
    if i == 0
       expression = ['b=[a',num2str(i),'];,clear a',num2str(i)];
       eval(expression);
    elseif i>0
       expression = ['b=[b,a',num2str(i),'];,clear a',num2str(i)];
       eval(expression);
    end
end
%Take all data together
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear filename i expression currentFolder
%Clear the temptale var to save the RAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count=zeros(1,2); 
%Count is used for calculate the non-landslides pixel and historical
%landslides in target area
w = size(b,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%This code is used for speed up the load%%%
for i = 1:1:size(b,1)
n = i;
if (b(n,1)==0&&max(b(n,2:w))~=65535)
    count(1,1)=count(1,1)+1;
elseif (b(n,1)==1&&max(b(n,2:w))~=65535)  
    count(1,2)=count(1,2)+1;
end
end
train=zeros(sum(count),w);
index=zeros(sum(count),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code is used for deleting the space pixel which is marked as
%65535 in the picture file (.tif)
a = 0;
for i = 1:1:size(b,1)
    n = i;
    if (b(n,1)==0&&max(b(n,2:w))~=65535)
        a=a+1;
        train(a,:)=b(n,:);
        index(a,1)=n;
    elseif (b(n,1)==1&&max(b(n,2:w))~=65535)
        a=a+1;
        train(a,:)=b(n,:);
        index(a,1)=n;
    end
end
clear n w i a j temp d2 ans b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
annin=train(:,2:10);
annout=train(:,1);
train1=[annout,annin];
count=counts(train1);   
%Dataset for histroical landslides
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
annin2=train(:,2:13);
annout2=train(:,14);
train2=[annout2,annin2];
count2=counts(train2);
%Dataset for Earthquake-induced landslides
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear train
save basic.mat %Use for saving the training dataset
clear all


function [count] = counts(matrix)
    count=zeros(1,2);
    for i = 1:size(matrix,1)
        if matrix(i,1)==0
            count(1,1)=count(1,1)+1;
        elseif matrix(i,1)==1
            count(1,2)=count(1,2)+1;
        end
    end
end

function importfile(fileToRead1)
    rawData1 = importdata(fileToRead1);
    [~,name] = fileparts(fileToRead1);
    newData1.(matlab.lang.makeValidName(name)) = rawData1;
    vars = fieldnames(newData1);
    for i = 1:length(vars)
        assignin('base', vars{i}, newData1.(vars{i}));
    end
end

