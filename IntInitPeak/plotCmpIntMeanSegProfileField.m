function plotCmpIntMeanSegProfileField(pathAnal,modInt1,FRProfileMean,FRProfileMeanStatC,colorSel)

    % compare the mean of each segment of avgFRProfile (field vs. no field)
    for i = 1:max(modInt1.idxC)   
        indCurCField = modInt1.idxC == i & modInt1.nNeuWithFieldAligned > 1;
        indCurCNoField = modInt1.idxC == i & modInt1.nNeuWithFieldAligned < 1;
        x = FRProfileMean.meanAvgFRProfileBaseline(indCurCField);
        x1 = FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField);
        y = FRProfileMean.meanAvgFRProfile0to1(indCurCField);
        y1 = FRProfileMean.meanAvgFRProfile0to1(indCurCNoField);
        barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
            [std(y./x)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
            y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change 0to1s/BL F/NoF'],...
            [],FRProfileMeanStatC.pRSPercChange0to1VsBefRunFieldVsNoField(i),...
            ['Int_FRChangeMeanC' num2str(i) 'BL-0to1FieldNoFieldBar'],...
            pathAnal,colorSel,[{'F'} {'NoF'}]);
        
        x = FRProfileMean.meanAvgFRProfileBaseline(indCurCField);
        x1 = FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField);
        y = FRProfileMean.meanAvgFRProfileBefRun(indCurCField);
        y1 = FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField);
        barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
            [std(y./x)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
            y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change BefRun/BL  F/NoF'],...
            [],FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldVsNoField(i),...
            ['Int_FRChangeMeanC' num2str(i) 'BL-BefRunFieldNoFieldBar'],...
            pathAnal,colorSel,[{'F'} {'NoF'}]);
        
%         x = FRProfileMean.meanAvgFRProfileBaseline(indCurCField);
%         x1 = FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField);
%         y = FRProfileMean.meanAvgFRProfile1to5(indCurCField);
%         y1 = FRProfileMean.meanAvgFRProfile1to5(indCurCNoField);
%         barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
%             [std(y./x)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
%             y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change 1to5s/BL F/NoF'],...
%             [],FRProfileMeanStatC.pRSPercChange0to1Vs1to5FieldVsNoField(i),...
%             ['Int_FRChangeMeanC' num2str(i) 'BL-1to5FieldNoFieldBar'],...
%             pathAnal,colorSel,[{'F'} {'NoF'}]);
%         
%         y = FRProfileMean.meanAvgFRProfile1to5(indCurCField);
%         y1 = FRProfileMean.meanAvgFRProfile1to5(indCurCNoField);        
%         x = FRProfileMean.meanAvgFRProfileBefRun(indCurCField);
%         x1 = FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField);
%         barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
%             [std(y./x)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
%             y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change 1to5s/BefRun F/NoF'],...
%             [],FRProfileMeanStatC.pTTPercChangeBefRunVs1to5(i),...
%             ['Int_FRChangeMeanC' num2str(i) 'BefRun-1to5FieldNoFieldBar'],...
%             pathAnal,colorSel,[{'F'} {'NoF'}]);
  
        x = FRProfileMean.meanAvgFRProfileBefRun(indCurCField);
        x1 = FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField);
        y = FRProfileMean.meanAvgFRProfile0to1(indCurCField);
        y1 = FRProfileMean.meanAvgFRProfile0to1(indCurCNoField);
        barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
            [std(y./x)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
            y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change 0to1s/BefRun F/NoF'],...
            [],FRProfileMeanStatC.pRSPercChange0to1VsBefRunFieldVsNoField(i),...
            ['Int_FRChangeMeanC' num2str(i) 'BefRun-0to1FieldNoFieldBar'],...
            pathAnal,colorSel,[{'F'} {'NoF'}]);
       
%         x = FRProfileMean.meanAvgFRProfile0to1(indCurCField);
%         x1 = FRProfileMean.meanAvgFRProfile0to1(indCurCNoField);
%         y = FRProfileMean.meanAvgFRProfile1to5(indCurCField);
%         y1 = FRProfileMean.meanAvgFRProfile1to5(indCurCNoField);  
%         barPlotWithStat3(1:2, [mean(y./x),mean(y1./x1)],...
%             [std(y1./x1)/sqrt(length(x)),std(y1./x1)/sqrt(length(x1))],...
%             y./x, y1./x1,['C' num2str(i) ' average mFR (Hz) change 1to5s/0to1s F/NoF'],...
%             [],FRProfileMeanStatC.pRSPercChange0to1Vs1to5FieldVsNoField(i),...
%             ['Int_FRChangeMeanC' num2str(i) '0to1-1to5FieldNoFieldBar'],...
%             pathAnal,colorSel,[{'F'} {'NoF'}]);      
    end