function modPyr = accumPyrNeurons1(paths,filenames,mazeSess,minFR,maxFR,task,methodTheta,onlyRun)
%% accumulate information about individual neurons'
%% theta modulation, burstness and whether there is a field from one type of task
%% this function is called by PyrModAllRec.m

    numRec = size(paths,1);
    modPyr = struct('task',[],... % no cue - 1, AL - 2, PL - 3
                              'indRec',[],... % recording index
                              'indNeu',[],... % neuron indices
                              'thetaFreqHMean',[],... % theta frequency hilbert
                              ...
                              'thetaMod',[],... % theta modulation
                              'trough',[],... % % ACG first trough
                              'peak',[],... % % ACG first peak
                              'thetaModInd',[],... % theta modulation index
                              'troughT3',[],... % % time of ACG first trough
                              'peakT3',[],... % % time of ACG first peak
                              'thetaModInd3',[],... % theta modulation index (method 3)
                              'thetaAsym3',[],... % theta asymmetry (method 3)
                              'thetaModFreq3',[],... % theta modulation frequency (method 3)
                              ...
                              'mFR',[],... % mean firing rate
                              'meanInstFR',[], ... % mean instantaneous firing rate
                              ...
                              'nNeuWithField',[],... % number of pyr neurons with fields in the recording
                              'nNeuWithFieldAll',[],... % number of neurons with fields in the recording
                              'isNeuWithField',[],... % does the neuron have field(s)
                              'fieldWidth',[],... % field width
                              'indStartField',[],... % start index of a field
                              'indPeakField',[],... % peak index of a field
                              ...
                              'fractBurst',[],... % fraction of spikes which belongs to a burst over all the spikes across all the trials
                              'burstMeanDire',[],... % the mean phase direction
                              'burstMeanResultantLen',[],... % the mean resultant length of the mean phase direction
                              'nonBurstMeanDire',[],... % the mean phase direction of non-burst spikes
                              'nonBurstMeanResultantLen',[],... % the mean resultant length of the mean phase direction of non-burst spikes
                              'burstMeanDireStart',[],... % the mean phase direction of the first spike of a burst
                              'burstMeanResultantLenStart',[],... % the mean resultant length of the mean phase direction of the first spike of a burst
                              'numSpPerBurstMean',[],... % mean number of spikes per burst
                              ...  
                              'trialLenMean',[],... % mean trial length
                              'trackLen',[],... % track length in mm
                              'minPhaseFilH',[],... % the phase which fires the least number of spikes (hilbert)
                              'maxPhaseFilH',[],... % the phase which fires the largest number of spikes (hilbert)
                              'thetaModHistH',[],... % theta modulation calculated based on theta phase histogram (hilbert)
                              'phaseMeanDireH',[],... % the mean phase direction (hilbert)
                              'phaseMeanResultantLenH',[],... % the mean resultant length of the mean phase direction (hilbert)
                              ...
                              'minPhaseFil',[],... % the phase which fires the least number of spikes 
                              'maxPhaseFil',[],... % the phase which fires the largest number of spikes 
                              'thetaModHist',[],... % theta modulation calculated based on theta phase histogram
                              'phaseMeanDire',[],... % the mean phase direction
                              'phaseMeanResultantLen',[]); % the mean resultant length of the mean phase direction
                          
    for i = 1:numRec
        disp(filenames(i,:));
        fullPath = [paths(i,:) filenames(i,:) '.mat'];
        if(exist(fullPath) == 0)
            disp('File does not exist.');
            return;
        end
        load(fullPath,'cluList'); 
        
        fileNameInfo = [filenames(i,:) '_Info.mat'];
        fullPath = [paths(i,:) fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr','beh'); 
                
        fileNameFW = [filenames(i,:) '_FieldSpCorr_GoodTr_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameFW];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetection_GoodTr" first.']);
            return;
        end
        load(fullPath,'fieldSpCorrSessGoodTr','paramF'); 
        if(mazeSess(i) == 0)
            mazeSessTmp = 1;
        else
            mazeSessTmp = mazeSess(i);
        end
        fieldSpCorrSessGoodTr = fieldSpCorrSessGoodTr{mazeSessTmp};
        
        fullPathFR = [filenames(i,:) '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFR = mFRStructSess{mazeSess(i)};
        else
            mFR = mFRStruct;
        end
        
        fileNamePeakFR = [filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) ...
                        '_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNamePeakFR];
        if(exist(fullPath) == 0)
            disp(['The peak firing rate file does not exist. Please call ',...
                    'function "PeakFiringRate_Aligned" first.']);
            return;
        end
        load(fullPath,'pFRNonStimGoodStruct');
        
        fileNameThetaMod = [filenames(i,:) '_ThetaMod_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaMod];
        if(exist(fullPath) == 0)
            disp('_ThetaMod file does not exist.');
            return;
        end
        load(fullPath,'thetaModSess');
        if(length(beh.mazeSessAll) == 1)
           thetaModSessTmp = thetaModSess{1};
        else
           thetaModSessTmp = thetaModSess{mazeSess(i)}; 
        end
        
        if(methodTheta == 0)
            th = 'H';
        else
            th = 'L';
        end
        fileNameBurst = [filenames(i,:) '_burstAll_TH' th '_Run' num2str(onlyRun) ...
                     '.mat'];
        fullPath = [paths(i,:) fileNameBurst];
        if(exist(fullPath) == 0)
            disp('_bustAll file does not exist.');
            return;
        end
        load(fullPath,'burstIsiPerNeuron','burstIsiPerNeuronSess');
        if(length(beh.mazeSessAll) > 1)
            burstIsi = burstIsiPerNeuronSess{mazeSess(i)};
        else
            burstIsi = burstIsiPerNeuron;
        end
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseL_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseL file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseStruct','spikeThetaPhaseStructSess');
        if(length(beh.mazeSessAll) > 1)
            spikeThetaPhase = spikeThetaPhaseStructSess{mazeSess(i)};
        else
            spikeThetaPhase = spikeThetaPhaseStruct;
        end
        
        fileNameThetaPhase = [filenames(i,:) '_ThetaPhaseH_Run' num2str(onlyRun) '.mat'];
        fullPath = [paths(i,:) fileNameThetaPhase];
        if(exist(fullPath) == 0)
            disp('_ThetaPhaseH file does not exist.');
            return;
        end
        load(fullPath,'spikeThetaPhaseStruct','spikeThetaPhaseStructSess');
        if(length(beh.mazeSessAll) > 1)
            spikeThetaPhaseH = spikeThetaPhaseStructSess{mazeSess(i)};
        else
            spikeThetaPhaseH = spikeThetaPhaseStruct;
        end
        trialLenMean = mean(beh.lenTrials(spikeThetaPhaseH.indLapList));
        
        %% theta modulation
        indNeu = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
        modPyr.task = [modPyr.task task*ones(1,sum(indNeu))];
        modPyr.indRec = [modPyr.indRec i*ones(1,sum(indNeu))];
        modPyr.indNeu = [modPyr.indNeu find(indNeu == 1)]; 
        modPyr.trialLenMean = [modPyr.trialLenMean trialLenMean*ones(1,sum(indNeu))];
        modPyr.trackLen = [modPyr.trackLen unique(beh.trackLen(beh.mazeSess == mazeSess(i)))*ones(1,sum(indNeu))];
        modPyr.thetaFreqHMean = [modPyr.thetaFreqHMean mean(beh.thetaFreqHMean(spikeThetaPhaseH.indLapList))*ones(1,sum(indNeu))];
                
        modPyr.thetaMod = [modPyr.thetaMod thetaModSessTmp.thetaMod(indNeu)];
        modPyr.trough = [modPyr.trough thetaModSessTmp.trough(indNeu)];
        modPyr.peak = [modPyr.peak thetaModSessTmp.peak(indNeu)];
        modPyr.thetaModInd = [modPyr.thetaModInd thetaModSessTmp.thetaModInd(indNeu)];
        modPyr.peakT3 = [modPyr.peakT3 thetaModSessTmp.peakT3(indNeu)];
        modPyr.troughT3 = [modPyr.troughT3 thetaModSessTmp.troughT3(indNeu)];
        modPyr.thetaAsym3 = [modPyr.thetaAsym3 ...
            (abs(thetaModSessTmp.peakT3(indNeu))-abs(thetaModSessTmp.troughT3(indNeu)))./...
            (abs(thetaModSessTmp.peakT3(indNeu)))];
        modPyr.thetaModFreq3 = [modPyr.thetaModFreq3 ...
            1000./(abs(thetaModSessTmp.peakT3(indNeu)))];
        modPyr.thetaModInd3 = [modPyr.thetaModInd3 thetaModSessTmp.thetaModInd3(indNeu)];
        modPyr.mFR = [modPyr.mFR mFR.mFR(indNeu)];
        
        %% neurons with fields
        nNeurons = length(cluList.firingRate);
        nFieldArr = zeros(1,sum(indNeu));
        indNeuWithField = zeros(1,nNeurons);
        fieldWidth = zeros(1,nNeurons);
        indStartField = zeros(1,nNeurons);
        indPeakField = zeros(1,nNeurons);
        if(length(pFRNonStimGoodStruct.indLapList) > paramF.minNumTr) % more than 15 trirals
            if(~isempty(fieldSpCorrSessGoodTr))
                [indNeuF,ia] = unique(fieldSpCorrSessGoodTr.indNeuron); 
                indNeuWithField(indNeuF) = 1;
                fieldWidth(indNeuF) = fieldSpCorrSessGoodTr.FW(ia);
                indStartField(indNeuF) = fieldSpCorrSessGoodTr.indStartField(ia);
                indPeakField(indNeuF) = fieldSpCorrSessGoodTr.indPeakField(ia);
                numField = length(indNeuF);
                if(numField > 0)
                    nFieldArr = numField * ones(1,sum(indNeu));
                end
            end
        end
        modPyr.nNeuWithFieldAll = [modPyr.nNeuWithFieldAll nFieldArr];
        modPyr.nNeuWithField = [modPyr.nNeuWithField sum(indNeuWithField(indNeu))*ones(1,sum(indNeu))]; %% added by Yingxue on 3/27/2022
        modPyr.isNeuWithField = [modPyr.isNeuWithField indNeuWithField(indNeu)]; % the total number of neurons with field for each recording here might not be the same as in nNeuWithField, because of the subselection of neurons
        modPyr.fieldWidth = [modPyr.fieldWidth fieldWidth(indNeu)];
        modPyr.indStartField = [modPyr.indStartField indStartField(indNeu)];
        modPyr.indPeakField = [modPyr.indPeakField indPeakField(indNeu)];
        modPyr.meanInstFR = [modPyr.meanInstFR pFRNonStimGoodStruct.meanInstFR(indNeu)];
        
        %% bursting properties
        numSpPerBurst = zeros(1,nNeurons);
        for m = 1:nNeurons
            if(~isempty(burstIsi.numSpPerBurst{m}))
                numSpPerBurst(m) = mean(burstIsi.numSpPerBurst{m});
            end
        end
        modPyr.fractBurst = [modPyr.fractBurst burstIsi.fractBurst(indNeu)];
        modPyr.numSpPerBurstMean = [modPyr.numSpPerBurstMean numSpPerBurst(indNeu)]; 
        modPyr.burstMeanDire = [modPyr.burstMeanDire burstIsi.meanDire(indNeu)];        
        modPyr.burstMeanResultantLen = [modPyr.burstMeanResultantLen burstIsi.meanResultantLen(indNeu)];
        
        modPyr.nonBurstMeanDire = [modPyr.nonBurstMeanDire burstIsi.meanDireNonBurst(indNeu)];
        modPyr.nonBurstMeanResultantLen = [modPyr.nonBurstMeanResultantLen burstIsi.meanResultantLenNonBurst(indNeu)];
        
        modPyr.burstMeanDireStart = [modPyr.burstMeanDireStart burstIsi.meanDireStart(indNeu)];        
        modPyr.burstMeanResultantLenStart = [modPyr.burstMeanResultantLenStart burstIsi.meanResultantLenStart(indNeu)];
        
        modPyr.minPhaseFil = [modPyr.minPhaseFil spikeThetaPhase.minPhaseFilArr(indNeu)];
        modPyr.maxPhaseFil = [modPyr.maxPhaseFil spikeThetaPhase.maxPhaseFilArr(indNeu)];
        modPyr.phaseMeanDire = [modPyr.phaseMeanDire spikeThetaPhase.meanDire(indNeu)];
        modPyr.phaseMeanResultantLen = [modPyr.phaseMeanResultantLen spikeThetaPhase.meanResultantLen(indNeu)];
        modPyr.thetaModHist = [modPyr.thetaModHist spikeThetaPhase.thetaMod(indNeu)]; 
        
        modPyr.minPhaseFilH = [modPyr.minPhaseFilH spikeThetaPhaseH.minPhaseFilArr(indNeu)];
        modPyr.maxPhaseFilH = [modPyr.maxPhaseFilH spikeThetaPhaseH.maxPhaseFilArr(indNeu)];
        modPyr.phaseMeanDireH = [modPyr.phaseMeanDireH spikeThetaPhaseH.meanDire(indNeu)];
        modPyr.phaseMeanResultantLenH = [modPyr.phaseMeanResultantLenH spikeThetaPhaseH.meanResultantLen(indNeu)];
        modPyr.thetaModHistH = [modPyr.thetaModHistH spikeThetaPhaseH.thetaMod(indNeu)]; 
    end
    
    indDire = find(modPyr.burstMeanDire < 0);
    modPyr.burstMeanDire(indDire) = modPyr.burstMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.nonBurstMeanDire < 0);
    modPyr.nonBurstMeanDire(indDire) = modPyr.nonBurstMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.burstMeanDireStart < 0);
    modPyr.burstMeanDireStart(indDire) = modPyr.burstMeanDireStart(indDire) + 2*pi;
    
    indDire = find(modPyr.phaseMeanDire < 0);
    modPyr.phaseMeanDire(indDire) = modPyr.phaseMeanDire(indDire) + 2*pi;
    
    indDire = find(modPyr.phaseMeanDireH < 0);
    modPyr.phaseMeanDireH(indDire) = modPyr.phaseMeanDireH(indDire) + 2*pi;

end

