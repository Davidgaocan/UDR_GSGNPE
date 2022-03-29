function [V] = MyPCA(Data)
%MYPCA 此处显示有关此函数的摘要
%   此处显示详细说明
%Data由行向量组成
mean=sum(Data,1)/(size(Data,1));
MeanData=Data-mean;
XXT=MeanData'*MeanData;

[~,~,V]=svd(XXT);
end

