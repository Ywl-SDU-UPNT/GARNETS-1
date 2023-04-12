function [AcousticData,SVPData,Par] = DataLoding(ObsPath,SVPPath,ConfigPath,JapPath)

%% ++++Data reading and information acquisition++++
% Reading acoustic observation data
AcousticData   = ReadNSinex(ObsPath);
% Configuration information
ObsInf = AcousticData.Header;
% Observation session information
SessionInf = str2num(ObsInf.Sessions);  
SesNum = length(SessionInf);
% Seafloor transponder information
SPNoInf = str2num(ObsInf.Site_No);  
SPNoNum = length(SPNoInf);
% Reading GARPOS results file
JapSol        = ReadNSinex(JapPath);
% Initial value of seafloor transducer position
x0s           = Extraction_x0(JapSol);
x_Jap         = [x0s(:,2),x0s(:,1),x0s(:,3)];
% Reading configuration information file
ConfigInf = ReadNSinex(ConfigPath);
% Arm Length 
ArmLen = ConfigInf.Model_parameter.ANT_to_TD.ATDoffset(1:3);
% Reading Sound speed profile observation data
SVP     = ReadNSinex(SVPPath);
SVPData = SVP.Data.depth;

%% ++++Parameters configuration++++
% Data information 
Par.SesNum     = SesNum; 
Par.SPNoNum    = SPNoNum; 
Par.SPNoInf    = SPNoInf;
% Solution strategy configuration   
Par.ArmLen     = ArmLen;               % Arm length
Par.x0s        = x_Jap;                % Initial value of seafloor transducer position
Par.BreakTime  = 1.3 * 60;             % Data breakpoint detection time
Par.MedBreak   = 3000000000 * 60;      % Centre point breakpoint detection time
Par.MedTime    = 3000000000 * 60;      % Centre point delay segmentation time
Par.WeightType = 0;                    % 0(Height angle weighting) or 1(Euqal weighting) 
% Main parameter constraints
Par.Mu_ZenDelay  = 0;        % Zenith delay parameter constraints
Par.Mu_HorDelay  = [0 0];    % Horizontal delay parameter constraints
Par.Mu_MedDelay  = [10000 10000 10000];   % Centre point delay parameter constraints
% Continuity constraints parameter
Par.Mu_ConZen = 1;   % Zenith delay continuity Constraint
Par.Mu_ConHor = 1;   % Horizontal delay continuity Constraint
Par.Mu_ConMed = 1;   % Centre point delay continuity Constraint                    
Par.ConWeight = 3;    
% Solution parameter configuration
Par.MaxIter     = 20;       % Maximum Iterations
Par.Termination = 10^-4;    % Iteration termination condition
Par.RobK1       = 3;        % Robust range K1
Par.RobK2       = 5;        % Robust range K2

end