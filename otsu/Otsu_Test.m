%% ������� 
% �����ʵ��ѧͼ�����Ŷ�-�º�
% ���˲��� www.aomanhao.top
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
    f(i)=count(i)/(N);  %ÿ���Ҷȶ�Ӧ�ĸ��ʣ�i=1,��Ӧ�Ҷ�ֵΪ0��i-1��
end  

for i=1:L   
    if count(i)~=0   
        st=i-1;   %��ʼ�ĻҶ�ֵ
        break;   
    end   
end   
for i=L:-1:1   
    if count(i)~=0   
        nd=i-1;   %�����ĻҶ�ֵ
        break;   
    end   
end   

p=st;   q=nd-st+1;   
u=0;   
for i=1:q   
    u=u+f(p+i)*(p+i-1);  %u�����ص�ƽ��ֵ    
    ua(i)=u;           %ua��i����ǰi+p�����ص�ƽ���Ҷ�ֵ  (ǰp����ȡֵ) 
end;   

for i=1:q   
    w(i)=sum(f(1+p:i+p));  %w��i����ǰi�����ص��ۼӸ���,��Ӧ��ʽ��P0 
end;   

w=w+eps;  
   %����sigmaB�Ĺ�ʽд��Ŀ�꺯����ʵ���Ǳ�������ֵ
d=(w./(1-w)).*(ua./w-u).^2;
[y,tp]=max(d);  %����ȡ����������ֵ��ȡ���ֵ�ĵ�   
th=tp+p;  


figure;imshow(im2bw(I,th/255),[]);  title('�����䷽��');
%% matlab�Դ�����
figure;imshow(im2bw(I,graythresh(I)),[]);  title('matlab�Դ�');

