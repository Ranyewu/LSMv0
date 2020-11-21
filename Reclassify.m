%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('basic.mat') %Load the dataset 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature discretization For Histroical Landslide 
% (c) Fault, (d) Slope, (e) Aspect, (f) Curvature, (g) Road, (h) River
% are continuous variables
% annin------input data
% Eddivide1 --------divided method
% 3 ------- column index eg.: 3 means (c) Fault
Eddivide1=[0,1000,2000,3000,4000,5000,6000,15000];
[anninRe] = FrChange(annin,Eddivide1,3);
Eddivide1=[0,5,10,15,20,25,30,35,40,45,50,55,60,90];
[anninRe] = FrChange(anninRe,Eddivide1,4);
Eddivide1=[-1,0,22.5,67.5,112.5,157.5,202.5,247.5,292.5,337.5,360];
[anninRe] = FrChange(anninRe,Eddivide1,5);
Eddivide1=[-100,-1,1,100];
[anninRe] = FrChange(anninRe,Eddivide1,6);
Eddivide1=[0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
[anninRe] = FrChange(anninRe,Eddivide1,7);
Eddivide1=[0,200,400,600,800,1000,2000];
[anninRe] = FrChange(anninRe,Eddivide1,8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature discretization For Earhquake-induced Landslide 
% (c) Fault, (d) Slope, (e) Aspect, (f) Curvature, (g) Road, (h) River
% (j) 2018.8 Precipitation, (k) PGA 3d synthesis 
%and (l) Japan seismic intensity
% are continuous variables
Eddivide1=[0,1000,2000,3000,4000,5000,6000,15000];
[annin2Re] = FrChange(annin2,Eddivide1,3);
Eddivide1=[0,5,10,15,20,25,30,35,40,45,50,55,60,90];
[annin2Re] = FrChange(annin2Re,Eddivide1,4);
Eddivide1=[-1,0,22.5,67.5,112.5,157.5,202.5,247.5,292.5,337.5,360];
[annin2Re] = FrChange(annin2Re,Eddivide1,5);
Eddivide1=[-100,-1,1,100];
[annin2Re] = FrChange(annin2Re,Eddivide1,6);
Eddivide1=[0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
[annin2Re] = FrChange(annin2Re,Eddivide1,7);
Eddivide1=[0,200,400,600,800,1000,2000];
[annin2Re] = FrChange(annin2Re,Eddivide1,8);
Eddivide1=[0,220,240,260,280,300,320,400];
[annin2Re] = FrChange(annin2Re,Eddivide1,10);
Eddivide1=[300,400,500,600,700,800,900,1000];
[annin2Re] = FrChange(annin2Re,Eddivide1,11);
Eddivide1=[5.2,5.4,5.6,5.8,6.0,6.2,6.4,6.6];
[annin2Re] = FrChange(annin2Re,Eddivide1,12);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear Eddivide1
trainRe1=[annout,anninRe];
trainRe2=[annout2,annin2Re];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save DatasetReclassify.mat anninRe trainRe1 annin2Re trainRe2
% Save the reclassify training dataset
clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Newannin] = FrChange(annin,Eddivide1,Calindex)
Newannin = annin;
for i = 1:size(annin,1)
   for j = 1:size(Calindex,2)
        for k = 1 :size(Eddivide1,2)-1
            if  ((annin(i,Calindex(j))>=Eddivide1(j,k))&&...
                  annin(i,Calindex(j))<=Eddivide1(j,k+1))
               Newannin(i,Calindex(j))= k;
            end
        end
   end
   
   
   if i == 2500000
       disp('25% finished')
   elseif i ==5000000
       disp('50% finished')
   elseif i ==7500000
       disp('75% finished')
   end
   
end

end
