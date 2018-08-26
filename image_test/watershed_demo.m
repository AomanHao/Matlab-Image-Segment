%% 不用分水岭进行分割
I=imread('rice.png');
J=imtophat(I,strel('disk',15));
bw=im2bw(J,graythresh(J));
bw_opened=bwareaopen(bw,5);
L1=bwlabel(bw_opened);
rgb1=label2rgb(L1, 'spring', 'c', 'shuffle');
figure
subplot(1,2,1),imshow(I),title('原始图像')
subplot(1,2,2),imshow(rgb1),title('不使用分水岭的分割结果')

% 使用控制标记符的分水岭分割
%% 1. Compute a segmentation function.  This is an image whose dark regions are the objects you are trying to segment.
g=imgradient(I);
figure
subplot(1,2,1),imshow(I),title('原始图像')
subplot(1,2,2),imshow(g,[]),title('原始图像的梯度')

%% 2. Compute foreground markers.  These are connected blobs of pixels within each of the objects.
% 计算前景标记需分割出所有我们感兴趣的物体，这里我们使用形态学的腐蚀方法，发现腐蚀后的结果能很好的将我们感兴趣的所有物体均分割开来；但此时若对腐蚀后的图像进行描述，如计算分割后每个物体的面积、重心等信息，则会得到错误的结果，因为腐蚀后的物体一般比实际物体的小，故需使用分水岭分割得到完整的物体，从而能得到正确的信息
im=imerode(bw,strel('rectangle',[3 3]));
figure
subplot(1,2,1),imshow(I),title('原始图像')
subplot(1,2,2),imshow(im),title('前景标记')

%% 3. Compute background markers.  These are pixels that are not part of any object.
% 计算背景标记，此处我们求解一个分水岭
Lim=watershed(bwdist(bw));
em=Lim==0;
figure,imshow(em),title('背景标记')

%% 4. Modify the segmentation function so that it only has minima at the foreground and background marker locations.
g2=imimposemin(g,im | em);
figure,imshow(g2),title('修改后的梯度图像')

%% 5. Compute the watershed transform of the modified segmentation function.
L2=watershed(g2);

%% 6. 显示分水岭的分割结果
rgb2=label2rgb(L2, 'hot', 'c', 'shuffle');
figure
subplot(1,2,1),imshow(I),title('原始图像')
subplot(1,2,2),imshow(rgb2),title('经分水岭分割后的图像')

%% 7. 最后,比较两种结果
figure
subplot(1,3,1),imshow(I),title('原始图像')
subplot(1,3,2),imshow(rgb1),title('不用分水岭的分割结果')
subplot(1,3,3),imshow(rgb2),title('使用分水岭的分割结果')