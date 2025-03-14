function PyrIntInitPeak_PLoc(pathS)
%% identify the peak location for each pyrRise and pyrDown neuron
%% and calculate the time constants of their ramping dynamics

    pathAnal0 = [pathS '\PyramidalIntInitPeakAL\'];
    load([pathAnal0 'initPeakPyrIntAllRec.mat'],'InitAll','PyrRise','PyrDown');
    
    pathAnal = [pathS '\Pyramidal\'];
    load([pathAnal 'initPeakPyrAllRec.mat'],'modPyr1AL');
    
    idxPyrRise = PyrRise.idxRise;
    idxPyrDown = PyrDown.idxDown;
    
    pathAnal1 = [pathAnal0 'FRPeak\'];
    if(~exist(pathAnal1))
        mkdir(pathAnal1);
    end
    
%     if(exist([pathAnal1 'avgFRProfile_PeakAndTau.mat']))
%         load([pathAnal1 'avgFRProfile_PeakAndTau.mat']);
%     else
       
        %% identify trough for PyrDown
        idx_TimeDown = find(modPyr1AL.timeStepRun > -1 & modPyr1AL.timeStepRun <= 4); % after run onset
        idx_TimeDown_Win = find(modPyr1AL.timeStepRun > 0 & modPyr1AL.timeStepRun <= 3); % after run onset
        PyrDownTrough.idx_TimeDown = idx_TimeDown;
        PyrDownTrough.idx_TimeDown_Win = idx_TimeDown_Win;
        PyrDownTrough = troughDetectionPyr(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrDown,:),idx_TimeDown,idx_TimeDown_Win);

        %% identify peaks
        % PyrRise
        % time step indices during which the peak will be identified
        idx_TimeAftRun = find(modPyr1AL.timeStepRun > 0 & modPyr1AL.timeStepRun <= 6); % after run onset
        PyrRisePeak_AftRun.idx_TimeAftRun = idx_TimeAftRun;
        % peak detection for pyrRise neurons
        PyrRisePeak_AftRun = peakDetectionPyr(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrRise,:),idx_TimeAftRun);

        % PyrDown
        % time step indices during which the peak will be identified
        idx_TimeBefRunDown = find(modPyr1AL.timeStepRun >= -1.5 & modPyr1AL.timeStepRun < 1.5); % Bef run onset
        idx_TimeAftRunDown = find(modPyr1AL.timeStepRun > 1 & modPyr1AL.timeStepRun <= 6); % after run onset
        PyrDownPeak_BefRun.idx_TimeBefRunDown = idx_TimeBefRunDown;
        PyrDownPeak_AftRun.idx_TimeAftRunDown = idx_TimeAftRunDown;
        % peak detection for pyrDown neurons
        PyrDownPeak_BefRun = peakDetectionPyr(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrDown,:),idx_TimeBefRunDown);
        PyrDownPeak_AftRun = peakDetectionPyr(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrDown,:),idx_TimeAftRunDown);

        %% calculate the mean FR before and after the run onset
        % time step indices 
        idx_TimeBef = find(modPyr1AL.timeStepRun >= -1.5 & modPyr1AL.timeStepRun < -0.5); % before run onset
        idx_TimeAft = find(modPyr1AL.timeStepRun >= 0.5 & modPyr1AL.timeStepRun < 1.5); % after run onset
        % PyrRise
        PyrRisePeak_AftRun.meanFRBef = mean(InitAll.avgFRProfile(idxPyrRise,idx_TimeBef),2);
        PyrRisePeak_AftRun.meanFRAft = mean(InitAll.avgFRProfile(idxPyrRise,idx_TimeAft),2);
        PyrRisePeak_AftRun.idx_TimeBef = idx_TimeBef;
        PyrRisePeak_AftRun.idx_TimeAft = idx_TimeAft;
        % PyrDown
        PyrDownPeak_AftRun.meanFRBef = mean(InitAll.avgFRProfile(idxPyrDown,idx_TimeBef),2);
        PyrDownPeak_AftRun.meanFRAft = mean(InitAll.avgFRProfile(idxPyrDown,idx_TimeAft),2);
        PyrDownPeak_AftRun.idx_TimeBef = idx_TimeBef;
        PyrDownPeak_AftRun.idx_TimeAft = idx_TimeAft;    

        %% calculate decay time constant
        % pyrRise   
        % Extract the decay time constant(a*exp(b*x))
        displayFig = 0;
        [PyrRisePeak_AftRun.tau,PyrRisePeak_AftRun.fitcurve,PyrRisePeak_AftRun.gofcurve]...
            = tauDecayExtraction(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrRise,:),...
                PyrRisePeak_AftRun.loc,PyrRisePeak_AftRun.amp,displayFig);

        % pyrDown
        % Extract the decay time constant (a*exp(b*x)) 
        [PyrDownPeak_BefRun.tau,PyrDownPeak_BefRun.fitcurve,PyrDownPeak_BefRun.gofcurve] ...
            = tauDecayExtractionInterval(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrDown,:),...
                idx_TimeBefRunDown(end),PyrDownPeak_BefRun.loc,PyrDownPeak_BefRun.amp,displayFig);

        % Extract the rise time constant (a*exp(b*x)) with x inversed in time
        [PyrDownPeak_AftRun.tau,PyrDownPeak_AftRun.fitcurve,PyrDownPeak_AftRun.gofcurve] ...
            = tauRiseExtraction(modPyr1AL.timeStepRun,InitAll.avgFRProfile(idxPyrDown,:),...
                idx_TimeAftRunDown(1),PyrDownPeak_AftRun.loc,PyrDownPeak_AftRun.amp,displayFig);
