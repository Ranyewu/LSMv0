function [image2] = RecoverModelLSM(modelindex,mode)
load('basic.mat','index');
load('basic.mat','sizes');

fileplace=[pwd,'\LSIResult\Model',num2str(modelindex),'.mat'];
load(fileplace,'Ytest');

if mode==1
Y=normalize(Ytest,'range');
elseif mode==2
[~,indexY] = sort(Ytest);
[~,Ytrainrank] = sort(indexY);
Y = normalize(Ytrainrank,'range');
end

length = sizes(1,1)*sizes(1,2);
imageline=zeros(length,1);
n=size(index,1);
for i = 1:n
   imageline(index(i),1)=Y(i);
end
image2=reshape(imageline,sizes);
imshow(image2)
saveplace=[pwd,'\PictureResult\ModelPicture',num2str(modelindex),'.tiff'];
imwrite(image2,saveplace);

end



% function [image1] = recover2(Y_rank,index,sizes)
% image1 = zeros(sizes(1,1),sizes(1,2),3);
%     
% length = sizes(1,1)*sizes(1,2);
% n=size(index,1);
% imageline=zeros(length,1,3).*255;
% for i = 1:n
%     if Y_rank(i,1)>0.8
%     imageline(index(i,1),1,1)=255;
%     imageline(index(i,1),1,2)=34;
%     elseif Y_rank(i,1)>0.6 && Y_rank(i,1)<=0.8
%     imageline(index(i,1),1,1)=255;
%     imageline(index(i,1),1,2)=153;
%     elseif Y_rank(i,1)>0.4 && Y_rank(i,1)<=0.6
%     imageline(index(i,1),1,1)=255;
%     imageline(index(i,1),1,2)=255;
%     elseif Y_rank(i,1)>0.2 && Y_rank(i,1)<=0.4
%     imageline(index(i,1),1,1)=122;
%     imageline(index(i,1),1,2)=171;
%     elseif Y_rank(i,1)>-0.1 && Y_rank(i,1)<=0.2
%     imageline(index(i,1),1,1)=0;
%     imageline(index(i,1),1,2)=97;
%     end
% end
% 
% image1(:,:,1)=reshape(imageline(:,:,1),[sizes(1,1),sizes(1,2)]);
% image1(:,:,2)=reshape(imageline(:,:,2),[sizes(1,1),sizes(1,2)]);
% image1(:,:,3)=reshape(imageline(:,:,3),[sizes(1,1),sizes(1,2)]);
% clear length
% end
% 
% 
% image1 = recover2(Y,index,sizes);
% imshow(image1)



