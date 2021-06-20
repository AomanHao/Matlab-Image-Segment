%% 程序分享 
% 个人博客 https://www.aomanhao.top
% Github https://github.com/AomanHao
%参考 http://blog.sina.com.cn/s/blog_bfb1429c0101io39.html
%论文 https://www.hindawi.com/journals/cmmm/2013/592790/
%--------------------------------------

clear
close all
clc
%% ****************************最大熵图像分割*********************
img=imread('3096.jpg');
if size(img,3) == 3
   I=rgb2gray(img);
else
end
    Gray_image = rgb2gray(I);
   imshow(Gray_image);
    [nrow ncol] = size(Gray_image);
   
    % using CLAHE operation,then get its CLAHE_image
    CLAHE_image = adapthisteq(Gray_image,'ClipLimit',0.01);%bigger ClipLimit,more contrast
   %imshow(CLAHE_image);
   
    %the nlfilter method send 0 value to the neighbor of the boundary
    %using nlfilter method to get its similarity image, myfunction is self-defined
    N = 5;
   similarity_image=nlfilter(CLAHE_image,[N,N],@Myfun);
   %disp(similarity_image);
    %in myfunction：the threshold value e is equal to 5
   
    %get the CCLSC histogram,get h(k,m)
   h=zeros(255,N*N);
   numpixel_Fequalk=zeros(255,N*N);
   numpixel_Gequalm=zeros(255,N*N);
    for k1=1:255   % the smallest k is equal to 1 in Matlab
       for m1=1:N*N
           numpixel_Fequalk(k1,m1)=length(find(CLAHE_image==k1))/(nrow*ncol);
           numpixel_Gequalm(k1,m1)=length(find(similarity_image==m1))/(nrow*ncol);
           h(k1,m1)=numpixel_Fequalk(k1,m1)*numpixel_Gequalm(k1,m1);
       end
    end
   %figure;bar3(h);
   
    % computation of object and background probability distributions
   P=zeros(1,255);
    for t1 = 1:1:255
       P(t1)=sum(h(t1,:));
    end
%     r(P);
   %disp(sum(P));
   
   F=zeros(1,254);
   Ho=zeros(1,254);
   Hb=zeros(1,254);
    for t2 = 1:1:254
       if P(t2)==0
           continue;
       else
           Po0=zeros(1,t2);
           Po=zeros(1,254);
           for k2 = 1:1:t2
               Po0(k2)=P(k2);
           end
           Po(t2)=sum(Po0);
           
           Pb0=zeros(1,255);
           Pb=zeros(1,254);
           for k3 = (t2+1):1:255
               Pb0(k3)=P(k3);
           end
           Pb(t2) = sum(Pb0);
           
           H0=zeros(255,N*N);
           Pobj=zeros(255,N*N);
           for k4=1:255   % the smallest k is equal to 1 in Matlab
               for m4=1:N*N
                   if h(k4,m4)==0
                       continue;
                   else
                       Pobj(k4,m4)=h(k4,m4)/Po(t2);
%                        H0(k4,m4)=-Pobj(k4,m4)*log(Pobj(k4,m4))*weight(m4,N);
                        H0(k4,m4)=-Pobj(k4,m4)*log(Pobj(k4,m4));
                   end
               end
           end
           
           H1=zeros(255,N*N);
           Pback=zeros(255,N*N);
           for k5=1:255   % the smallest k is equal to 1 in Matlab
               for m5=1:N*N
                   if h(k5,m5)==0
                       continue;
                   else
                       Pback(k5,m5)=h(k5,m5)/Pb(t2);
%                        H1(k5,m5)=-Pback(k5,m5)*log(Pback(k5,m5))*weight(m5,N);
                         H1(k5,m5)=-Pback(k5,m5)*log(Pback(k5,m5));
                   end
               end
           end
           
           Ho0=zeros(1,t2);
           for k6 = 1:1:t2
               Ho0(k6)=sum(H0(k6,:));
           end
           Ho(t2)=sum(Ho0);
           
           Hb0=zeros(1,255);
           for k7 = (t2+1):1:255
               Hb0(k7)=sum(H1(k7,:));
           end
           Hb(t2) = sum(Hb0);
       end
    end
   
    for t3=1:254
       F(t3)=Ho(t3)+Hb(t3);
    end
   
    % next step is to find the max F(t,N) to determine the desired T
   T=find(F==max(F));
   disp(T);
   
    % then we should get it's binary image of I by using threshold value T
   binary_image=zeros(nrow,ncol);
    for i=1:nrow
       for j=1:ncol
           if Gray_image(i,j)<=T
               binary_image(i,j)=1; %感兴趣的区域用白色表示，故掩模图像此区域
           end
       end
    end
    %figure; imagesc(binary_image);% 得到了掩模图像
   
    % result_image=binary_image*I（input image）
   result_image=ones(nrow,ncol);
    for i=1:nrow
       for j=1:ncol
           result_image(i,j)=binary_image(i,j)*Gray_image(i,j);
       end
    end
    %figure; imagesc(result_image);
   
    % using fill-holes method
   fillhole_image=imfill(result_image,'holes');
    %figure; imagesc(fillhole_image);
   
    % next step is to apply amedian filtering method
   Postprocess_image= medfilt2(fillhole_image,[3 3]);
   %figure;imagesc(Postprocess_image);
   
    %using Ostu's segmentation method
    level = graythresh(Postprocess_image);
    BW = im2bw(Postprocess_image,level);
   
   picture_name_rezerve=strcat(num2str(i_index),'th_result.png');
   imwrite(BW,picture_name_rezerve,'png');
end