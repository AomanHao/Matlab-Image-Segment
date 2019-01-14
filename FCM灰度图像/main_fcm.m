%% �������
% �����ʵ��ѧͼ�����Ŷ�-�º�
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
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
% I=I;%��������
%I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %����ͼ
% I=imnoise(I,'gaussian',0,0.01); % �Ӹ�˹����

%ѭ��������
% I=imnoise(I,'gaussian',0,noise); % �Ӹ�˹����
%  I=imnoise(I,'salt & pepper',noise); %�ӽ�����ͼ
 
figure;imshow(I);title('(b)����ͼ��');
imwrite(I,'2.jpg');
[m,n]=size(I);
%k ������Ŀ
k=2;
% k=3;

I4 = I(:);  %% ��ͼ��ҶȰ�������
%% ------------------------ fcm�㷨------------------------
fcm_spatial_mean_label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = fcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
%% ���������ԭ��
maxU2 = max(U2);   %���������  
for j=1:k
    index = find(U2(j, :) == maxU2);  %����������Ӧ������λ��
    fcm_spatial_mean_label(index) = j;    
end
labels2=reshape(fcm_spatial_mean_label,[m n]);
labels2=uint16(labels2);

%% ��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=180;
labels2(find(labels2==4))=100;
labels2=uint8(labels2);
figure;imshow(labels2,[]);title('(c)����ָ�ͼ');
imwrite(labels2,'3.1.tiff','tiff','Resolution',300);%������������ΪtifͼƬ

