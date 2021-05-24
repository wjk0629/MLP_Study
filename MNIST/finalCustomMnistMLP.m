sweep = [10:20:300];
scores = zeros(length(sweep),1);
models = cell(length(sweep),1);
x = Xtrain;
t = Ytrain;
trainFcn = 'trainscg';
Ytest2 = [];
for i = 1:1000
    for j = 1:10;
        if Ytest(j,i) == 1
            Ytest2 = [Ytest2 j];
        end
    end
end
for i = 1:length(sweep)
    hiddenLayerSize = sweep(i);
    net = patternnet(hiddenLayerSize);
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    net = train(net,x,t);
    models{i} = net;
    p = net(Xtest);
    [~, p] = max(p);
    scores(i) = sum(Ytest2 == p)/length(Ytest2);
end
%hidden layer ´Ã¸®°í ½ÍÀ¸¸é :  net=feedforwardnet([200 200 200]);
% ÀÌ·±½ÄÀ¸·Î...net=feedforwardnet([50 10]); ¿ä·±½Ä..¸ÂÃçÁà¾ßµÊ
figure
plot(sweep, scores, '.-')
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')
