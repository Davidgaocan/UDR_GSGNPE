function [V] = MyPCA(Data)
%MYPCA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%Data�����������
mean=sum(Data,1)/(size(Data,1));
MeanData=Data-mean;
XXT=MeanData'*MeanData;

[~,~,V]=svd(XXT);
end

