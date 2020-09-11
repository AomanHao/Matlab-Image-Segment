%% ������� 
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

close all;
clear;
clc;

% STEP 1: �����ɫͼ�񲢽���ת��Ϊ�Ҷ�
I_orig = imread('rice.png');
figure;imshow(I_orig);title('ԭͼ')
if(length(size(I_orig))==3)
    I = rgb2gray(I_orig);
else
    I=I_orig;
end
figure;imshow(I), title('�Ҷ�ͼ');
figure;imhist(I);title('�Ҷ�ֱ��ͼ');

% STEP 2: ʹ���ݶȷ�����Ϊ�ָ��
gmag = imgradient(I);
figure;imshow(gmag, []);title('�ݶȷ���')

L = watershed(gmag);
Lrgb = label2rgb(L);
figure;imshow(Lrgb);title('�ݶȷ��ȵķ�ˮ��任');

% STEP 3: ���ǰ������,�����㣬�ȸ�ʴ������
se = strel('disk', 20);
Io = imopen(I, se);
figure;imshow(Io);title('������');

% ��������
Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
figure;imshow(Iobr);title('��ʴͼ��');
figure;imhist(I);title('�Ҷ�ֱ��ͼ');