classdef IGG2 < StrategyRLS
    methods
        function p = Reweight(~,k1,v)
            %% IGG1��Ȩ����
            V = abs(v);
            if V > k1
               p = 0;
            else
               p = 1;
            end
        end
    end
end