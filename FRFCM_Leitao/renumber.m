function correct = renumber(clabels,labels)
%clabels=groundTruth{1,2}.Segmentation;
%labels=label;
%labels=uint16(labels);
%clabels=[1 1 2 1 1;1 2 2 2 1;2 2 1 2 2;1 2 2 2 1;1 1 2 1 1];
%labels=[1 1 2 1 1;1 2 2 2 1;2 2 2 2 2;1 2 2 2 1;1 1 2 1 1];
% clabels:标准聚类结果
% labels：自己的聚类结果
% correct：获得的准确率

labelsnum = unique(clabels);   %计算标准结果分类数
cc = zeros(length(clabels),1);  %定义一个数组存放标准结果类别数
for i = 1:length(labelsnum)
    index = find(clabels == labelsnum(i)); %抽取标准结果的像素位置
    cc(index) = i;  %所有元素对应的标签
end
L = perms(1:length(labelsnum)); % here c must be less than 15%产生所有可能的排列
                                %标签可能会不对应
L = labelsnum(L);
[hr,hc]=size(labels);
relabels=reshape(labels,hr*hc,1);
for i = 1:size(L,1)
    tmp = (L(i,:))';
    a=tmp(cc) ;
    b=(tmp(cc) == relabels);
    correct(i) = mean(tmp(cc) == relabels);
end
[correct,index] = max(correct);
tmp = (L(index,:))';
assignment = tmp(cc);

 %for i=1:c
%     index{i} = find(clabels==labelsnum(i));
% end
% for s = 1:size(L,1)
%  for t =1:c
%      clabels(index{t}) = L(s,t);
%  end
%  tempcorrect(s) = mean(labels==clabels);
% end
% [correct,ind] = max(tempcorrect);
% for t =1:c
%     clabels(index{t}) = L(ind,t);
% end
% assignment = clabels;
