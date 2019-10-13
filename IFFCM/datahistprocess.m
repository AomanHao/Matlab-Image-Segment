function [datahist,histrate]=datahistprocess(data)
%%数据按灰度级0-255归化，方便在灰度直方图上聚类
% [m,n]=size(V);
I=data*255;
datahist=([0:1:255]./255)';%数据按灰度级0到255排列，归一化
histrate=zeros(256,1);%每个灰度级的频数
for i=1:256
    temp=find(I==(i-1));
    histrate(i,:)=length(temp);   
end