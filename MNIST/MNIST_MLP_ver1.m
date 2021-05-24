clear all;
load mnist_all_mine_simple.mat 
rng(1);

%% set Train inputs & targets
tr = cast(train_mine,'double');
n1 = size(tr,1);
targets_c = tr(:,1);
targets_c(targets_c == 0) = 10;
targetsd_c = dummyvar(targets_c);
inputs_c = tr(:,2:end);

inputs_c = inputs_c';
targets_c = targets_c';
targetsd_c = targetsd_c';

%c = cvpartition(n1,'Holdout',n1*0.7);
c = cvpartition(n1,'resubstitution');

Xtrain = inputs_c(:,training(c));
Ytrain = targetsd_c(:,training(c));

%% set Test inputs & targets
te = cast(test_mine,'double');
n2 = size(te,1);
targets_o = te(:,1);
targets_o(targets_o == 0) = 10;
targetsd_o = dummyvar(targets_o);
inputs_o = te(:,2:end);

inputs_o = inputs_o';
targets_o = targets_o';
targetsd_o = targetsd_o';

%o = cvpartition(n2,'Holdout',n2*0.7);
o = cvpartition(n2,'resubstitution');

Xtest = inputs_o(:,test(o));
Ytest = targetsd_o(:,test(o));




