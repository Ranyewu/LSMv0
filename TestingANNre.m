function [Roc,AUC,Ytest] = TestingANNre(net,Test_X,landslide1,landslide2)

Deep_test=reshape(Test_X',size(Test_X,2),1,1,size(Test_X,1));

Ytest=predict(net,Deep_test);

[Roc,AUC] = PRC(Ytest,landslide1,landslide2);




end

