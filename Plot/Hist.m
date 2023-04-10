% ��Ƶ�ʷֲ�ֱ��ͼ
function Hist(x,xnum,FigName)
[counts,centers] = hist(x,xnum);%���ĸ���Ϊ5���ɸ����Լ���Ҫ����
x1=centers;%ÿ����������x����
y1=counts / sum(counts);%ÿ�����ĸ�����Ƶ�����������ܸ����ı�ֵ

% �ֲ��������
[mu,sigma]=normfit(x);%����̬�ֲ���ϳ�ƽ��ֵ�ͱ�׼��

% ����֪�ֲ��ĸ����ܶ�����
x2 = centers(1)*0.5:((centers(end)-centers(1)))/1000:centers(end)*1.5;
x2 =-centers(end)*1.5:((centers(end)-centers(1)))/1000:centers(end)*1.5;
y2 = pdf('Normal', x2, mu,sigma);%probability density function������x2����pdfֵ

[hAxes,hBar,hLine]=plotyy(x1,y1,x2,y2,'bar','plot');
set(hLine,'color',[1,0,0],'LineWidth',1,'Marker','o','MarkerSize',2,...
    'MarkerFace','y')
xlabel([FigName '/m'])
ylabel(hAxes(1),'Frequency','FontName','Times New Roman')
ylabel(hAxes(2),'Probability density','FontName','Times New Roman')
% saveas(h1,[FigName '.jpg'])
