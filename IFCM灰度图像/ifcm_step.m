function [U, center_new, obj_fcn ] = ifcm_step(data, center, cluster_n, expo, Miuij,Vij,Paiij)

% % %----------------------------IFCM算法------------------------------
dist=distifcmMVP(Miuij,Vij,Paiij,center);%求直觉模糊集的欧式距离
dist((dist==0))=0.01;
tmp = dist.^(2/-(expo-1));     
U = tmp./(ones(cluster_n, 1)*sum(tmp));
mf = U.^expo;       
center_new = mf*data./((ones(size(data, 2), 1)*sum(mf'))');
obj_fcn = sum(sum((dist.^2).*mf)); 
