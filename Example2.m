%{
        % ===============Function Introduction===============
        This is an example of how to use network solutions and single point functionality to solve all data..
        At the same time, the calculation results of GARNETS and GAPOS were provided, and the 
        temporary zenith acoustic delay (ZAD) component time series were plotted.
        % ===============Instructions===============
        To use this function, you need to set the solution mode, where 0 is the single point solution 
        and 1 is the network solution, followed by setting the time segment of the zenith acoustic delay
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
if Par.SolModel == 0
    Par.Mu_Main      = [zeros(1,3) 1000 1000 10000 100000*ones(1,1) 10000]; 
else
    Par.Mu_Main      = [zeros(1,3*Par.SPNoNum) 1000 1000 10000 100000*ones(1,Par.SPNoNum) 10000]; 
end

%% ++++Data solving++++
% SolRes = [GARNETS,GARPOS,Difference];
% Delay  = {[Zenith Delay],[NDelay,EDelay]};
%% -------Network solution and single point solution of whole-sessions-------
[SolRes,Delay,dL_Com_Rob,TimeInf] = NetworkSolver(AcousticData,SVPData,Par);
GARNETS_Res = SolRes(:,3:5);
GARPOS_Res  = SolRes(:,7:9);
ResDiff     = SolRes(:,11:13);
% Figure1:Delay series of whole-sessions
PlotDelaySeries(AcousticData,Delay,TimeInf)
