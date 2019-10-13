function [U, center_new, obj_fcn ] = iffcm_step(data, center, cluster_n, expo, histrate)

%% ��ʼ����������ffcm
dist=distffcm(data,center);%ŷʽ����
dist((dist==0))=0.001;
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

