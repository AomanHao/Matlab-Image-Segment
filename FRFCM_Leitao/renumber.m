function correct = renumber(clabels,labels)
%clabels=groundTruth{1,2}.Segmentation;
%labels=label;
%labels=uint16(labels);
%clabels=[1 1 2 1 1;1 2 2 2 1;2 2 1 2 2;1 2 2 2 1;1 1 2 1 1];
%labels=[1 1 2 1 1;1 2 2 2 1;2 2 2 2 2;1 2 2 2 1;1 1 2 1 1];
% clabels:��׼������
% labels���Լ��ľ�����
% correct����õ�׼ȷ��

labelsnum = unique(clabels);   %�����׼���������
cc = zeros(length(clabels),1);  %����һ�������ű�׼��������
for i = 1:length(labelsnum)
    index = find(clabels == labelsnum(i)); %��ȡ��׼���������λ��
    cc(index) = i;  %����Ԫ�ض�Ӧ�ı�ǩ
end
L = perms(1:length(labelsnum)); % here c must be less than 15%�������п��ܵ�����
                                %��ǩ���ܻ᲻��Ӧ
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
