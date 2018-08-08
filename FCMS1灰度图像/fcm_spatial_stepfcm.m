function [U_new, center, obj_fcn] = fcm_spatial_stepfcm(data,data_spatial, U, cluster_n, expo, beta)

% %----------------------------fcm_spatial_stepfcmÀ„∑®------------------------------
mf = U.^expo;       % MF matrix after exponential modification
center = mf*(data+beta*data_spatial)./((1+beta)*((ones(size(data, 2), 1)*sum(mf'))')); % FCMS1
dist = distfcm(center, data);       % fill the distance matrix
tmp = dist.^2;      % calculate new U, suppose expo != 1
dist_2 = distfcm(center, data_spatial);       % fill the distance matrix
tmp2 = beta*dist_2.^2;      % calculate new U, suppose expo != 1
obj_fcn = sum(sum((dist.^2).*mf))+beta*sum(sum((dist_2.^2).*mf));  % objective function
% U_new = (ones(cluster_n, 1)*sum((tmp-tmp_1).^(1/(expo-1))))./((tmp-tmp_1).^(1/(expo-1)));
% U_new = ((tmp-tmp_1).^(1/(expo-1)))./(ones(cluster_n, 1)*sum((tmp-tmp_1).^(1/(expo-1))));
U_new = (ones(cluster_n, 1)*sum((1./(tmp+tmp2)).^(1/(expo-1)))).*(tmp+tmp2).^(1/(expo-1));
U_new=1./U_new;

% % %----------------------------fcm_spatial_stepfcmÀ„∑®------------------------------
