clear,clc
load ./datasets/FKPROI_left_index2855;
A=FKPROI_left_index2855;

imshow(A(:,:,5),[])

% A=A/255;
% for i=1:size(A,1)
%     c=reshape(A(i,:),32,32);
%     im=imnoise(c,'salt & pepper',0.1);
%     fea_10_SaltPepper(i,:)=reshape(im,1,1024);
% end
% fea_10_SaltPepper=fea_10_SaltPepper*255;
% 
% save('./datasets/YaleB_32x32_10_SaltPepper.mat','fea_10_SaltPepper','gnd');