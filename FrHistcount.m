%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code is used for out put Frequency ratio figures.
text0=['LIM/ELIM'];
text1=['Lithology class'];
text2=['Soil class'];
text3=['Distance to Fault class'];
text4=['Slope class'];
text5=['Aspect class'];
text6=['Curvature class'];
text7=['Distance to Road class'];
text8=['Distance to River class'];
text9=['Land-use class'];
text10=['2018.8 Precipitation class'];
text11=['PGA 3d synthesis class'];
text12=['Japan seismic intensity class'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
text={text0,text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,text11,text12};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 2:13

i

path=[pwd,'\PaperPicture\',num2str(i-1),text{i},'.png'];


   if i <=10 


   max1=max(trainRe1);
   min1=min(trainRe1);

   Xedges=linspace(min1(i)-0.5,max1(i)+0.5,max1(i)-min1(i)+2);
   Xlenged=linspace(min1(i),max1(i),max1(i)-min1(i)+1);
   
   [N1,Xedges] = histcounts(trainRe1(:,i),Xedges);
   [trainsample,~,~,~]=ReduceSample(trainRe1,0,count(1,2));
   [N2,Xedges] = histcounts(trainsample(:,i),Xedges);
   [trainsample2,~,~,~]=ReduceSample(trainRe2,0,count2(1,2));
   [N3,Xedges] = histcounts(trainsample2(:,i),Xedges);
   
   P1=N1./(count(1,1)+count(1,2));
   P2=N2./count(1,2);
   P3=N3./count2(1,2);
   P=[P1;P2;P3]; 
   Fr1=P2./P1;
   Fr2=P3./P1;  
   Fr=[Fr1;Fr2];
    
   
   figure
   set(gcf,'Position',[500,500,500,200], 'color','w')
   
   Xla = movmean(Xedges,2,'Endpoints','discard');
   yyaxis left
   
   line(Xla,P(1,:),'Color','#0072BD','LineWidth',1,'Marker','.')
   hold on
   line(Xla,P(2,:),'Color','#D95319','LineWidth',1,'Marker','.')
   hold on
   line(Xla,P(3,:),'Color','#EDB120','LineWidth',1,'Marker','.')


   xlabel(text{i})
   xlim([min1(i) max1(i)])
   xticks(Xlenged)

   ylabel('Probability')


   hold on
   yyaxis right
   ylabel('Fr')

   line(Xla,Fr(1,:),'Color','#7E2F8E','LineWidth',1,'LineStyle','--','Marker','o')
   hold on
   line(Xla,Fr(2,:),'Color','#77AC30','LineWidth',1,'LineStyle','--','Marker','o')
   
   legend('P(X)','P(X|LIM)','P(X|ELIM)','Fr_L_I_M','Fr_E_L_I_M')
   
   saveas(gcf,path);
    
   elseif i>10
       
   max1=max(trainRe2);
   min1=min(trainRe2);
   Xedges=linspace(min1(i)-0.5,max1(i)+0.5,max1(i)-min1(i)+2);
   Xlenged=linspace(min1(i),max1(i),max1(i)-min1(i)+1);
   [N1,Xedges] = histcounts(trainRe2(:,i),Xedges);
   [trainsample2,~,~,~]=ReduceSample(trainRe2,0,count2(1,2));
   [N2,Xedges] = histcounts(trainsample2(:,i),Xedges);
   P1=N1./(count(1,1)+count(1,2));
   P2=N2./count2(1,2);
   P=[P1;P2]; 
   Fr=P2./P1;  
   figure
   set(gcf,'Position',[500,500,500,200], 'color','w')
   
   Xla = movmean(Xedges,2,'Endpoints','discard');
   yyaxis left
   line(Xla,P(1,:),'Color','#0072BD','LineWidth',1)
   hold on
   line(Xla,P(2,:),'Color','#EDB120','LineWidth',1)
   hold on


   xlabel(text{i})
   xlim([min1(i) max1(i)])
   xticks(Xlenged)
   ylabel('Probability')


   hold on
   yyaxis right
   ylabel('Fr')

   line(Xla,Fr,'Color','#77AC30','LineWidth',1,'LineStyle','--','Marker','o')

   
   legend('P(X)','P(X|ELIM)','Fr_E_L_I_M')
   saveas(gcf,path);
   
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear text0 text1 text2 text3 text4 text5 text6 text7 text8 text9 text10 text11 text12 text path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
