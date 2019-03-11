function svm(class1,class2,test1,test2)
    %reshape covariance matrix
    X=[class1(:,:);class2(:,:)];
    Y=[zeros(size(class1,1),1);ones(size(class2,1),1)];
    Xtest=[test1(:,:);test2(:,:)];
    Ytest=[zeros(size(test1,1),1);ones(size(test2,1),1)];
    
    C=logspace(-5,5,13);
    L1=zeros(13,1);

    %train linear model
    for i=1:13
        LinearModel = fitcsvm(X,Y,'KernelFunction','linear','BoxConstraint',C(i),'CrossVal','on','kfold',3);
        L1(i) = kfoldLoss(LinearModel);
    end

    LinearModel = fitcsvm(X,Y,'KernelFunction','linear','Boxconstraint',C(find(L1==min(L1(:)),1)));

    [~,score1] = predict(LinearModel,Xtest);

    [XROC1,YROC1,T1,AUC1] = perfcurve(Ytest,score1(:,2),1);
    plot(XROC1,YROC1);
    legend(['linear model, AUC=',num2str(AUC1)]);
end