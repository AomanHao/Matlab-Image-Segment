function U_new=u_return(U,data)
%%
%����ģ������������ȣ�256�������ظ����ݣ�MXN��
U_new=zeros(1,size(data,1));
% I=data*255;
% histrate=zeros(256,1);%ÿ���Ҷȼ���Ƶ��
% for i=1:256
%     temp=find(I==(i-1));
%     histrate(i,:)=length(temp);   
% end
I=data*255;
%-----------��256���������ȷ��ظ�����ͼ����-----------
for i=1:256
    temp=find(I==i);
    if isempty(temp)
    else
        for j=1:size(U,1)
            U_new(j,temp)=U(j,i);
        end
    end   
end