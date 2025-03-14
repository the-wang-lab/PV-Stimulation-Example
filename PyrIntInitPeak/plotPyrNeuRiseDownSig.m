function plotPyrNeuRiseDownSig(pathAnal,timeStepRun,...
            InitAll,PyrRise,PyrDown,PyrOther,FRProfileMean,FRProfileMeanPyr,FRProfileMeanPyrStat,colorSel,xlabels)

    %% order pyramidal neurons with field based on the peak firing rate after 0
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNorm,['FR (Hz)'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeu'],...
            pathAnal,[],5,[],[])
    
    plotIndFRProfile(timeStepRun,...
            InitAll.avgFRProfileNormBad,['FR (Hz) Bad'],...
            ['Pyr_IndFRProfileNormFRPeakAftRunNeuBad'],...
            pathAnal,[],5,[],[])
        
    %% order pyramidal neurons with field based on before and after run FR ratio  
    plotIndFRProfileSig(timeStepRun,...
            InitAll.avgFRProfileNorm,PyrRise.idxRise,PyrDown.idxDown,...
            PyrOther.idxOther,['Neuron no.'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeu'],...
            pathAnal,[],FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio of each subpopulation
    
    plotIndFRProfileSig(timeStepRun,...
            InitAll.avgFRProfileNormBad,PyrRise.idxRiseBadBad,PyrDown.idxDownBadBad,...
            PyrOther.idxOtherBadBad,['Neuron no. Bad'],...
            ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuBad'],...
            pathAnal,[],FRProfileMean.indFRBefRun,...
            FRProfileMean.indFR0to1) % ordered based on -1to0 to 0to1 mean ratio of each subpopulation
    
    %% average profile good vs bad trials
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(PyrRise.idxRise,:),...
            InitAll.avgFRProfileBad(PyrRise.idxRiseBadBad,:),...
            ['FR PyrRise Good/Bad'],...
            ['Pyr_FRProfilePyrRiseGoodBad'],...
            pathAnal,[0 3.8],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(PyrDown.idxDown,:),...
            InitAll.avgFRProfileBad(PyrDown.idxDownBadBad,:),...
            ['FR PyrDown Good/Bad'],...
            ['Pyr_FRProfilePyrDownGoodBad'],...
            pathAnal,[0 3.8],xlabels)
        
    % added on 7/10/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfile(PyrOther.idxOther,:),...
            InitAll.avgFRProfileBad(PyrOther.idxOtherBadBad,:),...
            ['FR PyrOther Good/Bad'],...
            ['Pyr_FRProfilePyrOtherGoodBad'],...
            pathAnal,[0 3.8],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(PyrRise.idxRise,:),...
            InitAll.avgFRProfileNormBad(PyrRise.idxRiseBadBad,:),...
            ['FR Norm PyrRise Good/Bad'],...
            ['Pyr_FRProfileNormPyrRiseGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(PyrDown.idxDown,:),...
            InitAll.avgFRProfileNormBad(PyrDown.idxDownBadBad,:),...
            ['FR Norm PyrDown Good/Bad'],...
            ['Pyr_FRProfileNormPyrDownGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
    % added on 7/10/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNorm(PyrOther.idxOther,:),...
            InitAll.avgFRProfileNormBad(PyrOther.idxOtherBadBad,:),...
            ['FR Norm PyrOther Good/Bad'],...
            ['Pyr_FRProfileNormPyrOtherGoodBad'],...
            pathAnal,[0 0.6],xlabels)
        
    % added normalization using z-score
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(PyrRise.idxRise,:),...
            InitAll.avgFRProfileNormZBad(PyrRise.idxRiseBadBad,:),...
            ['FR NormZ PyrRise Good/Bad'],...
            ['Pyr_FRProfileNormZPyrRiseGoodBad'],...
            pathAnal,[-0.5 2.5],xlabels)
        
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(PyrDown.idxDown,:),...
            InitAll.avgFRProfileNormZBad(PyrDown.idxDownBadBad,:),...
            ['FR NormZ PyrDown Good/Bad'],...
            ['Pyr_FRProfileNormZPyrDownGoodBad'],...
            pathAnal,[-0.5 2.5],xlabels)
        
    % added on 7/10/2022
    plotAvgFRProfileCmp(timeStepRun,...
            InitAll.avgFRProfileNormZ(PyrOther.idxOther,:),...
            InitAll.avgFRProfileNormZBad(PyrOther.idxOtherBadBad,:),...
            ['FR NormZ PyrOther Good/Bad'],...
            ['Pyr_FRProfileNormZPyrOtherGoodBad'],...
            pathAnal,[-0.5 2.5],xlabels)
        
    %% FR Change before run vs 0to1s
    idxNonInf = ~isinf(FRProfileMeanPyr.Rise.percChangeBefRunVs0to1);
    idxNonInfBad = ~isinf(FRProfileMeanPyr.RiseBad.percChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Rise.percChangeBefRunVs0to1(idxNonInf)),...
            mean(FRProfileMeanPyr.RiseBad.percChangeBefRunVs0to1(idxNonInfBad))],...
            [std(FRProfileMeanPyr.Rise.percChangeBefRunVs0to1(idxNonInf))...
                /sqrt(length(FRProfileMeanPyr.Rise.percChangeBefRunVs0to1(idxNonInf))),...
            std(FRProfileMeanPyr.RiseBad.percChangeBefRunVs0to1(idxNonInfBad))...
                /sqrt(length(FRProfileMeanPyr.RiseBad.percChangeBefRunVs0to1(idxNonInfBad)))],...
            [],...
            ['average FR change BefRun/0to1s G/B Rise'],...
            '', FRProfileMeanPyrStat.RiseGoodBad.pRSPercChangeBefRunVs0to1All,...
            ['Pyr_FRChangeBefRun-0to1RiseGoodBad'],...
            pathAnal,colorSel,xlabels);
    
    idxNonInf = ~isinf(FRProfileMeanPyr.Down.percChangeBefRunVs0to1);
    idxNonInfBad = ~isinf(FRProfileMeanPyr.DownBad.percChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Down.percChangeBefRunVs0to1(idxNonInf)),...
            mean(FRProfileMeanPyr.DownBad.percChangeBefRunVs0to1(idxNonInfBad))],...
            [std(FRProfileMeanPyr.Down.percChangeBefRunVs0to1(idxNonInf))...
                /sqrt(length(FRProfileMeanPyr.Down.percChangeBefRunVs0to1(idxNonInf))),...
            std(FRProfileMeanPyr.DownBad.percChangeBefRunVs0to1(idxNonInfBad))...
                /sqrt(length(FRProfileMeanPyr.DownBad.percChangeBefRunVs0to1(idxNonInfBad)))],...
            [],...
            ['average FR change BefRun/0to1s G/B Down'],...
            '', FRProfileMeanPyrStat.DownGoodBad.pRSPercChangeBefRunVs0to1All,...
            ['Pyr_FRChangeBefRun-0to1DownGoodBad'],...
            pathAnal,colorSel,xlabels);
        
    % added on 7/10/2022
    idxNonInf = ~isinf(FRProfileMeanPyr.Other.percChangeBefRunVs0to1);
    idxNonInfBad = ~isinf(FRProfileMeanPyr.OtherBad.percChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Other.percChangeBefRunVs0to1(idxNonInf)),...
            mean(FRProfileMeanPyr.OtherBad.percChangeBefRunVs0to1(idxNonInfBad))],...
            [std(FRProfileMeanPyr.Other.percChangeBefRunVs0to1(idxNonInf))...
                /sqrt(length(FRProfileMeanPyr.Other.percChangeBefRunVs0to1(idxNonInf))),...
            std(FRProfileMeanPyr.OtherBad.percChangeBefRunVs0to1(idxNonInfBad))...
                /sqrt(length(FRProfileMeanPyr.OtherBad.percChangeBefRunVs0to1(idxNonInfBad)))],...
            [],...
            ['average FR change BefRun/0to1s G/B Other'],...
            '', FRProfileMeanPyrStat.OtherGoodBad.pRSPercChangeBefRunVs0to1All,...
            ['Pyr_FRChangeBefRun-0to1OtherGoodBad'],...
            pathAnal,colorSel,xlabels);
        
    %% FR rel Change before run vs 0to1s
    indBadNonNan = ~isnan(FRProfileMeanPyr.RiseBad.relChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Rise.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.RiseBad.relChangeBefRunVs0to1(indBadNonNan))],...
            [std(FRProfileMeanPyr.Rise.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.Rise.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.RiseBad.relChangeBefRunVs0to1(indBadNonNan))...
                /sqrt(sum(indBadNonNan))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Rise'],...
            '', FRProfileMeanPyrStat.RiseGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1RiseGoodBad'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
        
    indBadNonNan = ~isnan(FRProfileMeanPyr.DownBad.relChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Down.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.DownBad.relChangeBefRunVs0to1(indBadNonNan))],...
            [std(FRProfileMeanPyr.Down.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.Down.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.DownBad.relChangeBefRunVs0to1(indBadNonNan))...
                /sqrt(sum(indBadNonNan))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Down'],...
            '', FRProfileMeanPyrStat.DownGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1DownGoodBad'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
        
    % added on 7/10/2022
    indBadNonNan = ~isnan(FRProfileMeanPyr.OtherBad.relChangeBefRunVs0to1);
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Other.relChangeBefRunVs0to1),...
            mean(FRProfileMeanPyr.OtherBad.relChangeBefRunVs0to1(indBadNonNan))],...
            [std(FRProfileMeanPyr.Other.relChangeBefRunVs0to1)...
                /sqrt(length(FRProfileMeanPyr.Other.relChangeBefRunVs0to1)),...
            std(FRProfileMeanPyr.OtherBad.relChangeBefRunVs0to1(indBadNonNan))...
                /sqrt(sum(indBadNonNan))],...
            [],...
            ['rel. FR change BefRun/0to1s G/B Other'],...
            '', FRProfileMeanPyrStat.OtherGoodBad.pRSRelChangeBefRunVs0to1All,...
            ['Pyr_RelFRChangeBefRun-0to1OtherGoodBad'],...
            pathAnal,colorSel,xlabels,[-0.65 0.65]);
        
   
    %% FR between -1 to 4s    
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Rise.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.RiseBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.Rise.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.Rise.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.RiseBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.RiseBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Rise'],...
            '', FRProfileMeanPyrStat.RiseGoodBad.pRSAll,...
            ['Pyr_FRAllRiseGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.1]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Down.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.DownBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.Down.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.Down.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.DownBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.DownBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Down'],...
            '', FRProfileMeanPyrStat.DownGoodBad.pRSAll,...
            ['Pyr_FRAllDownGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.1]);
     
    % added on 7/10/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Other.meanAvgFRProfileAll),...
            mean(FRProfileMeanPyr.OtherBad.meanAvgFRProfileAll)],...
            [std(FRProfileMeanPyr.Other.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.Other.meanAvgFRProfileAll)),...
            std(FRProfileMeanPyr.OtherBad.meanAvgFRProfileAll)...
                /sqrt(length(FRProfileMeanPyr.OtherBad.meanAvgFRProfileAll))],...
            [],...
            ['average FR All G/B Other'],...
            '', FRProfileMeanPyrStat.OtherGoodBad.pRSAll,...
            ['Pyr_FRAllOtherGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.1]);
        
    %% FR before run    
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Rise.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.RiseBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.Rise.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.Rise.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.RiseBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.RiseBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Rise'],...
            '', FRProfileMeanPyrStat.RiseGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunRiseGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Down.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.DownBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.Down.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.Down.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.DownBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.DownBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Down'],...
            '', FRProfileMeanPyrStat.DownGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunDownGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
 
    % added on 7/10/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Other.meanAvgFRProfileBefRun),...
            mean(FRProfileMeanPyr.OtherBad.meanAvgFRProfileBefRun)],...
            [std(FRProfileMeanPyr.Other.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.Other.meanAvgFRProfileBefRun)),...
            std(FRProfileMeanPyr.OtherBad.meanAvgFRProfileBefRun)...
                /sqrt(length(FRProfileMeanPyr.OtherBad.meanAvgFRProfileBefRun))],...
            [],...
            ['average FR BefRun G/B Other'],...
            '', FRProfileMeanPyrStat.OtherGoodBad.pRSBefRunAll,...
            ['Pyr_FRBefRunOtherGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
        
    %% FR 0 to 1s
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Rise.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.RiseBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.Rise.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.Rise.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.RiseBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.RiseBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Rise'],...
            '', FRProfileMeanPyrStat.RiseGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sRiseGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
        
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Down.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.DownBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.Down.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.Down.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.DownBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.DownBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Down'],...
            '', FRProfileMeanPyrStat.DownGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sDownGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
        
    % added on 7/10/2022
    barPlotWithStat1(1:2,...
            [mean(FRProfileMeanPyr.Other.meanAvgFRProfile0to1),...
            mean(FRProfileMeanPyr.OtherBad.meanAvgFRProfile0to1)],...
            [std(FRProfileMeanPyr.Other.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.Other.meanAvgFRProfile0to1)),...
            std(FRProfileMeanPyr.OtherBad.meanAvgFRProfile0to1)...
                /sqrt(length(FRProfileMeanPyr.OtherBad.meanAvgFRProfile0to1))],...
            [],...
            ['average FR 0to1s G/B Other'],...
            '', FRProfileMeanPyrStat.OtherGoodBad.pRS0to1All,...
            ['Pyr_FR0to1sOtherGoodBad'],...
            pathAnal,colorSel,xlabels,[0 3.5]);
        
end