function [V_pc,V_pe_10,V_pe_e]=V_pcpe(u)
%评价函数指标 划分系数V_pc，划分熵V_pe

[m,n]=size(u);
%% 划分系数V_pc
V_pc = sum(sum(u.^2))/n;

%% 划分熵V_pe
V_pe_10=-sum(sum(u.*log10(u)))/n;
V_pe_e=-sum(sum(u.*log(u)))/n;