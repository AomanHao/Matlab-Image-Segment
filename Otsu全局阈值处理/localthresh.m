function g=LocalThresh(f,nhood,a)
%% �ú���OTSU+��׼���
f_thr=graythresh(f);%������ֵ
f_glob=im2bw(f,f_thr);%�ָ�ͼ��

% f=tofloat(f);
SIG=stdfilt(f,nhood);%��׼��
g=(f>a*SIG) & f_glob;



    