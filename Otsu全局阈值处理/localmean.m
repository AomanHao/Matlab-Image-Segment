function mean=localmean(f,nhood)%该函数的作用是计算局部均值
if nargin==1
    nhood=ones(3)/9;
else nhood=nhood/sum(nhood(:));
end
mean=imfilter(tofloat(f),nhood,'replicate');