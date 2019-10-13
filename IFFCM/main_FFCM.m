%% ������� 
% �����ʵ��ѧͼ�����Ŷ�-�º�
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
%--------------------------------------

clear
close all
clc
%% %%%%%%%%%%%%%%%ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=imread('3096.jpg');
figure;imshow(I);title('(a)ԭʼͼ��');imwrite(I,'1.1.tiff','tiff','Resolution',300);%����Ϊtif

if size(I,3) == 3
   I=rgb2gray(I);
else
end
figure;imshow(I);title('(b)�Ҷ�ͼ��');imwrite(I,'1.2.tiff','tiff','Resolution',300);%����Ϊtif

%������
k=2;
[m,n]=size(I);

I=im2double(I);
I4 = I(:);  %% ��ͼ��ҶȰ�������

%% ------------------------ IFFCM�㷨------------------------
label=zeros(m*n,1);
t=cputime;
tic;
[center, U, obj_fcn2] = iffcm(I4,k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U);   %���������  
for j=1:k
    index = find(U(j, :) == maxU2);  %����������Ӧ������λ��
    label(index) = j;    
end
labels2=reshape(label,[m n]);

%% ��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=180;
labels2(find(labels2==4))=100;
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%����Ϊjpg
figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.tiff','tiff','Resolution',300);%����Ϊtif
