clc
clear all

%% parameter setting
Number_Of_Hidden = 8;
Number_Of_Input =  2;
Number_Of_Output = 2;

activfunc_a = 1; % 이진 시그모이드의 미분 : logsig(sk) * (1-logsig(sk))
learningRate = 0.5; % Learning Rate
epochs_Limit = 200; % 몇세대 까지
momentum = 0.4; % momentum

%% input & target data setting
sample = 1000; % 샘플 개수
x = [];
for i = 1 : sample/Number_Of_Output
    [x1, y1] = GaussianDistribution(0, 1, 1);
    [x2, y2] = GaussianDistribution(2, 4, 1);
    x = [x; [x1 y1]; [x2 y2];];
end
y = eye(Number_Of_Output);


%% ini weight & bias setting
weight_ij = rand(Number_Of_Input,Number_Of_Hidden);
weight_jk = rand(Number_Of_Hidden,Number_Of_Output);

bias_i = rand(Number_Of_Hidden,1);
bias_j = rand(Number_Of_Output,1);
% add bias node
weightAddbias_ij = [weight_ij; bias_i'];
weightAddbias_jk = [weight_jk; bias_j'];

before_delta_w_ij = zeros(Number_Of_Input,Number_Of_Hidden);
before_delta_w_jk = zeros(Number_Of_Hidden,Number_Of_Output);

%% Loop start
epochs = 1;
while epochs < epochs_Limit
    
    for Case = 1 : 1 : sample
        
        for i = 1 : 1 : Number_Of_Input-1
            x_input = [x(Case,i), x(Case,i+1)];
        end
        % Forward Compute (input to hidden)
        xb = [x_input, 1];  % 1: add bias node
        sj = xb * weightAddbias_ij;
        % 이진 시그모이드 logsig
        yj = logsig(activfunc_a*sj);
        yj_dot = yj.*(1-yj);
        
        % Forward Compute (hidden to output)
        yjb = [yj, 1]; % 1: add bias node
        sk = yjb * weightAddbias_jk;
        % 이진 시그모이드 (softmax로 바꿔볼것)
        yk = logsig(activfunc_a*sk);
        yk_dot = yk.*(1-yk);
        
        % Back-propagation 
        %Target y setting  %%% 이부분 다시 확인
        if rem(Case,Number_Of_Output) == 0
            yd = y(1,:);
        else
            yd = y(2,:);
        end
        % Back 1 % Error
        ek = yd - yk;
        rho_k  = (ek .* yk_dot)';
        delta_b_j = learningRate*rho_k;
        delta_w_jk = learningRate*(rho_k*yj)';
        %delta_weight_jk = [delta_w_jk; (delta_b_k)'];
        E(Case) = 0.5*(ek(1)^2 + ek(2)^2);
        % Back 2
        rho_j = (yj_dot)' .* weight_jk * rho_k;
        delta_b_i = learningRate*rho_j;
        delta_w_ij = learningRate*(rho_j*x_input)';
        %delta_weight_ij = [delta_w_ij; (delta_b_j)'];
               
        % update weight
        weight_ij = weight_ij + delta_w_ij + momentum*before_delta_w_ij;
        weight_jk = weight_jk + delta_w_jk + momentum*before_delta_w_jk;
        bias_i =  bias_i + delta_b_i;
        bias_j =  bias_j + delta_b_j;
        before_delta_w_ij = delta_w_ij;
        before_delta_w_jk = delta_w_jk;
        weightAddbias_ij = [weight_ij; bias_i'];
        weightAddbias_jk = [weight_jk; bias_j'];
        
    end
    
    Etotal(epochs) = mean(E);
      
    if Etotal(epochs) < 0.05
        break;
    end
    epochs = epochs + 1
end
plotMNIST(Etotal,'r-.','Number of epoches','Mean-squared error')
%plot(Etotal,'r-.')
%plot(Etotal,'g--')
epochs
%% Test (주석처리)
test_sample = 1000;
x_test = [];
subplot(1,2,1);
hold on;
for i = 1 : test_sample/Number_Of_Output
    [x_test1, y_test1] = GaussianDistribution(0, 1, 1);
    plot(x_test1,y_test1,'r*');
    [x_test2, y_test2] = GaussianDistribution(2, 4, 1);
    plot(x_test2,y_test2,'b*');
    x_test = [x_test; [x_test1 y_test1]; [x_test2 y_test2];];
end
axis([-8 20 -8 20])
subplot(1,2,2);
probability = [];
for Case = 1 : 1 : test_sample
        
        for i = 1 : 1 : Number_Of_Input-1
            x_test_input = [x_test(Case,i), x_test(Case,i+1)];
        end
% Forward Compute (input to hidden)
xb_test = [x_test_input, 1];  
sj = xb_test * weightAddbias_ij;
 % 이진 시그모이드 logsig
yj = logsig(activfunc_a*sj);
        
% Forward Compute (hidden to output)
yjb = [yj, 1]; % 1: add bias node
sk = yjb * weightAddbias_jk;
% 이진 시그모이드 (softmax로 바꿔볼것)
yk = logsig(activfunc_a*sk);
if yk(1) <= 0.5 && yk(2) > 0.5
    plot(x_test_input(1),x_test_input(2),'r*');
    if rem(Case,2) == 1
        probability = [probability 1];
    else
        probability = [probability 0];
    end
else
    plot(x_test_input(1),x_test_input(2),'b*');
    if rem(Case,2) == 0
        probability = [probability 1];
    else
        probability = [probability 0];
    end
end
axis([-8 20 -8 20])
hold on;
end
performance = ( sum(probability) / length(probability) ) * 100 


