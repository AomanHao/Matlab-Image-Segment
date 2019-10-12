function U_new=u_return(U,data)
%%
%快速模糊处理的隶属度（256级）返回给数据（MXN）
U_new=zeros(1,size(data,1));
% I=data*255;
% histrate=zeros(256,1);%每个灰度级的频数
% for i=1:256
%     temp=find(I==(i-1));
%     histrate(i,:)=length(temp);   
% end
I=data*255;
%-----------把256级的隶属度返回给整张图数据-----------
for i=1:256
    temp=find(I==i);
    if isempty(temp)
    else
        for j=1:size(U,1)
            U_new(j,temp)=U(j,i);
        end
    end   
end