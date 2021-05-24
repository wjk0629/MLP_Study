function [x, y] = GaussianDistribution(mean, variance, sample)
r1 = normrnd(mean,variance,[sample,2]); %% 평균0, 분산1인 랜덤함수 생성
%t1 = zeros(1000,1); %% 타겟벡터는 0
%r1t = [r1,t1];
x = r1(:,1);
y = r1(:,2);

%% 그래프 만드는 과정
% subplot(3,1,1); plot(x1,y1,'.');
% axis([-4 10 -4 10]);
% grid on;
% xlabel('x')
% ylabel('y')
% title('mu = [0,0]^T , sigma^2 = 1')
% 
% subplot(3,1,2); plot(x2,y2,'.r');
% axis([-4 10 -4 10]);
% grid on;
% xlabel('x')
% ylabel('y')
% title('mu = [2,2]^T , sigma^2 = 4')
% 
% subplot(3,1,3); plot(x2,y2,'.r');
% axis([-4 10 -4 10]);
% grid on;
% hold on; plot(x1,y1,'.');
% xlabel('x')
% ylabel('y')
% title('Compare 2 class')