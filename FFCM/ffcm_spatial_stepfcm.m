function [U, center_new, obj_fcn ] = ffcm_spatial_stepfcm(data, center, cluster_n, expo,histrate)

% % %----------------------------fcm_spatial_stepfcm�㷨------------------------------
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

%��ʼ����������ffcm
%cluster_n=length(center);
dist=distffcm(data,center);%ŷʽ����
dist((dist==0))=0.01;
tmp = dist.^(2/-(expo-1));     
U = tmp./(ones(cluster_n, 1)*sum(tmp));%�����Ⱦ���
mf = U.^expo;       
mfhistrate=zeros(cluster_n,256);
for i=1:cluster_n
    mfhistrate(i,:)=mf(i,:).*histrate';%�����ȳ���Ƶ��
end
center_fenmu=((ones(size(data, 2), 1)*sum(mfhistrate'))');%�������ķ�ĸ
center_new = mf*(data.*histrate)./center_fenmu; % ��������
obj_fcn = sum(sum((dist.^2).*mfhistrate));  % Ŀ�꺯��

