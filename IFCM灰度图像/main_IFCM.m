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

k=3;%����������Ŀ

I4 = I(:);  %% ��ͼ��ҶȰ�������
%% ------------------------ ifcm------------------------
ifcm__label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %���������  
for j=1:k
    index = find(U2(j, :) == maxU2);  %����������Ӧ������λ��
    ifcm__label(index) = j;    
end
labels2=reshape(ifcm__label,[m n]);
labels2=uint16(labels2);

%��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=125;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%����Ϊjpg
figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.tiff','tiff','Resolution',300);%����Ϊtif
