function [U_new, center, obj_fcn] = fcm_spatial_stepfcm(data,U, cluster_n, expo)

% % %----------------------------fcm_Ëã·¨------------------------------
mf = U.^expo;       % MF matrix after exponential modification
center = mf*data./((ones(size(data, 2), 1)*sum(mf'))'); % new center
dist = distfcm(center, data);       % fill the distance matrix
obj_fcn = sum(sum((dist.^2).*mf));  % objective function
tmp = dist.^(-2/(expo-1));      % calculate new U, suppose expo != 1
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));
