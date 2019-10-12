function [U, center_new, obj_fcn ] = ffcm_spatial_stepfcm(data, center, cluster_n, expo,histrate)

% % %----------------------------fcm_spatial_stepfcm算法------------------------------
% mf = U.^expo;       % MF matrix after exponential modification
% center = mf*(data+beta*data_spatial)./((1+beta)*((ones(size(data, 2), 1)*sum(mf'))')); % new center
% dist = distfcm(center, data);       % fill the distance matrix
% tmp = dist.^2;      % calculate new U, suppose expo != 1
% dist_2 = distfcm(center, data_spatial);       % fill the distance matrix
% tmp2 = beta*dist_2.^2;      % calculate new U, suppose expo != 1
% obj_fcn = sum(sum((dist.^2).*mf))+beta*sum(sum((dist_2.^2).*mf));  % objective function
% % U_new = (ones(cluster_n, 1)*sum((tmp-tmp_1).^(1/(expo-1))))./((tmp-tmp_1).^(1/(expo-1)));
% % U_new = ((tmp-tmp_1).^(1/(expo-1)))./(ones(cluster_n, 1)*sum((tmp-tmp_1).^(1/(expo-1))));
% U_new = (ones(cluster_n, 1)*sum((1./(tmp+tmp2)).^(1/(expo-1)))).*(tmp+tmp2).^(1/(expo-1));
% U_new=1./U_new;

%初始化聚类中心ffcm
%cluster_n=length(center);
dist=distffcm(data,center);%欧式距离
dist((dist==0))=0.01;
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

