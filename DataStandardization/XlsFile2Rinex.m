function WriteFilePath = XlsFile2Rinex(iObsFilePath,RowIdx,ColIdx,HeadCol,Suffix,FileTemFun)
%% ��׼����ת��
[Obs IdxText] = XlsFileRead(iObsFilePath,RowIdx,ColIdx,HeadCol);

%% ��xls�ļ����ݣ��洢Ϊ��׼���ݸ�ʽ
% �����ļ���
[NewFileName,OldFilePath,OldFileName] = FileSuffixChange(iObsFilePath,Suffix);
%%�����ļ�·��
status = mkdir([OldFilePath OldFileName]);
if ~status
   display('�����ļ���ʧ��')
end
%%�����ļ�
WriteFilePath = [OldFilePath OldFileName '\' NewFileName];
%%д���ļ�
Data = Cell2Data(Obs);
% �޸� N E ˳��
DataCol = size(Data,2);
if DataCol == 22
    Data(:,10:11) = Data(:,[11,10]);
    Data(:,17:18) = Data(:,[18,17]);
end

[HeadItem HeadContent IdxText1 formats] = FileTemFun();
%% ��ѡ��ʹ��ģ��ֵ����idxText1�� ���߼̳�ԭ�ļ�ֵ
RinexFileWrite(WriteFilePath,HeadItem,HeadContent,IdxText,Data,formats);
end