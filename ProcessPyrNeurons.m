function ProcessPyrNeurons(pathS)
%% data processing pipeline
%% pathS: results storing path

onlyRun = 1; % including only the running period
p = 95; % 95% significant level
pDrift = 0.005; % p value threshold for removing neurons with drift
pDriftRec = 0.05; % p value threshold for removing recordings with drift
pDriftNeu = 0.01; % p value threshold for removing neurons with drift (between 0.5 to 1.5s)
methodKMean = 2;


%% accumulation all the relevant data from every recordings for pyramidal neurons
PyrPropAllRec(pathS,onlyRun);

%% accumulate information about individual neurons'
%% theta modulation, burstness and whether there is a field across recordings
PyrModAccumAllRec(pathS, onlyRun, methodKMean);

for taskSel = 3 % 2:3
    %taskSel == 1 % including all the neurons
    %taskSel == 2 % including AL and PL neurons
    %taskSel == 3 % AL neurons only
    PyrModAllRec(pathS,onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec(pathS,onlyRun,taskSel,methodKMean);
    
    PyrModAllRec_GoodTr(pathS,onlyRun,taskSel,methodKMean);

    PyrModAllRec_CtrlTr(pathS,onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec_CtrlTr(pathS,onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec_GoodTr(pathS,onlyRun,taskSel,methodKMean);

    PyrModAlignedDistAllRec_GoodTr(pathS,onlyRun,taskSel,methodKMean);
    
    PyrInitPeakAllRec(pathS,taskSel,methodKMean); % including non-run time

    PyrInitPeakSpeedAllRec(pathS,taskSel,methodKMean);
    
    PyrBehAlignedAllRec(pathS,0,taskSel); 

    PyrBehTimeAlignedAllRec(pathS,0,taskSel);
 
end

%% accumulation all the relevant data from every recordings for interneurons
InterneuronPropAllRec(pathS,onlyRun);

methodKMean = 2;
InterneuronModAccumAllRec(pathS,onlyRun,methodKMean);
for taskSel = 3
    InterneuronInitPeakAllRec(pathS,taskSel,methodKMean);
    InterneuronInitPeakSpeedAllRec(pathS,taskSel,methodKMean);
end


%% find neurons that are significantly changing their FRaft/FRbef
PyrInitPeakAllRecSig(pathS); % calculate 
InterneuronInitPeakAllRecSig(pathS);

%% for optogentic stimulation, 
PyrInitPeakAllRecSigNoStim2ndStimCtrl(pathS); % find neurons that are significantly changing their FRaft/FRbef,
                % including good trials from non-stim ctrl and 2nd stim ctrl as ctrl trials, neurons with significant changes in FRaft/FRbef 
PyrInitPeakAllStimPVRecSigNonStim2ndStimCtrlTr(pathS,methodKMean);
                % including good trials from non-stim ctrl and 2nd stim ctrl as ctrl trials, only consider stimulation recordings
                % stim ctrl trials are the second stim ctrl
                % trials from all the stim pulse types from the recording

%% PV stimulation session, pyrRise and pyrDown neurons
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec(pathS,methodKMean,pDriftRec); 
                % Separating into rise and down neurons, select neurons to
                % remove the recordings with drifted firing rate between ctrl
                % and stimCtrl. Excluding some recordings that have clear drifts during the PV activation experiments 
PyrIntInitPeakPVStimNonStim2ndStimCtrlNoDriftSelRec_ttest(pathS)
                    perform ttest  to compare the firing rate change between
                  % control and stim trials
PyrIntInitPeakCorrTPVSigNonStim2ndStimCtrlNoDriftSelRec(pathS,methodKMean,pDriftRec);
                % correlation of neurons, 
                % remove the recordings with drifted firing rate between ctrl
                % and stimCtrl. Excluding some recordings that have clear drifts during the PV activation experiments 


%% compare behavior in no cue and AL task (Figure 1)
% PyrBehALNoCue(pathS,0); % compare behavior between no cue and AL condition (aligned to cue, plot over distance)
% 
% PyrBehALNoCueAligned(pathS,0); % compare behavior between no cue and AL condition (aligned to run, plot over distance)
% 
% PyrBehALNoCueAlignedTime(pathS,0); % compare behavior between no cue and AL condition (aligned to run, plot over time)


%% Figure 2 in the PV paper
% CompPyrModCtrlTrNoCueVsALPL(pathS); % control trials over distance
% CompPyrModAlignedCtrlTrNoCueVsALPL(pathS); % control trials over time after aligned to run onset
% CompPyrModAlignedGoodVsBadTrALPL(pathS); % good trials vs bad trials over time aligned to run onset
% CompPyrModAlignedDistGoodVsBadTrALPL(pathS); % good trials vs bad trials over distance aligned to run onset
% 
% PyrPopActivityAlignedCorrCtrl(pathS,onlyRun); % population correlation after aligned to run onset
% PyrPopActivityAlignedCorrCtrlAllRec(pathS); % accumulation over all the recordings


%% classify PyrUp and PyrDown neurons based on the FR change before and after the run onset
for taskSel = 3
    for pshuffle = 3
        PyrIntInitPeakSig(pathS,taskSel,pshuffle); % select the ones that has a significant change in FR around run onset 
    end
          %      (pshuffle = 1 -> 99.9%, 2 -> 99%, 3 -> 95%)
    PyrIntInitPeak(pathS,taskSel);
end

PyrIntInitPeak_PLoc(pathS); % estimate the peak location and tau of the average firing rate profile for each neuron

%% tagged neurons
% PyrIntInitPeakTagged(pathS); % including good and bad neurons separately depending on the no. of good vs. bad trials for each neuron
% PyrIntInitPeakTaggedAll(pathS); % including all the sessions where the good trial no. is larger than certain threshold

% PyrIntInitPeakTaggedAllSST(pathS); % including all the sessions where the good trial no. is larger than certain threshold, plot the tagged SST neurons


%% compare the run onset peak in no cue and AL task

% taskSel = 4;
% PyrIntInitPeakNoCue(pathS,taskSel); % only look at the run onset response for PL recordings

% taskSel = 5;
% PyrIntInitPeakALFirst10Rec(pathS,taskSel); % only look at the run onset response for the first 10 AL recordings

% for ALMode = 1:3
%     % compare No Cue and AL ramping at the run onset
%     CompPyrIntInitPeakNoCueVsAL(pathS,ALMode); % ALMode = 1, for all the AL and PL recordings; ALMode = 2, for all the AL recordings; ALMode = 3, for the first 10 AL recordings
% end

%% muscimol data
% ProcessAllRecBehMusc();

%% plotting the putative PV and SST cells
% plotPVSSTPutativeCells(); % plot the theta phase and ccg of PV and SST neurons


