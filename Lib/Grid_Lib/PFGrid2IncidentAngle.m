function [y,Sig_y] = PFGrid2IncidentAngle(x,Data,p)
Different = abs(Data(:,1) - x);                       % �����������������ֵ֮��
W = 1 ./ (Different);                                 % ����������ݵ�Ȩ

[Par,S,mu] = Wpolyfit(Data(:,1),Data(:,2),p,W);       % ������ϲ���
Dx = S.Qx * S.sig;
[y,Sig_y] = polyPredict(Par,Dx,x,mu);                 % �����ֵ��   


% [Par,S,mu] = polyfit(Data(:,1),Data(:,2),p);     % ������ϲ���
% [y, ~]     = polyval(Par,x,S,mu);


end

