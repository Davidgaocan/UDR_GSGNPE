function [W] = Cul_L21_diag(Data)
%CUL_L21_DIAG �˴���ʾ�йش˺�����ժҪ
%   Data Ϊ���������
L2OfRow=sqrt(Data.*Data*ones(size(Data,2),1));
W=inv(diag(L2OfRow));
end

