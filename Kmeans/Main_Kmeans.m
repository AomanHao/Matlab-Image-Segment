%% 程序分享 
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clear
close all
clc
%% 读取图像
I=imread('3096.jpg');

%% 基于K均值聚类的彩色图像分割
[m,n,k] = size(I);
% 将数组转成m*n行，3列的双精度矩阵
I_color = double(reshape(I, m*n, k));
% 设定背景和前景初始凝聚点
startdata = [10 10 200;200 200 10];
% 进行K均值聚类，所有像素点聚为2类：背景和前景，
% idClass = 1对应的是背景，idClass = 2对应的是前景
idClass = kmeans(I_color,2,'Start',startdata);
% 生成背景索引矩阵
idDuck = (idClass == 1);
% 生成背景索引数组result
result = reshape([idDuck, idDuck, idDuck],[m,n,k]);
% 为了不覆盖原始原始图像数据，定义一个新的数组
I_result = I;
% 根据背景索引数组result，把背景像素点的红、绿、蓝三元色灰度值均设置为0
I_result(result) = 0;
% 创建一个空白图形窗口
figure;imshow(I_result);title('彩色分割');

%% 基于K均值聚类的灰度图像分割
if size(I,3) == 3
   I_gray=rgb2gray(I);
else
end
I_gr = double(I_gray(:));    %将图像数据x按列拉长成一个长向量
startdata = [0; 150];    % 设定初始凝聚点
idpixel = kmeans(I_gr,2,'Start',startdata);    % 进行K均值聚类，所有像素点聚为2类
% 根据聚类结果生成一个与idpixel等长的逻辑向量idbw
idbw = (idpixel == 2);
% 将idbw还原成一个与x同样大小的逻辑矩阵，背景像素点对应元素值为0，前景像素点对应元素值为1
result = reshape(idbw, size(I_gray));
figure;imshow(result);title('灰度分割');    %以二值图像方式显示图像分割结果
