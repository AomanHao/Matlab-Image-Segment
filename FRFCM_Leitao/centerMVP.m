function center_new=centerMVP(center)
%���������ȡ��������ȡ���ԥ���������ľ�������,����

miui=center;
alpha_a=0.85;
vi=(1-miui.^alpha_a).^(1/alpha_a);
paii=1-miui-vi;

center_new(:,1)=miui;
center_new(:,2)=vi;
center_new(:,3)=paii;