function [Miuij,Vij,Paiij]=initifcmmvp(data)

%%%%%%��ʼ�������ȣ��������ȣ���ԥ�Ⱦ���
Miuij=data;
alpha=0.85;
Vij=(1-Miuij.^alpha).^(1/alpha);
Paiij=1-Miuij-Vij;
