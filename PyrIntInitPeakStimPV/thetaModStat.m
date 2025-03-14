function thetaModStat = thetaModStat(thetaMod1,thetaMod2)
    thetaModStat.meanThetaFreqHMean = [mean(thetaMod1.thetaFreqHMean),...
        mean(thetaMod2.thetaFreqHMean)];
    thetaModStat.meanThetaMod = [mean(thetaMod1.thetaMod(~isnan(thetaMod1.thetaMod))),...
        mean(thetaMod2.thetaMod(~isnan(thetaMod2.thetaMod)))];
    thetaModStat.meanThetaModInd = [mean(thetaMod1.thetaModInd(~isnan(thetaMod1.thetaModInd))),...
        mean(thetaMod2.thetaModInd(~isnan(thetaMod2.thetaModInd)))];
    thetaModStat.meanThetaModInd3 = [mean(thetaMod1.thetaModInd3(~isnan(thetaMod1.thetaModInd3))),...
        mean(thetaMod2.thetaModInd3(~isnan(thetaMod2.thetaModInd3)))];
    thetaModStat.meanThetaAsym3 = [mean(thetaMod1.thetaAsym3),...
        mean(thetaMod2.thetaAsym3)];
    thetaModStat.meanDiffThetaFreq = [mean(thetaMod1.diffThetaFreq),...
        mean(thetaMod2.diffThetaFreq)];
    
    thetaModStat.semThetaFreqHMean = [std(thetaMod1.thetaFreqHMean)/...
        sqrt(length(thetaMod1.thetaFreqHMean)),...
        std(thetaMod2.thetaFreqHMean)/...
        sqrt(length(thetaMod2.thetaFreqHMean))];
    thetaModStat.semThetaMod = [std(thetaMod1.thetaMod(~isnan(thetaMod1.thetaMod)))/...
        sqrt(sum(~isnan(thetaMod1.thetaMod))),...
        std(thetaMod2.thetaMod(~isnan(thetaMod2.thetaMod)))/...
        sqrt(sum(~isnan(thetaMod2.thetaMod)))];
    thetaModStat.semThetaModInd = [std(thetaMod1.thetaModInd(~isnan(thetaMod1.thetaModInd)))/...
        sqrt(sum(~isnan(thetaMod1.thetaModInd))),...
        std(thetaMod2.thetaModInd(~isnan(thetaMod2.thetaModInd)))/...
        sqrt(sum(~isnan(thetaMod1.thetaModInd)))];
    thetaModStat.semThetaModInd3 = [std(thetaMod1.thetaModInd3(~isnan(thetaMod1.thetaModInd3)))/...
        sqrt(sum(~isnan(thetaMod1.thetaModInd3))),...
        std(thetaMod2.thetaModInd3(~isnan(thetaMod2.thetaModInd3)))/...
        sqrt(sum(~isnan(thetaMod2.thetaModInd3)))];
    thetaModStat.semThetaAsym3 = [std(thetaMod1.thetaAsym3)/...
        sqrt(length(thetaMod1.thetaAsym3)),...
        std(thetaMod2.thetaAsym3)/...
        sqrt(length(thetaMod2.thetaAsym3))];
    thetaModStat.semDiffThetaFreq = [mean(thetaMod1.diffThetaFreq)/...
        sqrt(length(thetaMod1.diffThetaFreq)),...
        std(thetaMod2.diffThetaFreq)/...
        sqrt(length(thetaMod2.diffThetaFreq))];
    
    thetaModStat.pRSThetaFreqHMean = ranksum(thetaMod1.thetaFreqHMean,thetaMod2.thetaFreqHMean);
    thetaModStat.pRSThetaMod = ranksum(thetaMod1.thetaMod,thetaMod2.thetaMod);
    thetaModStat.pRSThetaModInd = ranksum(thetaMod1.thetaModInd,thetaMod2.thetaModInd);
    thetaModStat.pRSThetaModInd3 = ranksum(thetaMod1.thetaModInd3,thetaMod2.thetaModInd3);
    thetaModStat.pRSThetaAsym3 = ranksum(thetaMod1.thetaAsym3,thetaMod2.thetaAsym3);
    thetaModStat.pRSDiffThetaFreq = ranksum(thetaMod1.diffThetaFreq,thetaMod2.diffThetaFreq);
end