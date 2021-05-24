function mnistvisualizing = MnistDataPlot(test,column,index)
% load_data�� testx or trainx�� rearrange�Ѵ�. ex) test0, test1, train3 , . . .
load_data = test;
% column ��ŭ ������ ��� plot �Ѵ�.
% index 1�̸� plot�� �Ѵ�.

for i = 1:length(load_data)
    img{i} = reshape(load_data(i,:),28,28)';
end
imgs = [];
imgstotal = [];
empty = [];
for i = 1:length(load_data)
    if rem(i,column) == 0
        imgs = [imgs; img{i}];
        imgstotal = [imgstotal imgs];
        imgs = [];
    else
        imgs = [imgs; img{i}];        
    end
    
end
for i = 1:(column*28 - length(imgs))/28
    empty = [empty; zeros(28,28)];
end
imgs = [imgs; empty];
imgstotal = [imgstotal imgs];
mnistvisualizing = imgstotal;
if index == 1
    imshow(imgstotal)
    title('Data Plot');
end
