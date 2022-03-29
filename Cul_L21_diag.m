function [W] = Cul_L21_diag(Data)
%CUL_L21_DIAG 此处显示有关此函数的摘要
%   Data 为列向量组成
L2OfRow=sqrt(Data.*Data*ones(size(Data,2),1));
W=inv(diag(L2OfRow));
end

