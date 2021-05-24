function shuffledata = MnistShuffle(test,column,index)
%test = data
%column 은 원하는 행의 개수
%(전부 다 섞길원하면 length로, 특정 개수만 반환하고 싶으면 length보다 작은 숫자 쓸것)
%index 가 0~9이면 라벨링함 ( 숫자 0이면 앞에 0, 1이면 1... 이런식) 10 이상이면 안함
idx = randperm(length(test))'; 
aa = [];
for i = 1:length(test)
    test_re = test(idx(i),:);
    aa = [aa; test_re];
end

for i = 1:length(aa)
    if i > column
        aa(column,:) = [];
    end
end

if index < 10 && index >= 0
    label = index*ones(column,1);
    aa = [label, aa];    
end

shuffledata = aa;