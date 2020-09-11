%% ������� 
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clear
close all
clc
%% %%%%%%%%%%%%%%%ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 I=imread('3096.jpg');

if size(I,3) == 3
   I=rgb2gray(I);
else
end
I=im2double(I);
figure;imshow(I);title('(a)ԭʼͼ��')
imwrite(I,'1.jpg');

%% OTSU�㷨
[TGlobal]=graythresh(I);%������ֵ
gGlobal=im2bw(I,TGlobal);%�ָ�ͼ��
figure,imshow(gGlobal);title('ostu�����ָ��ͼ��');%����ȫ����ֵ�Ľ��

%% OTSU+��׼���
sigma=15;%��׼��ͼ��ϵ��
SIG=stdfilt(I,ones(3));%stdfilt�������ڼ���ֲ���׼��
figure,imshow(SIG,[]);title('�ֲ���׼��ͼ��');
g=(gGlobal>sigma*SIG) & gGlobal;%�ϳ�ͼ��
figure,imshow(g);title('OTSU+STDͼ��');


