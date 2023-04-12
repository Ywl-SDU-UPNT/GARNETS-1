%{
        % ===============Function Introduction===============
        This is the main function of GARNETS, which can be used to perform single point and network 
        solutions using overall or single segment observation data. Before using this function, we suggest 
        watching Example1 and Example2 first to become more familiar with the application of the function
        % ===============Instructions===============
        To use this function, you need to set the solution mode, where 0 is the single point solution 
        and 1 is the network solution, followed by setting the time segment of the zenith acoustic delay
        % ===============Copyright===============
        Shuqiang Xue,Wenlong Yang
%}

clc
clear all

%% ++++Data file path++++
% Data storage path
PublicPath = '.\WorkSpace\MYGI\';
% Station name
SerialInf  = 'MYGI.1204.meiyo_m4';
% Acoustic observation data
ObsPath    = [PublicPath,'Obs',SerialInf,'-obs','\' SerialInf,'-obs.GNSSA'];
% Sound speed profile observation data
SVPPath    = [PublicPath,'Obs',SerialInf,'-svp','\' SerialInf,'-svp.SVP'];
% Configuration information file
ConfigPath = [PublicPath,'Config\',SerialInf '-initcfg.ini'];
% GARPOS solution results
JapPath    = [PublicPath,'JapSol\',SerialInf '-res.dat'];
% Loading observation data 
[AcousticData,SVPData,Par] = DataLoding(ObsPath,SVPPath,ConfigPath,JapPath);
Par.ZenTime    = 5 * 60;               % Zenith delay segmentation time
Par.HorTime    = 30 * 60;              % Horizontal delay segmentation time

%% ++++Data solving++++
% SolRes = [GARNETS,GARPOS,Difference];
% Delay  = {[Zenith Delay],[NDelay,EDelay]};

%% -------Network solution and single point solution of whole-sessions-------
% Par.SolModel   = 0;                    % Solving model(0:Single point solution,1:Network solution)
% Par.SingleSPNO = 1;                    % Single point solution point number
% if Par.SolModel == 0
%     Par.Mu_Main      = [zeros(1,3) 1000 1000 10000 100000*ones(1,1) 10000]; 
% else
%     Par.Mu_Main      = [zeros(1,3*Par.SPNoNum) 1000 1000 10000 100000*ones(1,Par.SPNoNum) 10000];
% end
% [SolRes,Delay,dL_Com_Rob,TimeInf] = NetworkSolver(AcousticData,SVPData,Par);
% % Figure1:Delay series of whole-sessions
% PlotDelaySeries(AcousticData,Delay,TimeInf)

%% -------Network solution of multi-sessions-------
Par.SolModel   = 1;                    % Solving model(0:Single point solution,1:Network solution)
Par.SingleSPNO = 1;                    % Single point solution point number
Par.Mu_Main      = [zeros(1,3*Par.SPNoNum) 1000 1000 10000 100000*ones(1,Par.SPNoNum) 10000]; 
for i = 1:Par.SesNum
    SesObsPath = [PublicPath,'Obs',SerialInf,'-obs','\' SerialInf,'-obs','_S_',num2str(i),'_L_Inf_M_Inf','.GNSSA'];
    SesAcouData = ReadNSinex(SesObsPath);
    [SolRes,Delay,dL_Com_Rob,TimeInf] = NetworkSolver(SesAcouData,SVPData,Par);
    SesRes          = SolRes(:,3:5)';
    Ses_Result(i,:) = SesRes(:);
    SesTime(:,i)    = TimeInf.ObsTime;
    SesDelay{i}     = Delay;
end
% Figure1:Error series of positioning
PlotPositionRes(Ses_Result,SesTime,TimeInf,Par.SPNoInf)
% Figure2:Error distribution of positioning
PlotResidualdistribution(Ses_Result)

%% -------Single point solution of multi-sessions-------
% Par.SolModel   = 0;                    % Solving model(0:Single point solution,1:Network solution)
% Par.SingleSPNO = 1;                    % Single point solution point number
% Par.Mu_Main      = [zeros(1,3) 1000 1000 10000 100000*ones(1,1) 10000];
% SesObsPath = [PublicPath,'Obs',SerialInf,'-obs','\' SerialInf,'-obs','_S_',num2str(Par.SingleSPNO),'_L_Inf_M_Inf','.GNSSA'];
% SesAcouData = ReadNSinex(SesObsPath);
% [SolRes,Delay,dL_Com_Rob,TimeInf] = NetworkSolver(SesAcouData,SVPData,Par);
% % Figure1:Delay series of single-point positioning of multi-sessions
% PlotDelaySeries(SesAcouData,Delay,TimeInf)













