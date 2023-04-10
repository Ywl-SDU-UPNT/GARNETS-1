function [T,Y,Z,L,theta,Iteration,RayInf] = P2PInvRayTrace(S,R,PF)
%% inputs:
% + S     %   ���Ƶ�
% + R     %   ������
% + PF    %   ��������

% % ������Կ���
% [Control,Par] = RayTracing_ControlSystem();

% ���Ƶ㡢�����㴦��
[S,R] = PreProcessingPoints(S,R);

% for sound ray tracing
Horizontal = norm(S(1:2) - R(1:2));
Depth      = R(3) - S(3);

% In most cases, the tracing is not started from the sea surface
if S(3) > 0
    PF = SplitPF(PF,S(3),PF(end,1));
end
[T,Y,Z,L,theta,Iteration,RayInf] = InvRayTrace(PF,+inf,Horizontal,Depth);
end

%% 3D recovery
% Z  = Z  + S(3);
% zz = zz + S(3);
% XX = ei(1) * Horizontal;
% YY = ei(2) * Horizontal;