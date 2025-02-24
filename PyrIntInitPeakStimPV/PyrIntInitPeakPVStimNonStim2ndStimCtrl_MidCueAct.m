function PyrIntInitPeakPVStimNonStim2ndStimCtrl_MidCueAct(methodKMean)
% PyrIntInitPeakPVStimNonStim2ndStimCtrl_MidCueAct(2)

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
    
    pathAnal1 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrl-NoDriftSelRec\MidCueAct\'];
    if(~exist(pathAnal1))
        mkdir(pathAnal1);
    end
    
    %% check for run onset activation condition 
    cond = 0;
    for i = 1:length(PyrStim1.FRProfile1)
        if(PyrStim1.FRProfile1{i}.actOrInact == 2 & PyrStim1.FRProfile1{i}.pulseMethod == 3 ...
                & PyrStim1.FRProfile1{i}.stimLoc == 120)
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
    pRSMeanFR2to3sStimNonStim = modPyr2AL.pRSMeanFR2to3sStimNonStim(ind);
    pRSMeanFRAftRunStimNonStim = modPyr2AL.pRSMeanFRAftRunStimNonStim(ind);
    meanFR0to1stNonStimCtrl = modPyr2AL.meanFR0to1stNonStimCtrl(ind);
    meanFR0to1stStim = modPyr2AL.meanFR0to1stStim(ind);
    meanFR2to3sNonStimCtrl = modPyr2AL.meanFR2to3sNonStimCtrl(ind);
    meanFR2to3sStim = modPyr2AL.meanFR2to3sStim(ind);
    
    PyrRiseMidCueAct.pRSMeanFR2to3sStimNonStim = ...
        pRSMeanFR2to3sStimNonStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.pRSMeanFRAftRunStimNonStim = ...
        pRSMeanFRAftRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrRise);
    PyrRiseMidCueAct.percFRChange0to1st = ...
        (PyrRiseMidCueAct.meanFR0to1stStim-PyrRiseMidCueAct.meanFR0to1stNonStimCtrl)./PyrRiseMidCueAct.meanFR0to1stNonStimCtrl;
    PyrRiseMidCueAct.percFRChange2to3s = ...
        (PyrRiseMidCueAct.meanFR2to3sStim-PyrRiseMidCueAct.meanFR2to3sNonStimCtrl)./PyrRiseMidCueAct.meanFR2to3sNonStimCtrl;
    PyrRiseMidCueAct.percFRChange0to1stMean = mean(PyrRiseMidCueAct.percFRChange0to1st);
    PyrRiseMidCueAct.percFRChange0to1stStd = std(PyrRiseMidCueAct.percFRChange0to1st);
    PyrRiseMidCueAct.percFRChange2to3sMean = mean(PyrRiseMidCueAct.percFRChange2to3s);
    PyrRiseMidCueAct.percFRChange2to3sStd = std(PyrRiseMidCueAct.percFRChange2to3s);
        
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxRiseChange = find(PyrRiseMidCueAct.pRSMeanFR2to3sStimNonStim < pFRThresh & ...
        PyrRiseMidCueAct.pRSMeanFRAftRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrRise(idxRiseChange);
    idxFRIncr = idxRiseChange(meanFR2to3sNonStimCtrl(idxChange) ...
        < meanFR2to3sStim(idxChange));
    idxFRDecr = idxRiseChange(meanFR2to3sNonStimCtrl(idxChange) ...
        > meanFR2to3sStim(idxChange));
    
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrRise(idxFRIncr);
    PyrRiseMidCueAct.indPyrAct = indPyrAct;
    PyrRiseMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrRise.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrRiseMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrRise.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrRiseMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrRiseMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrRiseMidCueAct.meanAvgFRProfileAll_Stim_Act = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrRiseMidCueAct.meanAvgFRProfileBefRun_Stim_Act = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrRiseMidCueAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrRiseMidCueAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrRiseMidCueAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrRiseMidCueAct.meanAvgFRProfileAll_Stim_Act);
    PyrRiseMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrRiseMidCueAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrRiseMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrRiseMidCueAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrRiseMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrRiseMidCueAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrRise(idxFRDecr);
    PyrRiseMidCueAct.indPyrInact = indPyrInact;
    PyrRiseMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrRise.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrRiseMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrRise.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrRiseMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrRiseMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrRiseMidCueAct.meanAvgFRProfileAll_Stim_Inact = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrRiseMidCueAct.meanAvgFRProfileBefRun_Stim_Inact = PyrRise.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrRiseMidCueAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrRiseMidCueAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
        
    % statistics (inactivated)
    PyrRiseMidCueAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrRiseMidCueAct.meanAvgFRProfileAll_Stim_Inact);
    PyrRiseMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrRiseMidCueAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrRiseMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrRiseMidCueAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrRiseMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrRiseMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrRiseMidCueAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    %% PyrDown
    % all the down neurons that do not drift and belong to Run onset stim group     
    PyrDownMidCueAct.pRSMeanFR2to3sStimNonStim = ...
        pRSMeanFR2to3sStimNonStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.pRSMeanFRAftRunStimNonStim = ...
        pRSMeanFRAftRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrDown);
    PyrDownMidCueAct.percFRChange0to1st = ...
        (PyrDownMidCueAct.meanFR0to1stStim-PyrDownMidCueAct.meanFR0to1stNonStimCtrl)./PyrDownMidCueAct.meanFR0to1stNonStimCtrl;
    PyrDownMidCueAct.percFRChange2to3s = ...
        (PyrDownMidCueAct.meanFR2to3sStim-PyrDownMidCueAct.meanFR2to3sNonStimCtrl)./PyrDownMidCueAct.meanFR2to3sNonStimCtrl;
    PyrDownMidCueAct.percFRChange0to1stMean = mean(PyrDownMidCueAct.percFRChange0to1st);
    PyrDownMidCueAct.percFRChange0to1stStd = std(PyrDownMidCueAct.percFRChange0to1st);
    PyrDownMidCueAct.percFRChange2to3sMean = mean(PyrDownMidCueAct.percFRChange2to3s);
    PyrDownMidCueAct.percFRChange2to3sStd = std(PyrDownMidCueAct.percFRChange2to3s);
        
    
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxDownChange = find(PyrDownMidCueAct.pRSMeanFR2to3sStimNonStim < pFRThresh & ...
        PyrDownMidCueAct.pRSMeanFRAftRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrDown(idxDownChange);
    idxFRIncr = idxDownChange(meanFR2to3sNonStimCtrl(idxChange) ...
        < meanFR2to3sStim(idxChange));
    idxFRDecr = idxDownChange(meanFR2to3sNonStimCtrl(idxChange) ...
        > meanFR2to3sStim(idxChange));
        
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrDown(idxFRIncr);
    PyrDownMidCueAct.indPyrAct = indPyrAct;
    PyrDownMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrDown.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrDownMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrDown.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrDownMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrDownMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrDownMidCueAct.meanAvgFRProfileAll_Stim_Act = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrDownMidCueAct.meanAvgFRProfileBefRun_Stim_Act = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrDownMidCueAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrDownMidCueAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrDownMidCueAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrDownMidCueAct.meanAvgFRProfileAll_Stim_Act);
    PyrDownMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrDownMidCueAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrDownMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrDownMidCueAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrDownMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrDownMidCueAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrDown(idxFRDecr);
    PyrDownMidCueAct.indPyrInact = indPyrInact;
    PyrDownMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrDown.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrDownMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrDown.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrDownMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrDownMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrDownMidCueAct.meanAvgFRProfileAll_Stim_Inact = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrDownMidCueAct.meanAvgFRProfileBefRun_Stim_Inact = PyrDown.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrDownMidCueAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrDownMidCueAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
    
    % statistics (inactivated)
    PyrDownMidCueAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrDownMidCueAct.meanAvgFRProfileAll_Stim_Inact);
    PyrDownMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrDownMidCueAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrDownMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrDownMidCueAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrDownMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrDownMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrDownMidCueAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    %% PyrOther
    % all the other neurons that do not drift and belong to Run onset stim group  
    PyrOtherMidCueAct.pRSMeanFR2to3sStimNonStim = ...
        pRSMeanFR2to3sStimNonStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.pRSMeanFRAftRunStimNonStim = ...
        pRSMeanFRAftRunStimNonStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.meanFR0to1stNonStimCtrl = meanFR0to1stNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.meanFR0to1stStim = meanFR0to1stStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.meanFR2to3sNonStimCtrl = meanFR2to3sNonStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.meanFR2to3sStim = meanFR2to3sStim(PyrStim1.FRProfile1{cond}.indPyrOther);
    PyrOtherMidCueAct.percFRChange0to1st = ...
        (PyrOtherMidCueAct.meanFR0to1stStim-PyrOtherMidCueAct.meanFR0to1stNonStimCtrl)./PyrOtherMidCueAct.meanFR0to1stNonStimCtrl;
    PyrOtherMidCueAct.percFRChange2to3s = ...
        (PyrOtherMidCueAct.meanFR2to3sStim-PyrOtherMidCueAct.meanFR2to3sNonStimCtrl)./PyrOtherMidCueAct.meanFR2to3sNonStimCtrl;
    PyrOtherMidCueAct.percFRChange0to1stMean = mean(PyrOtherMidCueAct.percFRChange0to1st);
    PyrOtherMidCueAct.percFRChange0to1stStd = std(PyrOtherMidCueAct.percFRChange0to1st);
    PyrOtherMidCueAct.percFRChange2to3sMean = mean(PyrOtherMidCueAct.percFRChange2to3s);
    PyrOtherMidCueAct.percFRChange2to3sStd = std(PyrOtherMidCueAct.percFRChange2to3s);
        
    % find neurons that have significant change in firing rate between 0to1 s after run onset
    % between the stim and ctrl trials
    idxOtherChange = find(PyrOtherMidCueAct.pRSMeanFR2to3sStimNonStim < pFRThresh & ...
        PyrOtherMidCueAct.pRSMeanFRAftRunStimNonStim > pFRThresh);
 
    idxChange = PyrStim1.FRProfile1{cond}.indPyrOther(idxOtherChange);
    idxFRIncr = idxOtherChange(meanFR2to3sNonStimCtrl(idxChange) ...
        < meanFR2to3sStim(idxChange));
    idxFRDecr = idxOtherChange(meanFR2to3sNonStimCtrl(idxChange) ...
        > meanFR2to3sStim(idxChange));
        
    % firing rate change (activated)
    indPyrAct = PyrStim1.FRProfile1{cond}.indPyrOther(idxFRIncr);
    PyrOtherMidCueAct.indPyrAct = indPyrAct;
    PyrOtherMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act = PyrOther.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrOtherMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act = PyrOther.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrOtherMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act = meanFR0to1stNonStimCtrl(indPyrAct);
    PyrOtherMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act = meanFR2to3sNonStimCtrl(indPyrAct);
    
    PyrOtherMidCueAct.meanAvgFRProfileAll_Stim_Act = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRIncr);
    PyrOtherMidCueAct.meanAvgFRProfileBefRun_Stim_Act = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRIncr);
    PyrOtherMidCueAct.meanAvgFRProfile0to1st_Stim_Act = meanFR0to1stStim(indPyrAct);
    PyrOtherMidCueAct.meanAvgFRProfile2to3s_Stim_Act = meanFR2to3sStim(indPyrAct);
    
    % statistics (activated)
    PyrOtherMidCueAct.pRSAvgFRProfileAll_NonStimStim_Act = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Act,PyrOtherMidCueAct.meanAvgFRProfileAll_Stim_Act);
    PyrOtherMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Act = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Act,PyrOtherMidCueAct.meanAvgFRProfileBefRun_Stim_Act);
    PyrOtherMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Act = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Act,PyrOtherMidCueAct.meanAvgFRProfile0to1st_Stim_Act);
    PyrOtherMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Act = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Act,PyrOtherMidCueAct.meanAvgFRProfile2to3s_Stim_Act);
    
    % firing rate change (inactivated)
    indPyrInact = PyrStim1.FRProfile1{cond}.indPyrOther(idxFRDecr);
    PyrOtherMidCueAct.indPyrInact = indPyrInact;
    PyrOtherMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact = PyrOther.FRProfileMean{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrOtherMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact = PyrOther.FRProfileMean{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrOtherMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact = meanFR0to1stNonStimCtrl(indPyrInact);
    PyrOtherMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact = meanFR2to3sNonStimCtrl(indPyrInact);
    
    PyrOtherMidCueAct.meanAvgFRProfileAll_Stim_Inact = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileAll(idxFRDecr);
    PyrOtherMidCueAct.meanAvgFRProfileBefRun_Stim_Inact = PyrOther.FRProfileMeanStim{cond}.meanAvgFRProfileBefRun(idxFRDecr);
    PyrOtherMidCueAct.meanAvgFRProfile0to1st_Stim_Inact = meanFR0to1stStim(indPyrInact);
    PyrOtherMidCueAct.meanAvgFRProfile2to3s_Stim_Inact = meanFR2to3sStim(indPyrInact);
    
    % statistics (inactivated)
    PyrOtherMidCueAct.pRSAvgFRProfileAll_NonStimStim_Inact = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfileAll_NonStimCtrl_Inact,PyrOtherMidCueAct.meanAvgFRProfileAll_Stim_Inact);
    PyrOtherMidCueAct.pRSAvgFRProfileBefRun_NonStimStim_Inact = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfileBefRun_NonStimCtrl_Inact,PyrOtherMidCueAct.meanAvgFRProfileBefRun_Stim_Inact);
    PyrOtherMidCueAct.pRSAvgFRProfile0to1st_NonStimStim_Inact = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfile0to1st_NonStimCtrl_Inact,PyrOtherMidCueAct.meanAvgFRProfile0to1st_Stim_Inact);
    PyrOtherMidCueAct.pRSAvgFRProfile2to3s_NonStimStim_Inact = ranksum(...
        PyrOtherMidCueAct.meanAvgFRProfile2to3s_NonStimCtrl_Inact,PyrOtherMidCueAct.meanAvgFRProfile2to3s_Stim_Inact);
    
    save([pathAnal1 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl_MidCueAct.mat'],...
        'PyrRiseMidCueAct','PyrDownMidCueAct','PyrOtherMidCueAct');
    
    %% plotting results
    
    %% heatmap of individual neurons
    load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrl_avgProfile.mat'],'PyrStim');
    % pyrRise activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrRiseMidCueAct.indPyrAct,...
        ['PyrRise_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueAct']);
    
    % PyrRise inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrRiseMidCueAct.indPyrInact,...
        ['PyrRise_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueInact'])
    
    % pyrDown activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrDownMidCueAct.indPyrAct,...
        ['PyrDown_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueAct']);
    
    % PyrDown inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrDownMidCueAct.indPyrInact,...
        ['PyrDown_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueInact'])
    
    % pyrOther activated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrOtherMidCueAct.indPyrAct,...
        ['PyrOther_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueAct']);
    
    % PyrDown inactivated cells
    plotPyrNeuStimUpDownAlone0(pathAnal1, PyrStim1.FRProfileMean1{cond}.indFRBefRun,...
        PyrStim1.FRProfileMean1{cond}.indFR0to1, modPyr2AL.timeStepRun, PyrStim.avgFRProfileNorm,...
        PyrStim.avgFRProfileNormStim, PyrOtherMidCueAct.indPyrInact,...
        ['PyrOther_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(cond) '_MidCueInact'])
    
    %% averaged firing profile
    % compare good non stim trials with stim trials, pyr rise, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrRiseMidCueAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrRiseMidCueAct.indPyrAct,:),...
            ['FR PyrRise GoodNStim/Stim  Cond' num2str(cond) 'MidCueAct'],...
            ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(cond) '_MidCueAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr rise, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrRiseMidCueAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrRiseMidCueAct.indPyrInact,:),...
            ['FR PyrRise GoodNStim/Stim  Cond' num2str(cond) 'MidCueInact'],...
            ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(cond) '_MidCueInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
        
    % compare good non stim trials with stim trials, pyr down, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrDownMidCueAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrDownMidCueAct.indPyrAct,:),...
            ['FR PyrDown GoodNStim/Stim  Cond' num2str(cond) 'MidCueAct'],...
            ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(cond) '_MidCueAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr down, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrDownMidCueAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrDownMidCueAct.indPyrInact,:),...
            ['FR PyrDown GoodNStim/Stim  Cond' num2str(cond) 'MidCueInact'],...
            ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(cond) '_MidCueInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
    
    % compare good non stim trials with stim trials, pyr other, run onset stim activated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrOtherMidCueAct.indPyrAct,:),...
            PyrStim.avgFRProfileStim(PyrOtherMidCueAct.indPyrAct,:),...
            ['FR PyrOther GoodNStim/Stim  Cond' num2str(cond) 'MidCueAct'],...
            ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(cond) '_MidCueAct'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])

    % compare good non stim trials with stim trials, pyr other, run onset stim inactivated
    plotAvgFRProfileCmp(modPyr2AL.timeStepRun,...
            PyrStim.avgFRProfile(PyrOtherMidCueAct.indPyrInact,:),...
            PyrStim.avgFRProfileStim(PyrOtherMidCueAct.indPyrInact,:),...
            ['FR PyrOther GoodNStim/Stim  Cond' num2str(cond) 'MidCueInact'],...
            ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(cond) '_MidCueInact'],...
            pathAnal1,[],[{'GoodNoStim'},{'Stim'}])
        
    %% statistics
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrRiseMidCueAct,...
        [{'Nonstim'} {'Stim'}],'PyrRise_MidCue');
        
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrDownMidCueAct,...
        [{'Nonstim'} {'Stim'}],'PyrDown_MidCue');
    
    plotPyrNeuWithFieldStimStats_subPop(pathAnal1,PyrOtherMidCueAct,...
        [{'Nonstim'} {'Stim'}],'PyrOther_MidCue');
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