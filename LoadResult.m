function [Roc,AUC,information] = LoadResult(Modelindex)

Sheetname=['AnnModel',num2str(Modelindex)];
inforange=['A',num2str(Modelindex+1),':C',num2str(Modelindex+1)]
Roc=readmatrix('D:\OneDrive\M2\SCI\currentResultRoc.xlsx','Sheet',Sheetname,'Range','A4:Y104');
AUC = readmatrix('D:\OneDrive\M2\SCI\currentResultRoc.xlsx','Sheet',Sheetname,'Range','A2:D2');
information = readmatrix('D:\OneDrive\M2\SCI\currentResultRoc.xlsx','Sheet','Modelname','Range',inforange);
end

