 function [V]=inithistifcmv(data,cluster_n)
 I=data*255;
hist_num=zeros(1,256);
for i=1:256
      temp=find(I==(i-1));
    hist_num(i)=length(temp);
end
figure
plot(hist_num)
title('原图像灰度直方图曲线')


mean_hist=mean(hist_num);
std_hist=std(hist_num);

FFT_hist=fft(hist_num);
i=1:256;
std_FFT=std(i);
i=-(i.^2)/(2*std_FFT);
temp=1/(sqrt(2*pi))*exp(i);
% figure
% plot(temp)
% title('高斯滤波函数')
FFT_hist=FFT_hist.*temp;
ihist_num=abs(ifft(FFT_hist));
figure
plot(ihist_num)
title('平滑后的直方图曲线')
L=zeros(1,256);
R=L;
R(1:255)=ihist_num(2:256);
%R(256)=NaN;
R(256)=0.1;
L(2:256)=ihist_num(1:255);
%L(1)=NaN;
L(1)=0.1;
R_temp=ihist_num-R;
L_temp=ihist_num-L;
% temp=R_temp.*L_temp;
% hist_id=find(temp>0);
% L=length(hist_id);
V=[];V_value=[];
for i=1:256
    if and(R_temp(i)>0,L_temp(i)>0);
        V=[V;i/256];
        V_value=[V_value;ihist_num(i)];
    end
end

if length(V)==cluster_n
else
if length(V)<cluster_n
    n=cluster_n-length(V);
    V1=[V',rand(1,n)];
    V=V1';
else
if length(V)>cluster_n
   [max_value,idx_value]=sort(V_value,1,'descend');
   idx=idx_value(1:cluster_n,1);%判断灰度值返图数据大小然后排序，找到峰值最大的几个
   V=V(idx);
end
end
end


disp('初始聚类中心')
V
disp('聚类个数')
length(V)
% hist_precent=hist_num./sum(hist_num);
% 
% temp2_num=repmat(0:255,length(center),1);
% precent=repmat(hist_precent,length(center),1);
% num=repmat(hist_num,5,1);
% bestJ=NaN;
% for i=1:1000
%     temp_center=repmat(center',1,256);
%     u=(temp2_num-temp_center+0.1).^(-2);
%     dis=(temp2_num-temp_center).^2+0.1;
%      u1=sum(1./dis);
%      u1=repmat(u1,length(center),1);
%      u=u./u1;
%     D=u.^2;
%     D2=D.*precent;
%    % temp=repmat(D2,5,1)+0.00001;
%    % temp=1./temp;
%    % u=(dis.*D2).^2;
%   J(i)=sum(sum(D2));
%  
%   temp=temp2_num.*D2;
%   center1=center;
%   center=(sum(temp,2)./sum(D2,2))';
%   if sum((center1-center).^2)<0.01
%       disp('聚类中心为')
%       center
%       disp('迭代次数')
%       i
%         break
%     end
%     bestJ=J(i);
% end
