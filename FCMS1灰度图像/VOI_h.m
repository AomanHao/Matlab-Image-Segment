function Vol=VOI_h(clabels,labels2,k)

%clabels标准分割图,labels2自我分割图,k分类数
%%
[m,n]=size(labels2);M=m*n;
logsum1=0;logsum2=0;logsum3=0;
for i=1:k
    index1=find(clabels==i);%是标准图第i类数据数量
    len1=length(index1);
    logsum1=logsum1+(len1/M)*log(len1/M);%h(s)自信息
    
    index2=find(labels2==i);%数据数量
    len2=length(index2);
    logsum2=logsum2+(len2/M)*log(len2/M);%h(g)自信息
        for j=1:k
        index_j=find(labels2==j);%数据数量
        len3(j,:)=length(intersect(index1,index_j));
        end
    len3=max(len3);
    logsum3=logsum3+(len3/M)*log(len3/M)*(len2/M*len1/M);%h(s)h(g)互信息
end
Vol=-logsum1-logsum2-2*logsum3;

