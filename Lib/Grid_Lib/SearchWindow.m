function WindowData = SearchWindow(interpolation,SearchData,WindowNum)

% ��ֵ���� = SearchWindow����ֵ�㣬�������ݣ��������ݸ�����

% �����ڸ�����������ֵ�����õ����ݷ�Χ
Different = SearchData(:,1) - interpolation;
DataNum   = size(SearchData,1);

Position = find(Different > 0);

GreaterNum = length(Position);
LessNum    = DataNum - GreaterNum;


if ~isempty(Position)

    if GreaterNum < WindowNum/2
        SearchScale = DataNum - WindowNum + 1:DataNum;
        
    elseif LessNum < WindowNum/2
        SearchScale = 1:WindowNum;
    else
        if mod(WindowNum,2) == 1
            NegativeNum = ceil(WindowNum / 2);
            PositiveNum = WindowNum -  NegativeNum;
        else
            NegativeNum = WindowNum / 2;
            PositiveNum = WindowNum / 2;
        end
        PositiveBegin = Position(1);
        SearchScale = PositiveBegin - NegativeNum:PositiveBegin + PositiveNum - 1;
    end
  
    
end    
       
WindowData = SearchData(SearchScale,:);

end