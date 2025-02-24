function ProcessPyrNeuronsStim()

methodKMean = 2;
%% PV stimulation recordings (excluding a few recordings for PV activation mid cue where there is an obvious change in the FR before the stimulation,
%% could be due to stimulating every other trial instead of every third trial)
% PyrInitPeakAllStimPVRecExclRec(methodKMean); % no comparision between stim and stim ctrl trials, only stim and ctrl good trials
% PyrIntInitPeakPVStimExclRec(methodKMean);
% 
% PyrInitPeakAllStimPVRecCtrlTrExclRec(methodKMean); % adding comparison between stim and stim ctrl trials, included all the ctrl trials
% PyrIntInitPeakPVStimCtrlExclRec(methodKMean); % including all the neurons
% PyrIntInitPeakPVStimCtrlSelRecExcl(methodKMean); % selected neurons based on mean firing rate change in ctrl and stim sessions
% PyrIntInitPeakPVStimCtrlSelRec1Excl(methodKMean); % selected neurons whose firing rate change in ctrl and stim sessions are < 5% or > 95% of the whole population
PyrIntInitPeakPVStimCtrlSelRecExclNoFNeu(methodKMean); % selected neurons based on mean firing rate change in ctrl and stim sessions, neurons without fields

PyrIntInitPeakCorrTPVStimCtrlExcl(methodKMean); % calculate the activity correlation change among ctrl, stim and stim ctrl, based on the results from PyrIntInitPeakPVStimCtrl
PyrIntInitPeakCorrTPVStimCtrlSelRecExcl(methodKMean); % calculate the activity correlation change among ctrl, stim and stim ctrl, based on the results from PyrIntInitPeakPVStimCtrlSelRec
PyrIntInitPeakNumFieldPVStimCtrlSelRecExcl(methodKMean); % calculate the number of fields among ctrl, stim and stim ctrl, based on the results from PyrIntInitPeakPVStimCtrlSelRec


