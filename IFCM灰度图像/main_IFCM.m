clear
close all
clc
%% %%%%%%%%%%%%%%%ͼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 I=imread('3096.jpg');

if size(I,3) == 3
   I=rgb2gray(I);
else
end
figure;imshow(I);title('(a)ԭʼͼ��');imwrite(I,'1.tiff','tiff','Resolution',300);%����Ϊtif
%I=I;%��������
% I=imnoise(I,'speckle',deta_2);
I=imnoise(I,'salt & pepper',0.05); %����ͼ��������
% I=imnoise(I,'gaussian',0,0.01); % �Ӹ�˹����

 
figure;imshow(I);title('(b)����ͼ��');imwrite(I,['2.',num2str(noise),'.tiff'],'tiff','Resolution',300);%����Ϊtif
[m,n]=size(I);

% k=4;
k=2;
r=3;
m_index=2;
beta=6;
neighbor=3;%3*3����ȥ��
lamda_s_enfcm=3;%s����

I=im2double(I);
I4 = I(:);  %% ��ͼ��ҶȰ�������

%% ------------------------ ifcm------------------------
ifcm_label=zeros(m*n,1);
t=cputime;
tic;
[O2, U2, obj_fcn2] = ifcm(I4, k);
toc;
time_fcm_spatial_mean=cputime-t;
maxU2 = max(U2);   %���������  
for j=1:k
    index = find(U2(j, :) == maxU2);  %����������Ӧ������λ��
   ifcm_label(index) = j;    
end
labels2=reshape(ifcm_label,[m n]);


%��ʾ����ָ�ͼ
labels2(find(labels2==1))=0;
labels2(find(labels2==2))=255;
labels2(find(labels2==3))=125;
labels2(find(labels2==4))=180;
labels2=uint8(labels2);
% figure;imshow(labels2,[]);title('(c)����ָ�ͼ');imwrite(labels2,'3.jpg');imwrite(labels2,'33.png')%����Ϊjpg
figure;imshow(labels2,[]);title('(c)����ָ�ͼ');
imwrite(labels2,['3.1.','-',noise_type,'.tiff'],'tiff','Resolution',300);%����Ϊtif



end