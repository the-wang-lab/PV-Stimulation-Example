function plotPyrInitField(pathAnal,isNeuWithField,timeStepRun,avgFRProfile,avgFRProfileNorm,...
    FRProfileMean,FRProfileMeanStatC,colorSel,str)
%% neurons with and without field for each cluster
% this function is called by PyrInitPeakAllRec.m

    indCurCField = isNeuWithField == 1;
    indCurCNoField = isNeuWithField == 0;
    plotAvgFRProfileCmp(timeStepRun,...
        avgFRProfile(indCurCField,:),avgFRProfile(indCurCNoField,:),...
        [str ' RecFR (Hz) F vs. NoF'],...
        ['Pyr_FRProfileFieldNoField' str],...
        pathAnal,[1 4],[{'F'} {''} {'NoF'} {''}])

    plotAvgFRProfileCmp(timeStepRun,...
        avgFRProfileNorm(indCurCField,:),avgFRProfileNorm(indCurCNoField,:),...
        [str ' Norm RecFR F vs. NoF'],...
        ['Pyr_FRProfileNormFieldNoField' str],...
        pathAnal,[0.1 0.45],[{'F'} {''} {'NoF'} {''}])

    plotBoxPlot(FRProfileMean.percChange0to1VsBL(indCurCField)',...
        FRProfileMean.percChange0to1VsBL(indCurCNoField)',...
        [str ' average FR change 0-1s/BL FN/NoFN'],...
        ['Pyr_FRChange' str '0to1-BLFieldNeuNoFieldNeuBox'],...
        pathAnal,[-1 15],FRProfileMeanStatC.pRSPercChange0to1VsBLFieldNeuVsNoFieldNeu,...
        colorSel,[{'F'} {'NoF'}]);

    plotBoxPlot(FRProfileMean.percChangeBefRunVsBL(indCurCField)',...
        FRProfileMean.percChangeBefRunVsBL(indCurCNoField)',...
        [str ' average FR change BefRun/BL FN/NoFN'],...
        ['Pyr_FRChange' str 'BefRun-BLFieldNeuNoFieldNeuBox'],...
        pathAnal,[-1 15],FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldNeuVsNoFieldNeu,...
        colorSel,[{'F'} {'NoF'}]);

    plotBoxPlot(FRProfileMean.percChangeBefRunVs0to1(indCurCField)',...
        FRProfileMean.percChangeBefRunVs0to1(indCurCNoField)',...
        [str ' average FR change BefRun/0to1s FN/NoFN'],...
        ['Pyr_FRChange' str 'BefRun-0to1FieldNoFieldNeuBox'],...
        pathAnal,[-1 15],FRProfileMeanStatC.pRSPercChangeBefRunVs0to1FieldNeuVsNoFieldNeu,...
        colorSel,[{'F'} {'NoF'}]);

    plotBoxPlot(FRProfileMean.percChange0to1Vs3to5(indCurCField)',...
        FRProfileMean.percChange0to1Vs3to5(indCurCNoField)',...
        [str ' average FR change 0-1s/3-5s FN/NoFN'],...
        ['Pyr_FRChange' str '0to1-3to5FieldNeuNoFieldNeuBox'],...
        pathAnal,[-1 15],FRProfileMeanStatC.pRSPercChange0to1Vs3to5FieldNeuVsNoFieldNeu,...
        colorSel,[{'F'} {'NoF'}]);

    plotBoxPlot(FRProfileMean.percChangeBefRunVs3to5(indCurCField)',...
        FRProfileMean.percChangeBefRunVs3to5(indCurCNoField)',...
        [str ' average FR change BefRun/3-5s FNeu/NoFNeu'],...
        ['Pyr_FRChange' str 'BefRun-3to5FieldNeuNoFieldNeuBox'],...
        pathAnal,[-1 15],FRProfileMeanStatC.pRSPercChangeBefRunVs3to5FieldNeuVsNoFieldNeu,...
        colorSel,[{'F'} {'NoF'}]);