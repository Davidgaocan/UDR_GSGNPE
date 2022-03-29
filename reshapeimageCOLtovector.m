function [B]=reshapeimageCOLtovector(allimagematrix)
%colunm into colunm

[mline mcolumn mthick]=size(allimagematrix);
lenth=mline*mcolumn;
B=zeros(lenth,mthick);
for t=1:mthick
    B(:,t)=reshape(allimagematrix(:,:,t),lenth,1);
end