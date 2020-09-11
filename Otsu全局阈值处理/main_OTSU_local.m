%% 程序分享 
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clear
close all
clc
%% %%%%%%%%%%%%%%%图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 I=imread('3096.jpg');

if size(I,3) == 3
   I=rgb2gray(I);
else
end
I=im2double(I);
figure;imshow(I);title('(a)原始图像')
imwrite(I,'1.jpg');

%% OTSU算法
[TGlobal]=graythresh(I);%计算阈值
gGlobal=im2bw(I,TGlobal);%分割图像
figure,imshow(gGlobal);title('ostu方法分割的图像');%采用全局阈值的结果

%% OTSU+标准差处理
sigma=15;%标准差图像系数
SIG=stdfilt(I,ones(3));%stdfilt函数用于计算局部标准差
figure,imshow(SIG,[]);title('局部标准差图像');
g=(gGlobal>sigma*SIG) & gGlobal;%合成图像
figure,imshow(g);title('OTSU+STD图像');


