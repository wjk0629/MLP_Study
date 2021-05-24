Ypred = myNNfun(Xtest);
Ypred(:, 1:5);
[~, Ypred] = max(Ypred);
Ytest2 = [];
for i = 1:1000
    for j = 1:10;
        if Ytest(j,i) == 1
            Ytest2 = [Ytest2 j];
        end
    end
end

propability = sum(Ytest2 == Ypred) / length(Ytest2)