function mean=localmean(f,nhood)%�ú����������Ǽ���ֲ���ֵ
if nargin==1
    nhood=ones(3)/9;
else nhood=nhood/sum(nhood(:));
end
mean=imfilter(tofloat(f),nhood,'replicate');