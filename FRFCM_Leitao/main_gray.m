% Please cite the paper "Tao Lei, Xiaohong Jia, Yanning Zhang, Lifeng He, Hongying Meng and Asoke K. Nandi, Significantly Fast and Robust
% Fuzzy C-Means Clustering Algorithm Based on Morphological Reconstruction and Membership Filtering, IEEE Transactions on Fuzzy Systems,
% DOI: 10.1109/TFUZZ.2018.2796074, 2018.2018"

% The paper is OpenAccess and you can download the paper freely from "http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8265186."
% The code was written by Tao Lei in 2017.
% If you have any problems, please contact me. 
% Email address: leitao@sust.edu.cn

clc
close all     
clear 
%% test a gray image %%%%%%%%%%%%%%%%%图像%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=imread('3096.jpg');
if size(I,3) == 3
   I_OR=rgb2gray(I);
else
end
figure;imshow(I_OR);title('(a)原始图像');imwrite(I_OR,'1.tiff','tiff','Resolution',300);%保存为tif

%I=I;%不加噪声
% I=imnoise(I,'speckle',deta_2);
% I=imnoise(I,'salt & pepper',0.05); %加噪图
I_noise=imnoise(I_OR,'gaussian',0,0.01); % 加高斯噪声

figure;imshow(I_noise);title('(b)加噪图像');
[m,n]=size(I_noise);
I_noise=im2double(I_noise);
%% parameters
cluster=2; % the number of clustering centers
se=3; % the parameter of structuing element used for morphological reconstruction
w_size=3; % the size of fitlering window
%% segment an image corrupted by noise
tic 
[center1,U1,~,t1]=FRFCM(I_noise,cluster,se,w_size);
Time1=toc;
disp(strcat('running time is: ',num2str(Time1)))
f_seg=fcm_image(I_noise,U1,center1);
imshow(I_noise),title('Original image');
figure,imshow(f_seg);title('segmentated result');
