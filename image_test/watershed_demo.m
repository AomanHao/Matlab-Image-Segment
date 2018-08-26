%% ���÷�ˮ����зָ�
I=imread('rice.png');
J=imtophat(I,strel('disk',15));
bw=im2bw(J,graythresh(J));
bw_opened=bwareaopen(bw,5);
L1=bwlabel(bw_opened);
rgb1=label2rgb(L1, 'spring', 'c', 'shuffle');
figure
subplot(1,2,1),imshow(I),title('ԭʼͼ��')
subplot(1,2,2),imshow(rgb1),title('��ʹ�÷�ˮ��ķָ���')

% ʹ�ÿ��Ʊ�Ƿ��ķ�ˮ��ָ�
%% 1. Compute a segmentation function.  This is an image whose dark regions are the objects you are trying to segment.
g=imgradient(I);
figure
subplot(1,2,1),imshow(I),title('ԭʼͼ��')
subplot(1,2,2),imshow(g,[]),title('ԭʼͼ����ݶ�')

%% 2. Compute foreground markers.  These are connected blobs of pixels within each of the objects.
% ����ǰ�������ָ���������Ǹ���Ȥ�����壬��������ʹ����̬ѧ�ĸ�ʴ���������ָ�ʴ��Ľ���ܺܺõĽ����Ǹ���Ȥ������������ָ��������ʱ���Ը�ʴ���ͼ����������������ָ��ÿ���������������ĵ���Ϣ�����õ�����Ľ������Ϊ��ʴ�������һ���ʵ�������С������ʹ�÷�ˮ��ָ�õ����������壬�Ӷ��ܵõ���ȷ����Ϣ
im=imerode(bw,strel('rectangle',[3 3]));
figure
subplot(1,2,1),imshow(I),title('ԭʼͼ��')
subplot(1,2,2),imshow(im),title('ǰ�����')

%% 3. Compute background markers.  These are pixels that are not part of any object.
% ���㱳����ǣ��˴��������һ����ˮ��
Lim=watershed(bwdist(bw));
em=Lim==0;
figure,imshow(em),title('�������')

%% 4. Modify the segmentation function so that it only has minima at the foreground and background marker locations.
g2=imimposemin(g,im | em);
figure,imshow(g2),title('�޸ĺ���ݶ�ͼ��')

%% 5. Compute the watershed transform of the modified segmentation function.
L2=watershed(g2);

%% 6. ��ʾ��ˮ��ķָ���
rgb2=label2rgb(L2, 'hot', 'c', 'shuffle');
figure
subplot(1,2,1),imshow(I),title('ԭʼͼ��')
subplot(1,2,2),imshow(rgb2),title('����ˮ��ָ���ͼ��')

%% 7. ���,�Ƚ����ֽ��
figure
subplot(1,3,1),imshow(I),title('ԭʼͼ��')
subplot(1,3,2),imshow(rgb1),title('���÷�ˮ��ķָ���')
subplot(1,3,3),imshow(rgb2),title('ʹ�÷�ˮ��ķָ���')