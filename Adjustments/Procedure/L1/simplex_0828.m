function Sim = simplex_0828(A,B,C,D,delta)
%% ssimplex(A,B,C,D)
%% Function:ʵ�ֵ����η��ж����Ž�
%% inputs:
% A % Լ��������ϵ������
% B % Լ�������ĳ���������
% C % Ŀ�꺯����ϵ������
% D % �����ֵΪ1������СֵΪ0
% delta % �����Ĵ���
%% outputs:
% X % Ŀ�꺯�������Ž�
% Z % Ŀ�꺯���ļ�ֵ
%%%%%%%%%%%%%%%%%%%%%%% Test code %%%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[1 2 1 0 0;4 0 0 1 0;0 4 0 0 1];
% B=[8;16;12];
% C=[2 3 0 0 0];
% D=1;
% delta=0;
%%
a=1;
Z=0;Zn=[];
[m,n] = size(A);
Bi = n-m+1:n;         %���������±�
if D==0
    C=-C;         %����Сֵ�轫Ŀ�꺯��ϵ��ȡ��
end
if (n < m)
    disp('ϵ���������')
else
    while a
        Cb = C(Bi);
        Zi = (Cb)*A;
        Ri =C-Zi;                   %������
        X = zeros(1,n);
        
        for i=1:m
            X(Bi(i))=B(i);     
        end
        for i=1:n
            Z=Z+(C(i)*X(i));
        end
        Zn = [Zn;Z];
        Z=0;
        
        if max(Ri)<=0               %�жϼ�����
            for i=1:m
                X(Bi(i))=B(i);     %��ǰXֵ��Ϊ���Ž⣬���
            end
            for i=1:n
                Z=Z+(C(i)*X(i));
            end
            a = 0;
            %                fprintf('��������Ϊ:%d\n',delta);
            %                disp('���ҵ����Ž⣺')
            %                delta;
            break;
        else
            delta = delta+1;
            [~, k1] = max(Ri);     %��û����������λ�ã���Rj���ֵ��λ����������k1
            for i=1:m
                if A(i,k1)>0
                    P(i)=B(i)/A(i,k1);
                else
                    P(i)=inf;
                end
            end
            [~, k2]=min(P);    %�ҵ�����������λ�ò�����k2
            Bi(k2)=k1;         %�µĻ�����
            F=[B,A];           %��B,A�ϳ��¾�����г��ȱ任����
            F(k2,:)=F(k2,:)/F(k2,k1+1); %��A��k2�У�����A��k2�У�k1�У�����E
            for i=1:m
                if(i==k2)
                    continue;
                end
                while 1
                    F(i,:)= F(i,:)-F(i,k1+1)*F(k2,:);  %��F���г����л�
                    if(F(i,k1+1)==0)
                        break;
                    end
                end
                B=F(1:m,1);
                A=F(1:m,2:n+1);
            end
        end
    end
end

Sim.X = X;
Sim.Z = Z;
Sim.Inter = delta;


