function FRProfileMeanStatC = accumMeanStat(FRProfileMean,nNeuWithField,isNeuWithField)
%% calculate statistics for invididual segments of FR profile between recordings with and without fields
%% this functions is called by PyrInitPeakAllRec.m

      
    %% recordings with field vs without field
    indCurCField = nNeuWithField >= 2;
    indCurCNoField = nNeuWithField < 1;
    FRProfileMeanStatC.pRS0to1VsBLField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfile0to1(indCurCField));
    FRProfileMeanStatC.pRS0to1VsBLNoField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile0to1(indCurCNoField));        

    FRProfileMeanStatC.pRSBefRunVsBLField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
    FRProfileMeanStatC.pRSBefRunVsBLNoField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));

    FRProfileMeanStatC.pRS3to5VsBLField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5VsBLNoField = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRSBefRunVs0to1Field = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
    FRProfileMeanStatC.pRSBefRunVs0to1NoField = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));

    FRProfileMeanStatC.pRS3to5Vs0to1Field = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5Vs0to1NoField = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRS3to5VsBefRunField = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5VsBefRunNoField = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRSPercChange0to1VsBLFieldVsNoField = ...
        ranksum(FRProfileMean.percChange0to1VsBL(indCurCField),...
        FRProfileMean.percChange0to1VsBL(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldVsNoField = ...
        ranksum(FRProfileMean.percChangeBefRunVsBL(indCurCField),...
        FRProfileMean.percChangeBefRunVsBL(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVs0to1FieldVsNoField = ...
        ranksum(FRProfileMean.percChangeBefRunVs0to1(indCurCField),...
        FRProfileMean.percChangeBefRunVs0to1(indCurCNoField));

    FRProfileMeanStatC.pRSPercChange0to1Vs3to5FieldVsNoField = ...
        ranksum(FRProfileMean.percChange0to1Vs3to5(indCurCField),...
        FRProfileMean.percChange0to1Vs3to5(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVs3to5FieldVsNoField = ...
        ranksum(FRProfileMean.percChangeBefRunVs3to5(indCurCField),...
        FRProfileMean.percChangeBefRunVs3to5(indCurCNoField));

    %% neurons with field vs without field
    indCurCField = isNeuWithField == 1;
    indCurCNoField = isNeuWithField == 0;
    FRProfileMeanStatC.pRS0to1VsBLFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfile0to1(indCurCField));
    FRProfileMeanStatC.pRS0to1VsBLNoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile0to1(indCurCNoField));        

    FRProfileMeanStatC.pRSBefRunVsBLFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
    FRProfileMeanStatC.pRSBefRunVsBLNoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));

    FRProfileMeanStatC.pRSBefRunVs0to1FieldNeu = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCField));
    FRProfileMeanStatC.pRSBefRunVs0to1NoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField));

    FRProfileMeanStatC.pRS3to5VsBLFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5VsBLNoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBaseline(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRS3to5Vs0to1FieldNeu = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5Vs0to1NoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfile0to1(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRS3to5VsBefRunFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCField));
    FRProfileMeanStatC.pRS3to5VsBefRunNoFieldNeu = ranksum(FRProfileMean.meanAvgFRProfileBefRun(indCurCNoField),...
                FRProfileMean.meanAvgFRProfile3to5(indCurCNoField));

    FRProfileMeanStatC.pRSPercChange0to1VsBLFieldNeuVsNoFieldNeu = ...
        ranksum(FRProfileMean.percChange0to1VsBL(indCurCField),...
        FRProfileMean.percChange0to1VsBL(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVsBLFieldNeuVsNoFieldNeu = ...
        ranksum(FRProfileMean.percChangeBefRunVsBL(indCurCField),...
        FRProfileMean.percChangeBefRunVsBL(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVs0to1FieldNeuVsNoFieldNeu = ...
        ranksum(FRProfileMean.percChangeBefRunVs0to1(indCurCField),...
        FRProfileMean.percChangeBefRunVs0to1(indCurCNoField));

    FRProfileMeanStatC.pRSPercChange0to1Vs3to5FieldNeuVsNoFieldNeu = ...
        ranksum(FRProfileMean.percChange0to1Vs3to5(indCurCField),...
        FRProfileMean.percChange0to1Vs3to5(indCurCNoField));

    FRProfileMeanStatC.pRSPercChangeBefRunVs3to5FieldNeuVsNoFieldNeu = ...
        ranksum(FRProfileMean.percChangeBefRunVs3to5(indCurCField),...
        FRProfileMean.percChangeBefRunVs3to5(indCurCNoField));
end