function ExtendGrid = RayGridExtend(PF,H)
[row,col] = size(PF);
% ȷ���������
PFRow = PositionDepth_PF(PF,H);
% ��ȡ���ز���Ϣ
a  = PF(PFRow-1,4);                 % �����������ݶ�
c0 = PF(PFRow-1,2);                 % �����������ٶ�
z  = PF(PFRow,1);                   % �²����
zz = PF(PFRow,1) - PF(PFRow-1,1);   % ����
V  = H - (z - zz); 
% ���ز��������
GridRayNum = (col-4)/3;
for j = 1:GridRayNum
    p = PF(1,4+j) / PF(1,2);  
    cos_alfa0 = PF(PFRow-1,4+j);   %%% ����
    cos_alfa01 = p * c0;           %%% ����
    [t1,x1,z1,L1,cos_alfa1] = SingleLayerTracing(cos_alfa0,c0,a,inf,inf,V); % ray tracing of last layer
%     ExtendGrid(j,1) = sin((j/180)*pi);
    ExtendGrid(j,1) = cos_alfa1;
%     ExtendGrid(j,1) = cos_alfa0;
    ExtendGrid(j,2) = PF(PFRow-1,GridRayNum+4+j) + x1;
    ExtendGrid(j,3) = PF(PFRow-1,2*GridRayNum+4+j) + t1;
end
end