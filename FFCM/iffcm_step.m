function [U, center_new, obj_fcn ] = iffcm_step(data, center, cluster_n, expo, histrate)

%% 初始化聚类中心ffcm
dist=distffcm(data,center);%欧式距离
dist((dist==0))=0.001;
tmp = dist.^(2/-(expo-1));     
U = tmp./(ones(cluster_n, 1)*sum(tmp));%隶属度矩阵
mf = U.^expo;       
mfhistrate=zeros(cluster_n,256);
for i=1:cluster_n
    mfhistrate(i,:)=mf(i,:).*histrate';%隶属度乘以频数
end
center_fenmu=((ones(size(data, 2), 1)*sum(mfhistrate'))');%聚类中心分母
center_new = mf*(data.*histrate)./center_fenmu; % 聚类中心
obj_fcn = sum(sum((dist.^2).*mfhistrate));  % 目标函数

