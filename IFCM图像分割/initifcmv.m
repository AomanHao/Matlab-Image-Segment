function V = initifcmv(cluster_n)
%%%初始化聚类中心（随机）
V = rand(cluster_n,1);
disp('初始聚类中心')
V
disp('聚类个数')
length(V)

