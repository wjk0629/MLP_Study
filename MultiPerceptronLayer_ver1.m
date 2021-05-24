clc
clear all

% MLP로 XOR 판별하기

sample = 1000;
% XOR의 기본 테이블 입력
[x1, y1] = GaussianDistribution(0, 1, sample);
[x2, y2] = GaussianDistribution(2, 4, sample);
x = [x1 y1; x2 y2];
%x = [0 0;0 1;1 1;1 0 ];
y1 = [0.1];
for k = 1:length(x1)-1
    y1 = [y1; 0.1];
end
y2 = [0.9];
for k = 1:length(x2)-1
    y2 = [y2; 0.9];
end
yd = [y1; y2];
%yd = [ 0.1 ; 0.9 ; 0.9 ; 0.1 ];

%첫번째 합 s1을 구하기

%첫번째 합의 가중치 설정

Number_Of_Hidden = 2;
Number_Of_Input =  2;
Number_Of_Output = 1;
Number_Of_Bias = 2;

eta = 0.3 % Learning Rate
iter_Limit = 100000
alpha = 0.9 % momentum
% 초기 가중치 랜덤 셋팅
for  i = 1 : 1 : Number_Of_Input
    for  j = 1 : 1 : Number_Of_Hidden
        w_ij(i,j)=rand;
    end
end

for  j = 1 : 1 : Number_Of_Hidden
    for  k = 1 : 1 : Number_Of_Output
        w_jk(j,k)=rand;
    end
end


%     for  i = 1 : 1 : Number_Of_Bias
%         b(i) = rand
%     end
%
b_k(1) = rand
b_j(1) = rand
 iter = 1;
 rho_k_sum = 0;
 before_delta_w_ij = zeros(Number_Of_Input,Number_Of_Hidden)
 before_delta_w_jk = zeros(Number_Of_Hidden,Number_Of_Output)
while iter < iter_Limit
    
    for Case = 1 : 1 : sample
        
        
        for  i = 1 : 1 : Number_Of_Input
            for  j = 1 : 1 : Number_Of_Hidden
                sj(i,j)=w_ij(i,j)*x(Case,i)+b_k(1);
            end
        end
        % 이진 시그모이드 함수 : logsig
        yj = logsig(sj);
        
        for  i = 1 : 1 : Number_Of_Hidden
            for  j = 1 : 1 : Number_Of_Output
                sk(j)=w_jk(i,j)*yj(i,j)+b_j(1);
            end
        end
        yk(Case) = logsig(sk);
        
        ek(Case) = yd(Case) - yk(Case);
        
        rho_k  =  ek(Case) * yk(Case)*(1-yk(Case));
        
        delta_w_jk = eta*rho_k*yj;
        
        delta_b_k = eta*rho_k;
        
        rho_k_sum = rho_k_sum + rho_k;
        
        for  i = 1 : 1 : Number_Of_Input
            for  j = 1 : 1 : Number_Of_Hidden
                rho_j = yj(i,j)*(1-yj(i,j))*sum(rho_k)*w_jk;
                %rho_j = yj(i,j)*(1-yj(i,j))*rho_k_sum*w_jk;
            
            end
        end
        
        
        for  i = 1 : 1 : Number_Of_Input
            for  j = 1 : 1 : Number_Of_Hidden
                delta_w_ij(i,j) = eta*rho_j(j)*x(Case,i);
                
            end
        end
        
        for  i = 1 : 1 : Number_Of_Input
            for  j = 1 : 1 : Number_Of_Hidden
                w_ij(i,j)= w_ij(i,j)+delta_w_ij(i,j)+alpha*before_delta_w_ij(i,j);
            end
        end
        
        for  j = 1 : 1 : Number_Of_Hidden
            for  k = 1 : 1 : Number_Of_Output
                w_jk(j,k)=w_jk(j,k)+delta_w_jk(j)+alpha*before_delta_w_jk(j);
            end
        end
        
        
        b_j(1) =  b_j(1) + delta_b_k
        b_k(1) =  b_j(1) 
       before_delta_w_ij = delta_w_ij
        before_delta_w_jk = delta_w_jk 
        
    end
    
    E(iter) = 1/2*sum(ek.^2);
    
    if E(iter) < 0.001
        break;
        
    end
    iter = iter + 1;
end
plot(E)
iter