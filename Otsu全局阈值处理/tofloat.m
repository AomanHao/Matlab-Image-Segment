function [out,revertclass]=tofloat(in)%将数据类型转换为浮点数
identity=@(x) x;
tosingle=@im2single;
table={'uint8',tosingle,@im2uint8
    'uint16',tosingle,@im2uint16
    'logical',tosingle,@logical
    'double',identity,identity
    'single',identity,identity};
classIndex=find(strcmp(class(in),table(:,1)));
if isempty(classIndex)
    error('unsupported input image class');
end
out=table{classIndex,2}(in);
revertclass=table{classIndex,3};