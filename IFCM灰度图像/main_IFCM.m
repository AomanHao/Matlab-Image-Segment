clear
close all
clc
%%%%%%%%%%%%%%%%%ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I=imread('42049.jpg'); 
 I=imread('238011.jpg');
% I=imread('15088.jpg');
%  I=imread('3063.jpg');
%  I=imread('135069.jpg');
%   I=imread('8068.jpg');
%  I=imread('mmi3.png');
%  I=imread('3096.jpg');
%  I=imread('167062.jpg');
%  I=imread('24063.jpg');
%I=imread('sq2.png');


if size(I,3) == 3
   I=rgb2gray(I);
else
end
figure;imshow(I);title('(a)ԭʼͼ��');imwrite(I,'1.jpg');
%I=I;%��������
% I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %����ͼ
% I=imnoise(I,'gaussian',0,0.01); % �Ӹ�˹����
%�������
%I1=imnoise(I,'salt & pepper',0.01);
%I =imnoise(I1,'gaussian',0,0.01);
figure;imshow(I);title('(b)����ͼ��');imwrite(I,'2.jpg');
[m,n]=size(I);

k=3;
r=3;
m_index=2;
beta=6;
neighbor=3;%3*3����ȥ��
lamda_s_enfcm=3;%s����

I=im2double(I);
I4 = I(:);  %% ��ͼ��ҶȰ�������

%%------------------------ fcm_spatial_mean------------------------
fcm_spatial_mean_label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %���������  
for j=1:k
    index = find(U2(j, :) == maxU2);  %����������Ӧ������λ��
    fcm_spatial_mean_label(index) = j;    
end
labels2=reshape(fcm_spatial_mean_label,[m n]);

%%%%%%%%%%%%%%%%%%%%%%%%%%׼ȷ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
labels2=uint16(labels2);
% correct = renumber(clusts_real,psofcm_label)            %����׼ȷ��
%load clabels-sq2.mat;  
load clabels-238011.mat;  
% load clabels-3063.mat;
% load clabels-3096.mat
% load clabel-135069.mat
% load clabels-15088.mat
% load clabel-8068.mat
% load clabels-167062.mat
% load clabels-24063.mat


% clabels=imread('circles.png');%�˹�ͼ�ı�׼ͼ
% clabels((clabels<50))=1;clabels((50<clabels & clabels<120) )=2;clabels((120<clabels & clabels<190))=3;clabels((190<clabels))=4;
% clabels=imread('mmi3.png');%�˹�ͼ�ı�׼ͼ
% clabels((clabels<50))=1;clabels((50<clabels & clabels<120) )=2;clabels((120<clabels & clabels<190))=3;clabels((190<clabels))=4;

correct = renumber(clabels,labels2) ;              %ͼ��׼ȷ��

%%ѡ��õľ���ͼ������-
labels3=labels2;
labels4=labels2;
labels5=labels2;

%��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=125;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%����Ϊjpg
figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.tiff','tiff','Resolution',300);%����Ϊtif
%��ʾ��׼�ָ�ͼ
img_correct=clabels;
img_correct(find(img_correct==1))=0;
img_correct(find(img_correct==2))=255;
img_correct(find(img_correct==3))=125;
img_correct(find(img_correct==4))=180;
img_correct=uint8(img_correct);
% figure;imshow(img_correct,[]);title('(d)��׼�ָ�ͼ');imwrite(img_correct,'4.jpg')%����Ϊjpg
figure;imshow(img_correct,[]);title('(d)��׼�ָ�ͼ');imwrite(img_correct,'4.tiff','tiff','Resolution',300)%����Ϊtif��300dpi
