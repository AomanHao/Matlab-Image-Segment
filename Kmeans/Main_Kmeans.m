%% ������� 
% ���˲��� www.aomanhao.top
% Github https://github.com/AomanHao
% CSDN https://blog.csdn.net/Aoman_Hao
%--------------------------------------

clear
close all
clc
%% ��ȡͼ��
I=imread('3096.jpg');

%% ����K��ֵ����Ĳ�ɫͼ��ָ�
[m,n,k] = size(I);
% ������ת��m*n�У�3�е�˫���Ⱦ���
I_color = double(reshape(I, m*n, k));
% �趨������ǰ����ʼ���۵�
startdata = [10 10 200;200 200 10];
% ����K��ֵ���࣬�������ص��Ϊ2�ࣺ������ǰ����
% idClass = 1��Ӧ���Ǳ�����idClass = 2��Ӧ����ǰ��
idClass = kmeans(I_color,2,'Start',startdata);
% ���ɱ�����������
idDuck = (idClass == 1);
% ���ɱ�����������result
result = reshape([idDuck, idDuck, idDuck],[m,n,k]);
% Ϊ�˲�����ԭʼԭʼͼ�����ݣ�����һ���µ�����
I_result = I;
% ���ݱ�����������result���ѱ������ص�ĺ졢�̡�����Ԫɫ�Ҷ�ֵ������Ϊ0
I_result(result) = 0;
% ����һ���հ�ͼ�δ���
figure;imshow(I_result);title('��ɫ�ָ�');

%% ����K��ֵ����ĻҶ�ͼ��ָ�
if size(I,3) == 3
   I_gray=rgb2gray(I);
else
end
I_gr = double(I_gray(:));    %��ͼ������x����������һ��������
startdata = [0; 150];    % �趨��ʼ���۵�
idpixel = kmeans(I_gr,2,'Start',startdata);    % ����K��ֵ���࣬�������ص��Ϊ2��
% ���ݾ���������һ����idpixel�ȳ����߼�����idbw
idbw = (idpixel == 2);
% ��idbw��ԭ��һ����xͬ����С���߼����󣬱������ص��ӦԪ��ֵΪ0��ǰ�����ص��ӦԪ��ֵΪ1
result = reshape(idbw, size(I_gray));
figure;imshow(result);title('�Ҷȷָ�');    %�Զ�ֵͼ��ʽ��ʾͼ��ָ���
