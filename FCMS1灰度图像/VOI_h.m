function Vol=VOI_h(clabels,labels2,k)

%clabels��׼�ָ�ͼ,labels2���ҷָ�ͼ,k������
%%
[m,n]=size(labels2);M=m*n;
logsum1=0;logsum2=0;logsum3=0;
for i=1:k
    index1=find(clabels==i);%�Ǳ�׼ͼ��i����������
    len1=length(index1);
    logsum1=logsum1+(len1/M)*log(len1/M);%h(s)����Ϣ
    
    index2=find(labels2==i);%��������
    len2=length(index2);
    logsum2=logsum2+(len2/M)*log(len2/M);%h(g)����Ϣ
        for j=1:k
        index_j=find(labels2==j);%��������
        len3(j,:)=length(intersect(index1,index_j));
        end
    len3=max(len3);
    logsum3=logsum3+(len3/M)*log(len3/M)*(len2/M*len1/M);%h(s)h(g)����Ϣ
end
Vol=-logsum1-logsum2-2*logsum3;

