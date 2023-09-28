clear
close all
clc
% Code extraction for A. Gumus
% New code after the discussion with M. Wuilpart
%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fsamp=1e9;      % digitizer sampling frequency 
dt=1/fsamp;     % sampling interval (s)
ds=3e8/1.468*dt*0.5;    % spatial sampling resolution (m)

nsamples=45000;         % number of samples per OTDR trace
ts=0:dt:dt*(nsamples-1);% fast time array (s)
s=3e8/1.468*ts*0.5;     % position array (m)

Delta_f=160e6;          % frequency shift applied by the AOM

Tpulse=100e-9;                % pulse width in second
s_resol=3e8/1.468*Tpulse*0.5; % width of the resolution cell
n_resol=floor(Tpulse/dt)+1;   % number of points in each resol cell


%%%%%%%%%%%%%%%%%%%%%%%%%%% LOAD MAT FILE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trname='08Sept2017_1V_500Hz';          %!-->File name of the data set<---!
load(trname);
trace=RecordsDataB;
trace=trace-mean(trace); % Eliminati%trace=hilbert(double(trace));
trace=double(trace);     % convert to double

%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALISATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tracematrix=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%% BAND PASS FILTER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%hd = design(fdesign.bandpass('N,Fc1,Fc2',40,120e6,200e6,1e9));
hd = design(fdesign.bandpass('N,Fc1,Fc2',50,158e6,162e6,1e9));
% 120 MHz TO 200 MHz, Nth Degree Filter
fvtool(hd);
%y = filter(hd,x);

%%%%%%%%%%%%%%%%%%%%%%%%%%% ARRANGE TRACES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrecs=0;
while(length(trace)-nrecs*nsamples)>=nsamples
    startind=nsamples*nrecs+1; % start index of an OTDR trace
    endind=startind+nsamples-1;% end index of an OTDR trace
    %filtered_trace = filter(hd,trace(startind:endind)); %BandPass Filter around AOM freq
    tracematrix=[tracematrix;trace(startind:endind)]; %traces are arranged in the matrix
    %tracematrix=[tracematrix;filtered_trace]; %filtered traces are arranged in the matrix
    % each line contains one OTDR trace
    nrecs=nrecs+1; % next trace
    
end
disp(['number of records',trname,'=',int2str(nrecs)])
norecords=nrecs; % Number of acquired traces

AmpMatrix=zeros(nrecs,nsamples);
PhaseMatrix=zeros(nrecs,nsamples);
PhaseMatrix_avg=zeros(nrecs,nsamples);
PhaseDiffMatrix=zeros(nrecs,nsamples); % Difference of angles between phi(t1) and phi(t1-Tpulse)

%%%%%%%%%%%%%%%%%%%%%%%%%%% DISPLAY RAW TRACES %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure,
for i=1:nrecs
    
    plot(s, tracematrix(i,:))
  
    hold on
    
end
xlabel('Position (m)')
ylabel('Backscatter Counts')
title('RAW Backscatter Counts')
grid on


