clear,clc;
classnum=200;  totlenuminclass=7;

load datasets/FERET74040; A=FERET74040;
% load ./Zao_databases/FERET74040_5x5; A=FERET74040_5x5;
% load ./Zao_databases/FERET74040_10x10; A=FERET74040_10x10;
% load Zao_databases/FERET74040_15x15; A=FERET74040_15x15;
% load ./Zao_databases/FERET74040_20x20; A=FERET74040_20x20;
Breshape=A(1:40,1:40,:);
X=reshapeimageCOLtovector(A);
load datasets/randvector10by7Feret

trainingnuminclass = 4
rateFERET=[];
tenLoss=[];
for traintime=1:10
    traintime
    randvector=zeros(1,totlenuminclass);
    randvector=randvector10by7Feret(traintime,:);
    
    count=0;ind=0;clear Xfor
    for i=1:classnum
        for j=1:totlenuminclass
            count=(i-1)*totlenuminclass+randvector(j);
            ind=ind+1;
            Xrand(:,ind)=X(:,count);%get the random samples
        end
    end
    
    Y = zeros(classnum, classnum * trainingnuminclass);
    count=0;ind=0;clear gnd Xtrain_label Xtrain
    for i=1:classnum
        for j=1:trainingnuminclass
            count=(i-1)*totlenuminclass+randvector(j);
            ind=ind+1;
            Xtrain(:,ind)=Xrand(:,count);%get the training samples
            gnd(ind)=i;Xtrain_label(ind)=i;
            Y( Xtrain_label(ind), ind) = 1;
        end
    end

    count2=0;ind2=0; clear Xforconstructgraph XXrand Xtest_label Xtest
    for i=1:classnum
        for j=1+trainingnuminclass:totlenuminclass
            count2=(i-1)*totlenuminclass+j;
            ind2=ind2+1;Xtest_label(ind2)=i;
            Xtest(:,ind2)=Xrand(:,count2);
        end
    end
    clear Ytrain Ytest
    PCAdim = 200;
    reducedim = 100;
    xzhou=[];
    neighK= trainingnuminclass;
    [eigvectorPCA] = PCA_dencai(Xtrain', PCAdim);
    Xtrain1=eigvectorPCA'*Xtrain;
    Xtest1=eigvectorPCA'*Xtest;
    Xtrain=Xtrain1;
    Xtest=Xtest1;
    
    train_data=Xtrain';
    test_data=Xtest';
    train_label=Xtrain_label';
    test_label=Xtest_label';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % GSGNPE
    
    trainNumInClass=trainingnuminclass;
    Iter=10;
    
    % % %
    Lamda=3;
    alpha=8;%no block
    
%     Lamda=8;%2;%for 5x5 block
%     alpha=10;%8.7;
    
    % Lamda=-2;%2;%for 10x10 block
    % alpha=10;%8.7;
    
    % Lamda=7.84;%2;%for 15x15 block
    % alpha=4;%8.7;
    
    % Lamda=8.0;%2;%for 20x20 block
    % alpha=5.9;%8.7;
    %
    
    BB = GSGNPE_Func(Xtrain',trainNumInClass,10^alpha,10^Lamda,Iter);
    
    for dim=1:100
        train_data_P=train_data*BB(:,1:dim);
        test_data_P=test_data*BB(:,1:dim);
        knn_model = ClassificationKNN.fit(train_data_P,train_label,'NumNeighbors',1,'distance','euclidean');
        test_pre = predict(knn_model,test_data_P);
        acc = length(find(test_pre==test_label))/length(test_label);
        semi_knn(dim)=acc;
    end
    rateFERET=[rateFERET;semi_knn];
    
end

FERET_TWO_RecogLRLE_train4=sum(rateFERET,1)./traintime;
[m,index]=max(FERET_TWO_RecogLRLE_train4);% m is the final result.
stdnum=std(FERET_TWO_RecogLRLE_train4);
plot(FERET_TWO_RecogLRLE_train4);





