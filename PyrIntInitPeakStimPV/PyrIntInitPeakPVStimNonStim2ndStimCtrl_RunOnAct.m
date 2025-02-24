function PyrIntInitPeakPVStimNonStim2ndStimCtrl_RunOnAct(methodKMean)
% PyrIntInitPeakPVStimNonStim2ndStimCtrl_RunOnAct(2)

    pFRThresh = 0.01;
    
    RecordingListPyrInt;
    
    GlobalConstFq;
        
    %% load modPyr1AL
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSig\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrl.mat'],'modPyr1AL');
    end
    
    %% load PyrStim1
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\'];
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl.mat'],'PyrStim1','PyrRise','PyrDown','PyrOther');
    end
    
    %% load modPyr2AL
    pathAnal = ['Z:\Yingxue\Draft\PV\Pyramidal\'];
    if(exist([pathAnal 'initPeakPyrAllRecSigNoStim2ndStimCtrl_SegFRCmp.mat']))
        load([pathAnal 'initPeakPyrAllRecSigNoStim2ndStimCtrl_SegFRCmp.mat'],'modPyr2AL');
    end
    
    pathAnal1 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\RunOnsetAct\'];
    if(~exist(pathAnal1))
        mkdir(pathAnal1);
    end
    
    %% check for run onset activation condition 
    cond = 0;
    for i = 1:length(PyrStim1.FRProfile1)
        if(PyrStim1.FRProfile1{i}.actOrInact == 2 & PyrStim1.FRProfile1{i}.pulseMethod == 2)
            cond = i;
            break;
        end
    end
    
    %% label recordings to be excluded
    indInclRec = ones(1,length(modPyr1AL.indRec));
    for i = 1:length(excludeRec)
        ind = modPyr1AL.indRec == excludeRec(i);
        indInclRec(ind) = 0;
    end
    
    ind = modPyr1AL.indDriftRec & indInclRec;
      
    %% PyrRise
    % all the rise neurons that do not drift and belong to Run onset stim group  
    pRSMeanFR0to1stStimNonStim = modPyr2AL.pRSMeanFR0to1stStimNonStim(ind);
    pRSMeanFRBefRunStimNonStim = modPyr2AL.pRSMeanFRBefRunStimNonStim(ind);
    meanFR0to1stNonStimCtrl = modPyr2AL.meanFR0to1stNonStimCtrl(ind);
    meanFR0to1stStim = modPyr2AL.meanFR0to1stStim(ind);
    meanFR2to3sNonStimCtrl = modPyr2AL.meanFR2to3sNonStimCtrl(ind);
    meanFR2to3sStim = modPyr2AL.meanFR2to3sStim(ind);
    
    PyrRiseRunOnAct.pRSMeanFR0to1stStimNonStim = ...
        pRSMeanFR0to1stStimNonStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.pRSMeanFRBefRunStimNonStim = ...
        pRSMeanFRBefRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseRunOnAct.percFRChange0to1st = ...
        (PyrRiseRunOnAct.meanFR0to1stStim-PyrRiseRunOnAct.meanFR0to1stNonStimCtrl)./PyrRiseRunOnAct.meanFR0to1stNonStimCtrl;
    PyrRiseRunOnAct.percFRChange2to3s = ...
        (PyrRiseRunOnAct.meanFR2to3sStim-PyrRiseRunOnAct.meanFR2to3sNonStimCtrl)./PyrRiseRunOnAct.meanFR2to3sNonStimCtrl;
    PyrRiseRunOnAct.percFRChange0to1stMean = mean(PyrRiseRunOnAct.percFRChange0to1st);
    PyrRiseRunOnAct.percFRChange0to1stStd = std(PyrRiseRunOnAct.percFRChange0to1st);
    PyrRiseRunOnAct.percFRChange2to3sMean = mean(PyrRiseRunOnAct.percFRChange2to3s);
    PyrRiseRunOnAct.percFRChange2to3sStd = std(PyrRiseRunOnAct.percFRChange2to3s);
        
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxRiseChange = find(PyrRiseRunOnAct.pRSMeanFR0to1stStimNonStim < pFRThresh & ...
        PyrRiseRunOnAct.pRSMeanFRBefRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrRise(idxRiseChange);
    idxFRIncr = idxRiseChange(meanFR0to1stNonStimCtrl(idxChange) ...
        < meanFR0to1stStim(idxChange));
    idxFRDecr = idxRiseChange(meanFR0to1stNonStimCtrl(idxChange) ...
        > meanFR0to1stStim(idxChange));
    
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrRise(idxFRIncr);
    PyrRiseRunOnAct.indPyrAct = indPyrAct;
    PyrRiseRunOnAct.indRecPyrAct = PyrStim1.FRProfile1{cond}.indRecPyrRise(idxFRIncr);
    PyrRiseRunOnAct.indNeuPyrAct = PyrStim1.FRProfile1{cond}.indNeuPyrRise(idxFRIncr);
    PyrRiseRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrRise.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrRiseRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrRise.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrRiseRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrRiseRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrRiseRunOnAct.meanAvgFRProfileAll_Stim_Act = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrRiseRunOnAct.meanAvgFRProfileBefRun_Stim_Act = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrRiseRunOnAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrRiseRunOnAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrRiseRunOnAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrRiseRunOnAct.meanAvgFRProfileAll_Stim_Act);
    PyrRiseRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrRiseRunOnAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrRiseRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrRiseRunOnAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrRiseRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrRiseRunOnAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrRise(idxFRDecr);
    PyrRiseRunOnAct.indPyrInact = indPyrInact;
    PyrRiseRunOnAct.indRecPyrInact = PyrStim1.FRProfile1{cond}.indRecPyrRise(idxFRDecr);
    PyrRiseRunOnAct.indNeuPyrInact = PyrStim1.FRProfile1{cond}.indNeuPyrRise(idxFRDecr);
    PyrRiseRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrRise.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrRiseRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrRise.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrRiseRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrRiseRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrRiseRunOnAct.meanAvgFRProfileAll_Stim_Inact = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrRiseRunOnAct.meanAvgFRProfileBefRun_Stim_Inact = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrRiseRunOnAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrRiseRunOnAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
        
    % statistics (inactivated)
    PyrRiseRunOnAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrRiseRunOnAct.meanAvgFRProfileAll_Stim_Inact);
    PyrRiseRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrRiseRunOnAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrRiseRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrRiseRunOnAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrRiseRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrRiseRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrRiseRunOnAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    %% PyrDown
    % all the down neurons that do not drift and belong to Run onset stim group     
    PyrDownRunOnAct.pRSMeanFR0to1stStimNonStim = ...
        pRSMeanFR0to1stStimNonStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.pRSMeanFRBefRunStimNonStim = ...
        pRSMeanFRBefRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownRunOnAct.percFRChange0to1st = ...
        (PyrDownRunOnAct.meanFR0to1stStim-PyrDownRunOnAct.meanFR0to1stNonStimCtrl)./PyrDownRunOnAct.meanFR0to1stNonStimCtrl;
    PyrDownRunOnAct.percFRChange2to3s = ...
        (PyrDownRunOnAct.meanFR2to3sStim-PyrDownRunOnAct.meanFR2to3sNonStimCtrl)./PyrDownRunOnAct.meanFR2to3sNonStimCtrl;
    PyrDownRunOnAct.percFRChange0to1stMean = mean(PyrDownRunOnAct.percFRChange0to1st);
    PyrDownRunOnAct.percFRChange0to1stStd = std(PyrDownRunOnAct.percFRChange0to1st);
    PyrDownRunOnAct.percFRChange2to3sMean = mean(PyrDownRunOnAct.percFRChange2to3s);
    PyrDownRunOnAct.percFRChange2to3sStd = std(PyrDownRunOnAct.percFRChange2to3s);
    
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxDownChange = find(PyrDownRunOnAct.pRSMeanFR0to1stStimNonStim < pFRThresh & ...
        PyrDownRunOnAct.pRSMeanFRBefRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrDown(idxDownChange);
    idxFRIncr = idxDownChange(meanFR0to1stNonStimCtrl(idxChange) ...
        < meanFR0to1stStim(idxChange));
    idxFRDecr = idxDownChange(meanFR0to1stNonStimCtrl(idxChange) ...
        > meanFR0to1stStim(idxChange));
        
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrDown(idxFRIncr);
    PyrDownRunOnAct.indPyrAct = indPyrAct;
    PyrDownRunOnAct.indRecPyrAct = PyrStim1.FRProfile1{cond}.indRecPyrDown(idxFRIncr);
    PyrDownRunOnAct.indNeuPyrAct = PyrStim1.FRProfile1{cond}.indNeuPyrDown(idxFRIncr);
    PyrDownRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrDown.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrDownRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrDown.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrDownRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrDownRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrDownRunOnAct.meanAvgFRProfileAll_Stim_Act = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrDownRunOnAct.meanAvgFRProfileBefRun_Stim_Act = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrDownRunOnAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrDownRunOnAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrDownRunOnAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrDownRunOnAct.meanAvgFRProfileAll_Stim_Act);
    PyrDownRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrDownRunOnAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrDownRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrDownRunOnAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrDownRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrDownRunOnAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrDown(idxFRDecr);
    PyrDownRunOnAct.indPyrInact = indPyrInact;
    PyrDownRunOnAct.indRecPyrInact = PyrStim1.FRProfile1{cond}.indRecPyrDown(idxFRDecr);
    PyrDownRunOnAct.indNeuPyrInact = PyrStim1.FRProfile1{cond}.indNeuPyrDown(idxFRDecr);
    PyrDownRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrDown.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrDownRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrDown.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrDownRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrDownRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrDownRunOnAct.meanAvgFRProfileAll_Stim_Inact = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrDownRunOnAct.meanAvgFRProfileBefRun_Stim_Inact = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrDownRunOnAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrDownRunOnAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
    
    % statistics (inactivated)
    PyrDownRunOnAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrDownRunOnAct.meanAvgFRProfileAll_Stim_Inact);
    PyrDownRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrDownRunOnAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrDownRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrDownRunOnAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrDownRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrDownRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrDownRunOnAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    %% PyrOther
    % all the other neurons that do not drift and belong to Run onset stim group  
    PyrOtherRunOnAct.pRSMeanFR0to1stStimNonStim = ...
        pRSMeanFR0to1stStimNonStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.pRSMeanFRBefRunStimNonStim = ...
        pRSMeanFRBefRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherRunOnAct.percFRChange0to1st = ...
        (PyrOtherRunOnAct.meanFR0to1stStim-PyrOtherRunOnAct.meanFR0to1stNonStimCtrl)./PyrOtherRunOnAct.meanFR0to1stNonStimCtrl;
    PyrOtherRunOnAct.percFRChange2to3s = ...
        (PyrOtherRunOnAct.meanFR2to3sStim-PyrOtherRunOnAct.meanFR2to3sNonStimCtrl)./PyrOtherRunOnAct.meanFR2to3sNonStimCtrl;
    PyrOtherRunOnAct.percFRChange0to1stMean = mean(PyrOtherRunOnAct.percFRChange0to1st);
    PyrOtherRunOnAct.percFRChange0to1stStd = std(PyrOtherRunOnAct.percFRChange0to1st);
    PyrOtherRunOnAct.percFRChange2to3sMean = mean(PyrOtherRunOnAct.percFRChange2to3s);
    PyrOtherRunOnAct.percFRChange2to3sStd = std(PyrOtherRunOnAct.percFRChange2to3s);
    
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxOtherChange = find(PyrOtherRunOnAct.pRSMeanFR0to1stStimNonStim < pFRThresh & ...
        PyrOtherRunOnAct.pRSMeanFRBefRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrOther(idxOtherChange);
    idxFRIncr = idxOtherChange(meanFR0to1stNonStimCtrl(idxChange) ...
        < meanFR0to1stStim(idxChange));
    idxFRDecr = idxOtherChange(meanFR0to1stNonStimCtrl(idxChange) ...
        > meanFR0to1stStim(idxChange));
        
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrOther(idxFRIncr);
    PyrOtherRunOnAct.indPyrAct = indPyrAct;
    PyrOtherRunOnAct.indRecPyrAct = PyrStim1.FRProfile1{cond}.indRecPyrOther(idxFRIncr);
    PyrOtherRunOnAct.indNeuPyrAct = PyrStim1.FRProfile1{cond}.indNeuPyrOther(idxFRIncr);
    PyrOtherRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrOther.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrOtherRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrOther.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrOtherRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrOtherRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrOtherRunOnAct.meanAvgFRProfileAll_Stim_Act = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrOtherRunOnAct.meanAvgFRProfileBefRun_Stim_Act = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrOtherRunOnAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrOtherRunOnAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrOtherRunOnAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrOtherRunOnAct.meanAvgFRProfileAll_Stim_Act);
    PyrOtherRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrOtherRunOnAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrOtherRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrOtherRunOnAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrOtherRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrOtherRunOnAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrOther(idxFRDecr);
    PyrOtherRunOnAct.indPyrInact = indPyrInact;
    PyrOtherRunOnAct.indRecPyrInact = PyrStim1.FRProfile1{cond}.indRecPyrOther(idxFRDecr);
    PyrOtherRunOnAct.indNeuPyrInact = PyrStim1.FRProfile1{cond}.indNeuPyrOther(idxFRDecr);
    PyrOtherRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrOther.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrOtherRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrOther.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrOtherRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrOtherRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrOtherRunOnAct.meanAvgFRProfileAll_Stim_Inact = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrOtherRunOnAct.meanAvgFRProfileBefRun_Stim_Inact = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrOtherRunOnAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrOtherRunOnAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
    
    % statistics (inactivated)
    PyrOtherRunOnAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrOtherRunOnAct.meanAvgFRProfileAll_Stim_Inact);
    PyrOtherRunOnAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrOtherRunOnAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrOtherRunOnAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrOtherRunOnAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrOtherRunOnAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrOtherRunOnAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrOtherRunOnAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    save([pathAnal1 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl_RunOnAct.mat'],...
        'PyrRiseRunOnAct','PyrDownRunOnAct','PyrOtherRunOnAct');
    
    %% plotting results
    
    %% heatmap of individual neurons
    load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl_avgProfile.mat'],'PyrStim');
    % pyrRise activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrRiseRunOnAct.indPyrAct,...
        ['PyrRise_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnAct']);
    
    % PyrRise inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrRiseRunOnAct.indPyrInact,...
        ['PyrRise_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnInact'])
    
    % pyrDown activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrDownRunOnAct.indPyrAct,...
        ['PyrDown_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnAct']);
    
    % PyrDown inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrDownRunOnAct.indPyrInact,...
        ['PyrDown_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnInact'])
    
    % pyrOther activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrOtherRunOnAct.indPyrAct,...
        ['PyrOther_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnAct']);
    
    % PyrDown inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrOtherRunOnAct.indPyrInact,...
        ['PyrOther_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_RunOnInact'])
    
    %% averaged firing profile
    % compare good non stim trials with stim trials, pyr rise, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrRiseRunOnAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrRiseRunOnAct.indPyrAct,:),...
            ['FR PyrRise GoodNStim/Stim  Cond' num2str(cond) 'RunOnAct'],...
            ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(cond) '_RunOnAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr rise, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrRiseRunOnAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrRiseRunOnAct.indPyrInact,:),...
            ['FR PyrRise GoodNStim/Stim  Cond' num2str(cond) 'RunOnInact'],...
            ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(cond) '_RunOnInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
        
    % compare good non stim trials with stim trials, pyr down, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrDownRunOnAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrDownRunOnAct.indPyrAct,:),...
            ['FR PyrDown GoodNStim/Stim  Cond' num2str(cond) 'RunOnAct'],...
            ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(cond) '_RunOnAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr down, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrDownRunOnAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrDownRunOnAct.indPyrInact,:),...
            ['FR PyrDown GoodNStim/Stim  Cond' num2str(cond) 'RunOnInact'],...
            ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(cond) '_RunOnInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
    
    % compare good non stim trials with stim trials, pyr other, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrOtherRunOnAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrOtherRunOnAct.indPyrAct,:),...
            ['FR PyrOther GoodNStim/Stim  Cond' num2str(cond) 'RunOnAct'],...
            ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(cond) '_RunOnAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr other, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrOtherRunOnAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrOtherRunOnAct.indPyrInact,:),...
            ['FR PyrOther GoodNStim/Stim  Cond' num2str(cond) 'RunOnInact'],...
            ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(cond) '_RunOnInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
        
    %% statistics
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrRiseRunOnAct,...
        [{'Nonstim'} {'Stim'}],'PyrRise_RunOn');
        
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrDownRunOnAct,...
        [{'Nonstim'} {'Stim'}],'PyrDown_RunOn');
    
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrOtherRunOnAct,...
        [{'Nonstim'} {'Stim'}],'PyrOther_RunOn');
    
    %% plot individual neurons and compare stim and ctrl trials
    plotIndNeuronStimVsCtrl(pathAnal1,'PyrRiseRunOnActActivated',PyrRiseRunOnAct.indPyrAct,...
        modPyr2AL.timeStepRun,PyrStim.avgFRProfileStim,PyrStim.avgFRProfile,PyrRiseRunOnAct.indRecPyrAct,...
        PyrRiseRunOnAct.indNeuPyrAct); % plot activated pyrRise cells during run onset activation
    
    plotIndNeuronStimVsCtrl(pathAnal1,'PyrRiseRunOnActInactivated',PyrRiseRunOnAct.indPyrInact,...
        modPyr2AL.timeStepRun,PyrStim.avgFRProfileStim,PyrStim.avgFRProfile,PyrRiseRunOnAct.indRecPyrInact,...
        PyrRiseRunOnAct.indNeuPyrInact); % plot inactivated pyrRise cells during run onset activation
end
    
function plotPyrNeuStimUpDownAlone0(pathAnal0, indFRBefRun, indFR0to1, timeStep, ...
        avgFRProfileNorm,avgFRProfileNormStim, indPyrAct, filename)

    %% normalized
    %% order pyramidal neurons based on before and after run FR ratio 
    % and compare good non-stim with stim trials
    plotIndFRProfileCmp(timeStep,...
            avgFRProfileNorm(indPyrAct,:),...
            avgFRProfileNormStim(indPyrAct,:),['Neuron no.'],...
            filename,pathAnal0,[],4,indFRBefRun,indFR0to1)         
end

