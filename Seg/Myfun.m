function scalar = Myfun(x)
%% 高斯滤波
w = fspecial('gaussian',[5,5],1);
scalar  = imfilter(x,w,'replicate');