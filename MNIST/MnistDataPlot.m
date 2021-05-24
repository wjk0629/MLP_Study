function mnistvisualizing = MnistDataPlot(test,column,index)
% load_data의 testx or trainx를 rearrange한다. ex) test0, test1, train3 , . . .
load_data = test;
% column 만큼 행으로 끊어서 plot 한다.
% index 1이면 plot도 한다.

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
