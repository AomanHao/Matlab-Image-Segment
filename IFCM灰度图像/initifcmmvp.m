function [Miuij,Vij,Paiij]=initifcmmvp(data)

%%%%%%初始化隶属度，非隶属度，犹豫度矩阵
Miuij=data;
alpha=0.85;
Vij=(1-Miuij.^alpha).^(1/alpha);
Paiij=1-Miuij-Vij;
