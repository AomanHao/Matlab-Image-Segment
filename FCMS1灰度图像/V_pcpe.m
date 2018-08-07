function [V_pc,V_pe_10,V_pe_e]=V_pcpe(u)
%���ۺ���ָ�� ����ϵ��V_pc��������V_pe

[m,n]=size(u);
%% ����ϵ��V_pc
V_pc = sum(sum(u.^2))/n;

%% ������V_pe
V_pe_10=-sum(sum(u.*log10(u)))/n;
V_pe_e=-sum(sum(u.*log(u)))/n;