%     end
    
        numNeuPerBins = 100;

        %% compute the correlation between mean FR before run and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation
        [PyrRisePeak_AftRun.corrCoef_OrderVsMeanFRBef, PyrRisePeak_AftRun.pVal_OrderVsMeanFRBef] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun.meanFRBef);

        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_OrderVsMeanFRBef, PyrRisePeak_AftRun.slopeP_OrderVsMeanFRBef,...
            PyrRisePeak_AftRun.slope_OrderVsMeanFRBef, PyrRisePeak_AftRun.intercept_OrderVsMeanFRBef] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun.meanFRBef);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_OrderVsMeanFRBef, PyrRisePeak_AftRun.pBinned_OrderVsMeanFRBef,...
            PyrRisePeak_AftRun.binnedMeans_OrderVsMeanFRBef, PyrRisePeak_AftRun.binnedStd_OrderVsMeanFRBef,...
            PyrRisePeak_AftRun.binCenters_OrderVsMeanFRBef] = analyzeBinnedCorrelation(...
            1:length(idxPyrRise), PyrRisePeak_AftRun.meanFRBef, numNeuPerBins);

        % PyrDown
        % Calculate the correlation
        [PyrDownPeak_AftRun.corrCoef_OrderVsMeanFRBef, PyrDownPeak_AftRun.pVal_OrderVsMeanFRBef] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun.meanFRBef);

        % Estimate the slope using linear regression
        [PyrDownPeak_AftRun.lm_OrderVsMeanFRBef, PyrDownPeak_AftRun.slopeP_OrderVsMeanFRBef,...
            PyrDownPeak_AftRun.slope_OrderVsMeanFRBef, PyrDownPeak_AftRun.intercept_OrderVsMeanFRBef] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun.meanFRBef);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownPeak_AftRun.binned_OrderVsMeanFRBef, PyrDownPeak_AftRun.pBinned_OrderVsMeanFRBef,...
            PyrDownPeak_AftRun.binnedMeans_OrderVsMeanFRBef, PyrDownPeak_AftRun.binnedStd_OrderVsMeanFRBef,...
            PyrDownPeak_AftRun.binCenters_OrderVsMeanFRBef] = analyzeBinnedCorrelation(...
            1:length(idxPyrDown), PyrDownPeak_AftRun.meanFRBef, numNeuPerBins);

        %% compute the correlation between mean FR after run and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation
        [PyrRisePeak_AftRun.corrCoef_OrderVsMeanFRAft, PyrRisePeak_AftRun.pVal_OrderVsMeanFRAft] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun.meanFRAft);

        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_OrderVsMeanFRAft, PyrRisePeak_AftRun.slopeP_OrderVsMeanFRAft,...
            PyrRisePeak_AftRun.slope_OrderVsMeanFRAft, PyrRisePeak_AftRun.intercept_OrderVsMeanFRAft] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun.meanFRAft);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_OrderVsMeanFRAft, PyrRisePeak_AftRun.pBinned_OrderVsMeanFRAft,...
            PyrRisePeak_AftRun.binnedMeans_OrderVsMeanFRAft, PyrRisePeak_AftRun.binnedStd_OrderVsMeanFRAft,...
            PyrRisePeak_AftRun.binCenters_OrderVsMeanFRAft] = analyzeBinnedCorrelation(...
            1:length(idxPyrRise), PyrRisePeak_AftRun.meanFRAft, numNeuPerBins);

        % PyrDown
        % Calculate the correlation
        [PyrDownPeak_AftRun.corrCoef_OrderVsMeanFRAft, PyrDownPeak_AftRun.pVal_OrderVsMeanFRAft] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun.meanFRAft);

        % Estimate the slope using linear regression
        [PyrDownPeak_AftRun.lm_OrderVsMeanFRAft, PyrDownPeak_AftRun.slopeP_OrderVsMeanFRAft,...
            PyrDownPeak_AftRun.slope_OrderVsMeanFRAft, PyrDownPeak_AftRun.intercept_OrderVsMeanFRAft] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun.meanFRAft);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownPeak_AftRun.binned_OrderVsMeanFRAft, PyrDownPeak_AftRun.pBinned_OrderVsMeanFRAft,...
            PyrDownPeak_AftRun.binnedMeans_OrderVsMeanFRAft, PyrDownPeak_AftRun.binnedStd_OrderVsMeanFRAft,...
            PyrDownPeak_AftRun.binCenters_OrderVsMeanFRAft] = analyzeBinnedCorrelation(...
            1:length(idxPyrDown), PyrDownPeak_AftRun.meanFRAft, numNeuPerBins);

        %% compute the correlation between the peak time and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation
        [PyrRisePeak_AftRun.corrCoef_OrderVsPeakTime, PyrRisePeak_AftRun.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun.time);

        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_OrderVsPeakTime, PyrRisePeak_AftRun.slopeP_OrderVsPeakTime,...
            PyrRisePeak_AftRun.slope_OrderVsPeakTime, PyrRisePeak_AftRun.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun.time);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_OrderVsPeakTime, PyrRisePeak_AftRun.pBinned_OrderVsPeakTime,...
            PyrRisePeak_AftRun.binnedMeans_OrderVsPeakTime, PyrRisePeak_AftRun.binnedStd_OrderVsPeakTime,...
            PyrRisePeak_AftRun.binCenters_OrderVsPeakTime] = analyzeBinnedCorrelation(...
            1:length(idxPyrRise), PyrRisePeak_AftRun.time, numNeuPerBins);

        % PyrDown
        % Calculate the correlation
        [PyrDownPeak_AftRun.corrCoef_OrderVsPeakTime, PyrDownPeak_AftRun.pVal_OrderVsPeakTime] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun.time);

        % Estimate the slope using linear regression
        [PyrDownPeak_AftRun.lm_OrderVsPeakTime, PyrDownPeak_AftRun.slopeP_OrderVsPeakTime,...
            PyrDownPeak_AftRun.slope_OrderVsPeakTime, PyrDownPeak_AftRun.intercept_OrderVsPeakTime] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun.time);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownPeak_AftRun.binned_OrderVsPeakTime, PyrDownPeak_AftRun.pBinned_OrderVsPeakTime,...
            PyrDownPeak_AftRun.binnedMeans_OrderVsPeakTime, PyrDownPeak_AftRun.binnedStd_OrderVsPeakTime,...
            PyrDownPeak_AftRun.binCenters_OrderVsPeakTime] = analyzeBinnedCorrelation(...
            1:length(idxPyrDown), PyrDownPeak_AftRun.time, numNeuPerBins);

        %% compute the correlation between the peak amplitude and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation
        [PyrRisePeak_AftRun.corrCoef_OrderVsPeakAmp, PyrRisePeak_AftRun.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun.amp);

        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_OrderVsPeakAmp, PyrRisePeak_AftRun.slopeP_OrderVsPeakAmp,...
            PyrRisePeak_AftRun.slope_OrderVsPeakAmp, PyrRisePeak_AftRun.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun.amp);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_OrderVsPeakAmp, PyrRisePeak_AftRun.pBinned_OrderVsPeakAmp,...
            PyrRisePeak_AftRun.binnedMeans_OrderVsPeakAmp, PyrRisePeak_AftRun.binnedStd_OrderVsPeakAmp,...
            PyrRisePeak_AftRun.binCenters_OrderVsPeakAmp] = analyzeBinnedCorrelation(...
            1:length(idxPyrRise), PyrRisePeak_AftRun.amp, numNeuPerBins);

        % PyrDown
        % Calculate the correlation
        [PyrDownPeak_AftRun.corrCoef_OrderVsPeakAmp, PyrDownPeak_AftRun.pVal_OrderVsPeakAmp] ...
            = calCorrCoeff(1:length(idxPyrDown),PyrDownPeak_AftRun.amp);

        % Estimate the slope using linear regression
        [PyrDownPeak_AftRun.lm_OrderVsPeakAmp, PyrDownPeak_AftRun.slopeP_OrderVsPeakAmp,...
            PyrDownPeak_AftRun.slope_OrderVsPeakAmp, PyrDownPeak_AftRun.intercept_OrderVsPeakAmp] ...
            = linearRegression(1:length(idxPyrDown),PyrDownPeak_AftRun.amp);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownPeak_AftRun.binned_OrderVsPeakAmp, PyrDownPeak_AftRun.pBinned_OrderVsPeakAmp,...
            PyrDownPeak_AftRun.binnedMeans_OrderVsPeakAmp, PyrDownPeak_AftRun.binnedStd_OrderVsPeakAmp,...
            PyrDownPeak_AftRun.binCenters_OrderVsPeakAmp] = analyzeBinnedCorrelation(...
            1:length(idxPyrDown), PyrDownPeak_AftRun.amp, numNeuPerBins);

        %% compute the correlation between the trough time and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrDown
        % Calculate the correlation
        idxNonNan = isnan(PyrDownTrough.loc);
        [PyrDownTrough.corrCoef_OrderVsTroughTime, PyrDownTrough.pVal_OrderVsTroughTime] ...
            = calCorrCoeff(1:sum(~idxNonNan),PyrDownTrough.time(~idxNonNan));

        % Estimate the slope using linear regression
        [PyrDownTrough.lm_OrderVsTroughTime, PyrDownTrough.slopeP_OrderVsTroughTime,...
            PyrDownTrough.slope_OrderVsTroughTime, PyrDownTrough.intercept_OrderVsTroughTime] ...
            = linearRegression(1:sum(~idxNonNan),PyrDownTrough.time(~idxNonNan));

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownTrough.binned_OrderVsTroughTime, PyrDownTrough.pBinned_OrderVsTroughTime,...
            PyrDownTrough.binnedMeans_OrderVsTroughTime, PyrDownTrough.binnedStd_OrderVsTroughTime,...
            PyrDownTrough.binCenters_OrderVsTroughTime] = analyzeBinnedCorrelation(...
            1:sum(~idxNonNan), PyrDownTrough.time(~idxNonNan), numNeuPerBins);

        %% compute the correlation between the trough amplitude and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrDown
        % Calculate the correlation
        idxNonNan = isnan(PyrDownTrough.amp);
        [PyrDownTrough.corrCoef_OrderVsTroughAmp, PyrDownTrough.pVal_OrderVsTroughAmp] ...
            = calCorrCoeff(1:sum(~idxNonNan),PyrDownTrough.amp(~idxNonNan));

        % Estimate the slope using linear regression
        [PyrDownTrough.lm_OrderVsTroughAmp, PyrDownTrough.slopeP_OrderVsTroughAmp,...
            PyrDownTrough.slope_OrderVsTroughAmp, PyrDownTrough.intercept_OrderVsTroughAmp] ...
            = linearRegression(1:sum(~idxNonNan),PyrDownTrough.amp(~idxNonNan));

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownTrough.binned_OrderVsTroughAmp, PyrDownTrough.pBinned_OrderVsTroughAmp,...
            PyrDownTrough.binnedMeans_OrderVsTroughAmp, PyrDownTrough.binnedStd_OrderVsTroughAmp,...
            PyrDownTrough.binCenters_OrderVsTroughAmp] = analyzeBinnedCorrelation(...
            1:sum(~idxNonNan), PyrDownTrough.amp(~idxNonNan), numNeuPerBins);

        %% compute the correlation between time constant and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrRise
        % Calculate the correlation
        [PyrRisePeak_AftRun.corrCoef_OrderVsTau, PyrRisePeak_AftRun.pVal_OrderVsTau] ...
            = calCorrCoeff(1:length(idxPyrRise),PyrRisePeak_AftRun.tau);

        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_OrderVsTau, PyrRisePeak_AftRun.slopeP_OrderVsTau,...
            PyrRisePeak_AftRun.slope_OrderVsTau, PyrRisePeak_AftRun.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxPyrRise),PyrRisePeak_AftRun.tau);

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_OrderVsTau, PyrRisePeak_AftRun.pBinned_OrderVsTau,...
            PyrRisePeak_AftRun.binnedMeans_OrderVsTau, PyrRisePeak_AftRun.binnedStd_OrderVsTau,...
            PyrRisePeak_AftRun.binCenters_OrderVsTau] = analyzeBinnedCorrelation(...
            1:length(idxPyrRise), PyrRisePeak_AftRun.tau, numNeuPerBins);

        %% compute the correlation between time constant and the neuron's
        %% firing rate before run onset, 11/16/2024W
        % Calculate the correlation
        idxMeanFRBef = PyrRisePeak_AftRun.meanFRBef > 0.01;
        [PyrRisePeak_AftRun.corrCoef_MeanFRBefVsTau, PyrRisePeak_AftRun.pVal_MeanFRBefVsTau] ...
            = calCorrCoeff(log10(PyrRisePeak_AftRun.meanFRBef(idxMeanFRBef)),PyrRisePeak_AftRun.tau(idxMeanFRBef));
        
        % Estimate the slope using linear regression
        [PyrRisePeak_AftRun.lm_MeanFRBefVsTau, PyrRisePeak_AftRun.slopeP_MeanFRBefVsTau,...
            PyrRisePeak_AftRun.slope_MeanFRBefVsTau, PyrRisePeak_AftRun.intercept_MeanFRBefVsTau] ...
            = linearRegression(log10(PyrRisePeak_AftRun.meanFRBef(idxMeanFRBef)),PyrRisePeak_AftRun.tau(idxMeanFRBef));

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrRisePeak_AftRun.binned_MeanFRBefVsTau, PyrRisePeak_AftRun.pBinned_MeanFRBefVsTau,...
            PyrRisePeak_AftRun.binnedMeans_MeanFRBefVsTau, PyrRisePeak_AftRun.binnedStd_MeanFRBefVsTau,...
            PyrRisePeak_AftRun.binCenters_MeanFRBefVsTau] = analyzeBinnedCorrelation(...
            log10(PyrRisePeak_AftRun.meanFRBef(idxMeanFRBef)), PyrRisePeak_AftRun.tau(idxMeanFRBef), numNeuPerBins);

        %% compute the correlation between time constant and the neuron order based on
        %% firing rate ratio between 0 to 1 s and before run onset
        % PyrDown
        % Calculate the correlation between -1.5 to 1.5s
        idxValid = find(isnan(PyrDownPeak_BefRun.tau) == 0);
        [PyrDownPeak_BefRun.corrCoef_OrderVsTau, PyrDownPeak_BefRun.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_BefRun.tau(idxValid));

        % Estimate the slope using linear regression
        [PyrDownPeak_BefRun.lm_OrderVsTau, PyrDownPeak_BefRun.slopeP_OrderVsTau,...
            PyrDownPeak_BefRun.slope_OrderVsTau, PyrDownPeak_BefRun.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxValid),PyrDownPeak_BefRun.tau(idxValid)); % changed 11/16/2024

        % Calculate the correlation between 1 to 6 s
        idxValid = find(isnan(PyrDownPeak_AftRun.tau) == 0);
        [PyrDownPeak_AftRun.corrCoef_OrderVsTau, PyrDownPeak_AftRun.pVal_OrderVsTau] ...
            = calCorrCoeff(idxValid,PyrDownPeak_AftRun.tau(idxValid));

        % Estimate the slope using linear regression
        [PyrDownPeak_AftRun.lm_OrderVsTau, PyrDownPeak_AftRun.slopeP_OrderVsTau,...
            PyrDownPeak_AftRun.slope_OrderVsTau, PyrDownPeak_AftRun.intercept_OrderVsTau] ...
            = linearRegression(1:length(idxValid),PyrDownPeak_AftRun.tau(idxValid)); % changed 11/16/2024

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownPeak_AftRun.binned_OrderVsTau, PyrDownPeak_AftRun.pBinned_OrderVsTau,...
            PyrDownPeak_AftRun.binnedMeans_OrderVsTau, PyrDownPeak_AftRun.binnedStd_OrderVsTau,...
            PyrDownPeak_AftRun.binCenters_OrderVsTau] = analyzeBinnedCorrelation(...
           1:length(idxValid),PyrDownPeak_AftRun.tau(idxValid), numNeuPerBins);

        %% compute the correlation between time constant and the neuron's
        %% trough firing rate, 11/16/2024
        % Calculate the correlation
        idxTmp = isnan(log10(PyrDownTrough.amp)) == 0 & isinf(log10(PyrDownTrough.amp)) == 0 & isnan(PyrDownPeak_AftRun.tau) == 0 ...
                    & PyrDownTrough.amp > 0.01 & PyrDownPeak_AftRun.tau <= 16;
        [PyrDownTrough.corrCoef_AmpVsTau, PyrDownTrough.pVal_AmpVsTau] ...
            = calCorrCoeff(log10(PyrDownTrough.amp(idxTmp)),PyrDownPeak_AftRun.tau(idxTmp));
        
        % Estimate the slope using linear regression 
        [PyrDownTrough.lm_AmpVsTau, PyrDownTrough.slopeP_AmpVsTau,...
            PyrDownTrough.slope_AmpVsTau, PyrDownTrough.intercept_AmpVsTau] ...
            = linearRegression(log10(PyrDownTrough.amp(idxTmp)),PyrDownPeak_AftRun.tau(idxTmp));

        % Estimate the slope after binning the x-axis, 11/16/2024
        [PyrDownTrough.binned_AmpVsTau, PyrDownTrough.pBinned__AmpVsTau,...
            PyrDownTrough.binnedMeans_AmpVsTau, PyrDownTrough.binnedStd_AmpVsTau,...
            PyrDownTrough.binCenters_AmpVsTau] = analyzeBinnedCorrelation(...
            log10(PyrDownTrough.amp(idxTmp)),PyrDownPeak_AftRun.tau(idxTmp), numNeuPerBins);


        save([pathAnal1 'avgFRProfile_PeakAndTau.mat'], 'PyrRisePeak_AftRun','PyrDownPeak_AftRun','PyrDownPeak_BefRun','PyrDownTrough');
    % end
    
    %% plot the mean FR before run vs the neuron order 
    % PyrRise
    plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun.meanFRBef',...
        PyrRisePeak_AftRun.lm_OrderVsMeanFRBef,PyrRisePeak_AftRun.corrCoef_OrderVsMeanFRBef,...
        'Neuron no. (PyrRise)','Mean FR befrun (Hz)',pathAnal1,'PyrRise_MeanFRBefVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrRise))',PyrRisePeak_AftRun.meanFRBef',...
        PyrRisePeak_AftRun.binCenters_OrderVsMeanFRBef,PyrRisePeak_AftRun.binnedMeans_OrderVsMeanFRBef,...
        PyrRisePeak_AftRun.binnedStd_OrderVsMeanFRBef,PyrRisePeak_AftRun.binned_OrderVsMeanFRBef,...
        'Neuron no. (PyrRise)','Mean FR befrun (Hz)',pathAnal1,'PyrRise_BinnedMeanFRBefVsOrderNo');
    
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun.meanFRBef',...
        PyrDownPeak_AftRun.lm_OrderVsMeanFRBef,PyrDownPeak_AftRun.corrCoef_OrderVsMeanFRBef,...
        'Neuron no. (PyrDown)','Mean FR befrun (Hz)',pathAnal1,'PyrDown_MeanFRBefVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownPeak_AftRun.meanFRBef',...
        PyrDownPeak_AftRun.binCenters_OrderVsMeanFRBef,PyrDownPeak_AftRun.binnedMeans_OrderVsMeanFRBef,...
        PyrDownPeak_AftRun.binnedStd_OrderVsMeanFRBef,PyrDownPeak_AftRun.binned_OrderVsMeanFRBef,...
        'Neuron no. (PyrDown)','Mean FR befrun (Hz)',pathAnal1,'PyrDown_BinnedMeanFRBefVsOrderNo');
    
    %% plot the mean FR after run vs the neuron order 
    % PyrRise
    plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun.meanFRAft',...
        PyrRisePeak_AftRun.lm_OrderVsMeanFRAft,PyrRisePeak_AftRun.corrCoef_OrderVsMeanFRAft,...
        'Neuron no. (PyrRise)','Mean FR aftrun (Hz)',pathAnal1,'PyrRise_MeanFRAftVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrRise))',PyrRisePeak_AftRun.meanFRAft',...
        PyrRisePeak_AftRun.binCenters_OrderVsMeanFRAft,PyrRisePeak_AftRun.binnedMeans_OrderVsMeanFRAft,...
        PyrRisePeak_AftRun.binnedStd_OrderVsMeanFRAft,PyrRisePeak_AftRun.binned_OrderVsMeanFRAft,...
        'Neuron no. (PyrRise)','Mean FR Aftrun (Hz)',pathAnal1,'PyrRise_BinnedMeanFRAftVsOrderNo');
    
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun.meanFRAft',...
        PyrDownPeak_AftRun.lm_OrderVsMeanFRAft,PyrDownPeak_AftRun.corrCoef_OrderVsMeanFRAft,...
        'Neuron no. (PyrDown)','Mean FR aftrun (Hz)',pathAnal1,'PyrDown_MeanFRAftVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownPeak_AftRun.meanFRAft',...
        PyrDownPeak_AftRun.binCenters_OrderVsMeanFRAft,PyrDownPeak_AftRun.binnedMeans_OrderVsMeanFRAft,...
        PyrDownPeak_AftRun.binnedStd_OrderVsMeanFRAft,PyrDownPeak_AftRun.binned_OrderVsMeanFRAft,...
        'Neuron no. (PyrDown)','Mean FR Aftrun (Hz)',pathAnal1,'PyrDown_BinnedMeanFRAftVsOrderNo');
    
    %% plot the peak time vs the neuron order 
    % PyrRise
    plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun.time',...
        PyrRisePeak_AftRun.lm_OrderVsPeakTime,PyrRisePeak_AftRun.corrCoef_OrderVsPeakTime,...
        'Neuron no. (PyrRise)','Peak time (s)',pathAnal1,'PyrRise_PeakTimeVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrRise))',PyrRisePeak_AftRun.time',...
        PyrRisePeak_AftRun.binCenters_OrderVsPeakTime,PyrRisePeak_AftRun.binnedMeans_OrderVsPeakTime,...
        PyrRisePeak_AftRun.binnedStd_OrderVsPeakTime,PyrRisePeak_AftRun.binned_OrderVsPeakTime,...
        'Neuron no. (PyrRise)','Peak time (s)',pathAnal1,'PyrRise_BinnedPeakTimeVsOrderNo');
    
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun.time',...
        PyrDownPeak_AftRun.lm_OrderVsPeakTime,PyrDownPeak_AftRun.corrCoef_OrderVsPeakTime,...
        'Neuron no. (PyrDown)','Peak time (s)',pathAnal1,'PyrDown_PeakTimeVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownPeak_AftRun.time',...
        PyrDownPeak_AftRun.binCenters_OrderVsPeakTime,PyrDownPeak_AftRun.binnedMeans_OrderVsPeakTime,...
        PyrDownPeak_AftRun.binnedStd_OrderVsPeakTime,PyrDownPeak_AftRun.binned_OrderVsPeakTime,...
        'Neuron no. (PyrDown)','Peak time (s)',pathAnal1,'PyrDown_BinnedPeakTimeVsOrderNo');
    
    %% plot the peak amplitude vs the neuron order 
    % PyrRise
    plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun.amp',...
        PyrRisePeak_AftRun.lm_OrderVsPeakAmp,PyrRisePeak_AftRun.corrCoef_OrderVsPeakAmp,...
        'Neuron no. (PyrRise)','Peak amplitude (Hz)',pathAnal1,'PyrRise_PeakAmpVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrRise))',PyrRisePeak_AftRun.amp',...
        PyrRisePeak_AftRun.binCenters_OrderVsPeakAmp,PyrRisePeak_AftRun.binnedMeans_OrderVsPeakAmp,...
        PyrRisePeak_AftRun.binnedStd_OrderVsPeakAmp,PyrRisePeak_AftRun.binned_OrderVsPeakAmp,...
        'Neuron no. (PyrRise)','Peak amplitude (Hz)',pathAnal1,'PyrRise_BinnedPeakAmpVsOrderNo');
    
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun.amp',...
        PyrDownPeak_AftRun.lm_OrderVsPeakAmp,PyrDownPeak_AftRun.corrCoef_OrderVsPeakAmp,...
        'Neuron no. (PyrDown)','Peak amplitude (Hz)',pathAnal1,'PyrDown_PeakAmpVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownPeak_AftRun.amp',...
        PyrDownPeak_AftRun.binCenters_OrderVsPeakAmp,PyrDownPeak_AftRun.binnedMeans_OrderVsPeakAmp,...
        PyrDownPeak_AftRun.binnedStd_OrderVsPeakAmp,PyrDownPeak_AftRun.binned_OrderVsPeakAmp,...
        'Neuron no. (PyrDown)','Peak amplitude (Hz)',pathAnal1,'PyrDown_BinnedPeakAmpVsOrderNo');
    
    
    %% plot the trough time vs the neuron order 
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownTrough.time',...
        PyrDownTrough.lm_OrderVsTroughTime,PyrDownTrough.corrCoef_OrderVsTroughTime,...
        'Neuron no. (PyrDown)','Trough time (s)',pathAnal1,'PyrDown_TroughTimeVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownTrough.time',...
        PyrDownTrough.binCenters_OrderVsTroughTime,PyrDownTrough.binnedMeans_OrderVsTroughTime,...
        PyrDownTrough.binnedStd_OrderVsTroughTime,PyrDownTrough.binned_OrderVsTroughTime,...
        'Neuron no. (PyrDown)','Trough time (s)',pathAnal1,'PyrDown_BinnedTroughTimeVsOrderNo');
    
    %% plot the trough amp vs the neuron order 
    %PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownTrough.amp',...
        PyrDownTrough.lm_OrderVsTroughAmp,PyrDownTrough.corrCoef_OrderVsTroughAmp,...
        'Neuron no. (PyrDown)','Trough amplitude (Hz)',pathAnal1,'PyrDown_TroughAmpVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownTrough.amp',...
        PyrDownTrough.binCenters_OrderVsTroughAmp,PyrDownTrough.binnedMeans_OrderVsTroughAmp,...
        PyrDownTrough.binnedStd_OrderVsTroughAmp,PyrDownTrough.binned_OrderVsTroughAmp,...
        'Neuron no. (PyrDown)','Trough amplitude (Hz)',pathAnal1,'PyrDown_BinnedTroughAmpVsOrderNo');
    
    %% plot the time constant vs the neuron order 
    % PyrRise
    plotDataVsLinearFit((1:length(idxPyrRise))',PyrRisePeak_AftRun.tau',...
        PyrRisePeak_AftRun.lm_OrderVsTau,PyrRisePeak_AftRun.corrCoef_OrderVsTau,...
        'Neuron no. (PyrRise)','Time constant (s)',pathAnal1,'PyrRise_TauVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxMeanFRBef))',PyrRisePeak_AftRun.tau',...
        PyrRisePeak_AftRun.binCenters_OrderVsTau,PyrRisePeak_AftRun.binnedMeans_OrderVsTau,...
        PyrRisePeak_AftRun.binnedStd_OrderVsTau,PyrRisePeak_AftRun.binned_OrderVsTau,...
        'Neuron no. (PyrRise)','Time constant (s)',pathAnal1,'PyrRise_BinnedTauVsOrderNo');
           
    plotDataVsLinearFit(log10(PyrRisePeak_AftRun.meanFRBef(idxMeanFRBef)),PyrRisePeak_AftRun.tau(idxMeanFRBef),...
        PyrRisePeak_AftRun.lm_MeanFRBefVsTau,PyrRisePeak_AftRun.corrCoef_MeanFRBefVsTau,...
        'Mean FR befrun (logHz)(PyrRise)','Time constant (s)',pathAnal1,'PyrRise_TauVsMeanFRBef');
    
    displayBinnedCorrelation(log10(PyrRisePeak_AftRun.meanFRBef(idxMeanFRBef)'),PyrRisePeak_AftRun.tau(idxMeanFRBef)',...
        PyrRisePeak_AftRun.binCenters_MeanFRBefVsTau,PyrRisePeak_AftRun.binnedMeans_MeanFRBefVsTau,...
        PyrRisePeak_AftRun.binnedStd_MeanFRBefVsTau,PyrRisePeak_AftRun.binned_MeanFRBefVsTau,...
        'Mean FR befrun (Hz)(PyrRise)','Time constant (s)',pathAnal1,'PyrRise_BinnedTauVsMeanFRBef');
        
    %% plot the time constant vs the trough amp
    % PyrDown
    plotDataVsLinearFit((1:length(idxPyrDown))',PyrDownPeak_AftRun.tau',...
        PyrDownPeak_AftRun.lm_OrderVsTau,PyrDownPeak_AftRun.corrCoef_OrderVsTau,...
        'Neuron no. (PyrDown)','Time constant (s)',pathAnal1,'PyrDown_TauVsOrderNo');
    
    displayBinnedCorrelation((1:length(idxPyrDown))',PyrDownPeak_AftRun.amp',...
        PyrDownPeak_AftRun.binCenters_OrderVsTau,PyrDownPeak_AftRun.binnedMeans_OrderVsTau,...
        PyrDownPeak_AftRun.binnedStd_OrderVsTau,PyrDownPeak_AftRun.binned_OrderVsTau,...
        'Neuron no. (PyrDown)','Time constant (s)',pathAnal1,'PyrDown_BinnedTauVsOrderNo');
    
    plotDataVsLinearFit(log10(PyrDownTrough.amp(idxTmp)'),PyrDownPeak_AftRun.tau(idxTmp)',...
        PyrDownTrough.lm_AmpVsTau,PyrDownTrough.corrCoef_AmpVsTau,...
        'Trough amplitude (Hz)(PyrDown)','Time constant (s)',pathAnal1,'PyrDown_TauVsTroughAmp');
    
    displayBinnedCorrelation(log10(PyrDownTrough.amp(idxTmp)'),PyrDownPeak_AftRun.tau(idxTmp)',...
        PyrDownTrough.binCenters_AmpVsTau,PyrDownTrough.binnedMeans_AmpVsTau,...
        PyrDownTrough.binnedStd_AmpVsTau,PyrDownTrough.binned_AmpVsTau,...
        'Trough amplitude (Hz)(PyrDown)','Time constant (s)',pathAnal1,'PyrDown_BinnedTauVsTroughAmp');
    
        
    %% plot the peak time vs the neuron order 
    % PyrRise        'Neuron no. (PyrDown)','Time constant (s)',pathAnal1,'PyrDown_TauVsOrderNo');
    
    %% plot the averaged FR profile for comparing neurons with high FR ratio, mid FR ratio and low FR ratio
    % PyrRise
    numNeurons = 1:floor(length(idxPyrRise)/3):length(idxPyrRise);
    avgProfileTmp = InitAll.avgFRProfile(idxPyrRise,:);
    comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
        avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
        avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
        'Time from runonset(s)','FR (Hz)',pathAnal1,'PyrRise_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatio');
    avgProfileHighR =  mean(avgProfileTmp(1:numNeurons(2),:));
    avgProfileMidR =  mean(avgProfileTmp(numNeurons(2)+1:numNeurons(3),:));
    avgProfileLowR =  mean(avgProfileTmp(numNeurons(3)+1:numNeurons(4),:));
    [~,idxPeakHighR] = max(avgProfileHighR);
    [~,idxPeakMidR] = max(avgProfileMidR);
    [~,idxPeakLowR] = max(avgProfileLowR);
    tPeakTimeHighR = modPyr1AL.timeStepRun(idxPeakHighR);
    tPeakTimeMidR = modPyr1AL.timeStepRun(idxPeakMidR);
    tPeakTimeLowR = modPyr1AL.timeStepRun(idxPeakLowR);
    PyrRisePeak_AftRun.pTPeakTimeHighRVsLowR = ranksum(PyrRisePeak_AftRun.time(1:numNeurons(2)),PyrRisePeak_AftRun.time(numNeurons(3)+1:numNeurons(4)));
   
    % PyrDown
    numNeurons = 1:floor(length(idxPyrDown)/3):length(idxPyrDown);
    if(length(numNeurons) == 3)
        numNeurons(4) = length(idxPyrDown);
    end
    avgProfileTmp = InitAll.avgFRProfile(idxPyrDown,:);
    comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
        avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
        avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 3.5],...
        'Time from runonset(s)','FR (Hz)',pathAnal1,'PyrDown_cmpAvgFRProfiles_DiffFR0to1vsBefRunRatio');
    
    idxZeroTime = find(modPyr1AL.timeStepRun == 0);
    avgProfileTmp = InitAll.avgFRProfileNorm(idxPyrDown,:);
    avgProfileTmpMean1 = mean(avgProfileTmp(1:numNeurons(2),:));
    avgProfileTmpMean1 = avgProfileTmpMean1/avgProfileTmpMean1(idxZeroTime);
    avgProfileTmpMean2 = mean(avgProfileTmp(numNeurons(2)+1:numNeurons(3),:));
    avgProfileTmpMean2 = avgProfileTmpMean2/avgProfileTmpMean2(idxZeroTime);
    avgProfileTmpMean3 = mean(avgProfileTmp(numNeurons(3)+1:numNeurons(4),:));
    avgProfileTmpMean3 = avgProfileTmpMean3/avgProfileTmpMean3(idxZeroTime);
    
    plot3TimeTracesMean(avgProfileTmpMean1,avgProfileTmpMean2,avgProfileTmpMean3,modPyr1AL.timeStepRun,[-1,4],[0 1.2],...
        'Time from runonset(s)','Norm FR',pathAnal1,'PyrDown_cmpAvgFRProfilesNormToRunOnset_DiffFR0to1vsBefRunRatio')
    
    comp3TimeSequences(avgProfileTmp(1:numNeurons(2),:),...
        avgProfileTmp(numNeurons(2)+1:numNeurons(3),:),...
        avgProfileTmp(numNeurons(3)+1:numNeurons(4),:),modPyr1AL.timeStepRun,[-1,4],[0 1],...
        'Time from runonset(s)','Norm FR',pathAnal1,'PyrDown_cmpAvgFRProfilesNorm_DiffFR0to1vsBefRunRatio');

    save([pathAnal1 'avgFRProfile_PeakAndTau.mat'],'PyrRisePeak_AftRun','-append');
    
    close all;
end






