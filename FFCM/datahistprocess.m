function [datahist,histrate]=datahistprocess(data)
%%���ݰ��Ҷȼ�0-255�黯�������ڻҶ�ֱ��ͼ�Ͼ���
% [m,n]=size(V);
I=data*255;
datahist=([0:1:255]./255)';%���ݰ��Ҷȼ�0��255���У���һ��
histrate=zeros(256,1);%ÿ���Ҷȼ���Ƶ��
for i=1:256
    temp=find(I==(i-1));
    histrate(i,:)=length(temp);   
end