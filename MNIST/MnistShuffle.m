function shuffledata = MnistShuffle(test,column,index)
%test = data
%column �� ���ϴ� ���� ����
%(���� �� ������ϸ� length��, Ư�� ������ ��ȯ�ϰ� ������ length���� ���� ���� ����)
%index �� 0~9�̸� �󺧸��� ( ���� 0�̸� �տ� 0, 1�̸� 1... �̷���) 10 �̻��̸� ����
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