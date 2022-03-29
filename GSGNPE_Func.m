%This is an implementation for the paper "Global structure-guided 
%neighborhood preserving embedding for dimensionality reduction", 
%which is accepted in International Journal of Machine Learning and Cybernetics.
%Please cite our paper if you use our code in your publication.
function [BB,Loss] = GSGNPE_Func(train_data,neighbor_K,alpha,Lamda,Iter)

options=[];
options.k =neighbor_K;
options. NeighborMode = 'KNN';
WW= Wconstruct_NPE(options,train_data);
L=(eye(size(WW))-WW)*(eye(size(WW))-WW)';

G=train_data'*L*train_data;

[U] = MyPCA(train_data);%PCA

BB=U;


[U2U,~,V2U]=svd(BB*U');
A=(U2U*V2U');
Loss=[];
for i=1:Iter
    W=Cul_L21_diag(BB);
    BB=2*alpha*(inv(2*alpha*eye(size(G))+Lamda*W+2*G))*A*U;
    [U2U,~,V2U]=svd(BB*U');
    A=(U2U*V2U');
end

end












