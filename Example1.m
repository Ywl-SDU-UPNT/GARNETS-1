%{
        % ===============Function Introduction===============
        This is an example of how to use network solutions functionality to solve session observation data.
        At the same time, the calculation results of the tetwork and solutions and coordinate series residual 
        distribution were plotted.
        % ===============Instructions===============
        To use this function, you need to set the time segment of the zenith acoustic delay
        % ===============Copyright===============
        Shuqiang Xue,Wenlong Yang
%}
clc;clear;close all

%% ++++Data file path++++
% Acoustic observation data
ObsPath    = '.\WorkSpace\MYGI\ObsMYGI.1204.meiyo_m4-obs\MYGI.1204.meiyo_m4-obs.GNSSA';
% Sound speed profile observation data
SVPPath    = '.\WorkSpace\MYGI\ObsMYGI.1204.meiyo_m4-svp\MYGI.1204.meiyo_m4-svp.SVP';
% Configuration information file
ConfigPath = '.\WorkSpace\MYGI\Config\MYGI.1204.meiyo_m4-initcfg.ini';
% GARPOS solution results
JapPath    = '.\WorkSpace\MYGI\JapSol\MYGI.1204.meiyo_m4-res.dat';

% Loading observation data 
[AcousticData,SVPData,Par] = DataLoding(ObsPath,SVPPath,ConfigPath,JapPath);
Par.ZenTime    = 5 * 60;               % Zenith delay segmentation time
Par.HorTime    = 30 * 60;              % Horizontal delay segmentation time
Par.SolModel   = 1;                    % Solving model(0:Single point solution,1:Network solution)
Par.SingleSPNO = 1;                    % Single point solution point number
Par.Mu_Main    = [zeros(1,3*Par.SPNoNum) 1000 1000 10000 100000*ones(1,Par.SPNoNum) 10000];

%% ++++Data solving++++
% SolRes = [GARNETS,GARPOS,Difference];
% Delay  = {[Zenith Delay],[NDelay,EDelay]};
%% -------Network solution of multi-sessions-------
for i = 1:Par.SesNum
    SesObsPath = ['.\WorkSpace\MYGI\ObsMYGI.1204.meiyo_m4-obs\MYGI.1204.meiyo_m4-obs_S_',num2str(i),'_L_Inf_M_Inf.GNSSA'];
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

