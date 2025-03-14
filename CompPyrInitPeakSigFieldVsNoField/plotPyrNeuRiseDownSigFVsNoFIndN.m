function plotPyrNeuRiseDownSigFVsNoFIndN(pathAnal,timeStepRun,...
            InitAllF,InitAllNoF,avgFRProfileNorm,...
            idxRiseF,idxRiseNoF,idxDownF,idxDownNoF,idxOtherF,idxOtherNoF,FRProfileMean)

    %% order pyramidal neurons with field based on the peak firing rate after 0
    plotIndFRProfile(timeStepRun,...
            InitAllF.avgFRProfileNorm,['FR (Hz)'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuFRec'],...
            pathAnal,[],5,[],[])
    
    plotIndFRProfile(timeStepRun,...
            InitAllNoF.avgFRProfileNorm,['FR (Hz) Bad'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuNoFRec'],...
            pathAnal,[],5,[],[])
        
    %% order pyramidal neurons with field based on before and after run FR ratio  
    plotIndFRProfileSig(timeStepRun,...
            avgFRProfileNorm,idxRiseF,idxDownF,idxOtherF,['Neuron no.'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuFRec'],...
            pathAnal,[],FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio
    
    plotIndFRProfileSig(timeStepRun,...
            avgFRProfileNorm,idxRiseNoF,idxDownNoF,idxOtherNoF,['Neuron no. Bad'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuNoFREc'],...
            pathAnal,[],FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio
    
end