function g=LocalThresh(f,nhood,a)
%% 该函数OTSU+标准差处理
f_thr=graythresh(f);%计算阈值
f_glob=im2bw(f,f_thr);%分割图像

% f=tofloat(f);
SIG=stdfilt(f,nhood);%标准差
g=(f>a*SIG) & f_glob;



    