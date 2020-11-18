function [Layer1,net1,Ytrain] = LearningAnnre(input,output,N,MaxEpoch)

Deep_train=reshape(input',size(input,2),1,1,size(input,1));
size(Deep_train);

options = trainingOptions('adam', ...
    'MaxEpochs',MaxEpoch,...
    'InitialLearnRate',0.001, ...
    'Verbose',1, ...
    'Plots','none',...
    'ExecutionEnvironment','auto');

Layer1 = [ ...
    imageInputLayer([size(input,2),1,1])
    reluLayer 
    fullyConnectedLayer(N)
    reluLayer 
    fullyConnectedLayer(1)
    regressionLayer];

net1=trainNetwork(Deep_train,output,Layer1,options);

Ytrain=predict(net1,Deep_train);


end

