%% 程序分享 
% 西安邮电大学图像处理团队-郝浩
% 个人博客 www.aomanhao.top
% Github https://github.com/AomanHao
%--------------------------------------
clear
close all
clc

I=imread('rice.png');    
[m,n]=size(I);   
N=m*n;   
L=256;   

for i=1:L  
    count(i)=length(find(I==(i-1)));  
    f(i)=count(i)/(N);  %每个灰度对应的概率，i=1,对应灰度值为0（i-1）
end  

for i=1:L   
    if count(i)~=0   
        st=i-1;   %开始的灰度值
        break;   
    end   
end   
for i=L:-1:1   
    if count(i)~=0   
        nd=i-1;   %结束的灰度值
        break;   
    end   
end   

p=st;   q=nd-st+1;   
u=0;   
for i=1:q   
    u=u+f(p+i)*(p+i-1);  %u是像素的平均值    
    ua(i)=u;           %ua（i）是前i+p个像素的平均灰度值  (前p个无取值) 
end;   

for i=1:q   
    w(i)=sum(f(1+p:i+p));  %w（i）是前i个像素的累加概率,对应公式中P0 
end;   

w=w+eps;  
   %对照sigmaB的公式写出目标函数。实际是遍历所有值
d=(w./(1-w)).*(ua./w-u).^2;
[y,tp]=max(d);  %可以取出数组的最大值及取最大值的点   
th=tp+p;  


figure;imshow(im2bw(I,th/255),[]);  title('最大类间方差');
%% matlab自带函数
figure;imshow(im2bw(I,graythresh(I)),[]);  title('matlab自带');

