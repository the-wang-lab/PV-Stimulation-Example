function modPyr2 = accumPyr3NoStim2ndStimCtrlFRChange(paths,filenames,mazeSess,...
            modPyr1SigAL,task,sampleFq,anmNoInact,anmNoAct)
        
    numRec = size(paths,1);
    modPyr2 = struct(...
                  'task',[],...
                  'indRec',[],...
                  'indNeu',[],...
                  'actOrInact',[],...
                  'pulseMeth',[],...
                  ...
                  'meanFR0to1stNonStimCtrl',[],...
                  'meanFR0to1stStimCtrl',[],...
                  'meanFR0to1stStim',[],...
                  ...
                  'meanFR2to3sNonStimCtrl',[],...
                  'meanFR2to3sStimCtrl',[],...
                  'meanFR2to3sStim',[],...
                  ...
                  'meanFRBefRunNonStimCtrl',[],...
                  'meanFRBefRunStimCtrl',[],...
                  'meanFRBefRunStim',[],...
                  ...
                  'meanFRAftRunNonStimCtrl',[],...
                  'meanFRAftRunStimCtrl',[],...
                  'meanFRAftRunStim',[],...
                  ...
                  'pRSMeanFRBefRunStimNonStim',[],... % compare the FR between the stim and non-stim trials before run
                  'pRSMeanFRAftRunStimNonStim',[],... % compare the FR between the stim and non-stim trials after run
                  'pRSMeanFRBefRunStimStimCtrl',[],... % compare the FR between the stim and stim ctrl trials between before run
                  'pRSMeanFRAftRunStimStimCtrl',[],... % compare the FR between the stim and stim ctrl trials between after run
                  'pRSMeanFR0to1stStimNonStim',[],... % compare the FR between the stim and non-stim trials between 0to1s
                  'pRSMeanFR2to3sStimNonStim',[],... % compare the FR between the stim and non-stim trials between 2to3s
                  'pRSMeanFR0to1stStimStimCtrl',[],... % compare the FR between the stim and stim ctrl trials between 0to1s
                  'pRSMeanFR2to3sStimStimCtrl',[]);  % compare the FR between the stim and stim ctrl trials between 2to3s

    for i = 1:numRec
        disp(['Recording ' num2str(i) ': ' filenames(i,:)])
        actOrInact = 0;
        anmNo = str2num(filenames(i,2:4));
        % does the recording belong to inactivation
        indTmp = find(anmNoInact == anmNo);
        if(~isempty(indTmp))
            actOrInact = 1;
        end
        % does the recording belong to activation
        indTmp1 = find(anmNoAct == anmNo);
        if(~isempty(indTmp1))
            actOrInact = 2;
        end
        % continue if the recording is not an activation or inactivation
        % recording
        if(isempty(indTmp) && isempty(indTmp1))
            continue;
        end
        
        fullPath = [paths(i,:) filenames(i,:) '_PeakFRAligned_msess' num2str(mazeSess(i)) '_Run1.mat'];    
        if(exist(fullPath) == 0)
            disp('The _PeakFRAligned file does not exist');
            return;
        end
        load(fullPath,'pulseMeth','pFRStimStruct');
        
        fileNameConv = [filenames(i,:) '_convSpikesAligned_msess' num2str(mazeSess(i)) '_BefRun0.mat'];
        fullPath = [paths(i,:) fileNameConv];
        if(exist(fullPath) == 0)
            disp(['The convSpikesAligned file does not exist. Please call ',...
                    'function "ConvSpikeTrain_AlignedRunOnset" first.']);
            return;
        end
        load(fullPath,'timeStepRun','filteredSpikeArrayRunOnSet');
        
        fileNameFWStim = [filenames(i,:) '_FieldSpCorrAlignedStim_Run' num2str(mazeSess(i)) ...
                        '_Run1.mat'];
        fullPath = [paths(i,:) fileNameFWStim];
        if(exist(fullPath) == 0)
            disp(['The field detection file does not exist. Please call ',...
                    'function "FieldDetectionAlignedStim" first.']);
            return;
        end
        load(fullPath,'paramF'); 
        
        indNeu = modPyr1SigAL.indRec == i;
        indNeu1 = modPyr1SigAL.indNeu(indNeu);
        indFRBefRun = find(timeStepRun/sampleFq >= -1.5 & timeStepRun/sampleFq < -0.5);  
        indFRAftRun = find(timeStepRun/sampleFq >= 0.5 & timeStepRun/sampleFq < 1.5);  
        indFR0to1st = find(timeStepRun/sampleFq >= 0 & timeStepRun/sampleFq < 1);  
        indFR2to3s = find(timeStepRun/sampleFq >= 2 & timeStepRun/sampleFq < 3); 
        
        for n = 1:length(pulseMeth)
            disp(['Pulse method = ' num2str(pulseMeth(n))]);
            if(pulseMeth(n) ~= 2 && pulseMeth(n) ~= 3 && pulseMeth(n) ~= 4) % check the pulse method number
                disp(['Wrong pulse method = ' num2str(pulseMeth(n)), ' continue ...']);
                continue;
            end
            
            if(isempty(modPyr1SigAL.trialNoCtrlGood{i})) % follow the criteria in pyrInitSig (PyrInitPeakAllRecSigNoStim2ndStimCtrl)
                disp(['Recording ' filenames(i,:) ' does not have neough good ctrl trials']);
                continue;
            end

            if(length(pFRStimStruct{n}.indLapList) < paramF.minNumTr) % follow accumPyr3NoStim2ndStimCtrl (PyrInitPeakAllStimPVRecSigNonStim2ndStimCtrlTr)
                disp([filenames(i,:) ' only has ' num2str(length(modPyr1SigAL.trialNoStimGood{i}{n})) ...
                    ' stim trials for pulse method' num2str(pulseMeth(n)) '.']);
                continue;
            end
            
            modPyr2.task = [modPyr2.task task*ones(1,sum(indNeu))];
            modPyr2.indRec = [modPyr2.indRec i*ones(1,sum(indNeu))];
            modPyr2.indNeu = [modPyr2.indNeu indNeu1];
            modPyr2.actOrInact = [modPyr2.actOrInact actOrInact*ones(1,sum(indNeu))];
            modPyr2.pulseMeth = [modPyr2.pulseMeth pulseMeth(n)*ones(1,sum(indNeu))];
               
            for m = 1:length(indNeu1)
                
                filteredSpikeArrayNoStimTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNoCtrlGood{i},:);                
                filteredSpikeArrayStimCtrlTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNo2ndStimCtrl{i},:);                
                filteredSpikeArrayStimTmp = filteredSpikeArrayRunOnSet{indNeu1(m)}(modPyr1SigAL.trialNoStimGood{i}{n},:);
                
                modPyr2.meanFRBefRunNonStimCtrl = [modPyr2.meanFRBefRunNonStimCtrl...
                    mean(mean(filteredSpikeArrayNoStimTmp(:,indFRBefRun),2))];
                modPyr2.meanFRBefRunStimCtrl = [modPyr2.meanFRBefRunStimCtrl...
                    mean(mean(filteredSpikeArrayStimCtrlTmp(:,indFRBefRun),2))];
                modPyr2.meanFRBefRunStim = [modPyr2.meanFRBefRunStim...
                    mean(mean(filteredSpikeArrayStimTmp(:,indFRBefRun),2))];
                
                modPyr2.meanFRAftRunNonStimCtrl = [modPyr2.meanFRAftRunNonStimCtrl...
                    mean(mean(filteredSpikeArrayNoStimTmp(:,indFRAftRun),2))];
                modPyr2.meanFRAftRunStimCtrl = [modPyr2.meanFRAftRunStimCtrl...
                    mean(mean(filteredSpikeArrayStimCtrlTmp(:,indFRAftRun),2))];
                modPyr2.meanFRAftRunStim = [modPyr2.meanFRAftRunStim...
                    mean(mean(filteredSpikeArrayStimTmp(:,indFRAftRun),2))];
                
                modPyr2.meanFR0to1stNonStimCtrl = [modPyr2.meanFR0to1stNonStimCtrl...
                    mean(mean(filteredSpikeArrayNoStimTmp(:,indFR0to1st),2))];
                modPyr2.meanFR0to1stStimCtrl = [modPyr2.meanFR0to1stStimCtrl...
                    mean(mean(filteredSpikeArrayStimCtrlTmp(:,indFR0to1st),2))];
                modPyr2.meanFR0to1stStim = [modPyr2.meanFR0to1stStim...
                    mean(mean(filteredSpikeArrayStimTmp(:,indFR0to1st),2))];
                
                modPyr2.meanFR2to3sNonStimCtrl = [modPyr2.meanFR2to3sNonStimCtrl...
                    mean(mean(filteredSpikeArrayNoStimTmp(:,indFR2to3s),2))];
                modPyr2.meanFR2to3sStimCtrl = [modPyr2.meanFR2to3sStimCtrl...
                    mean(mean(filteredSpikeArrayStimCtrlTmp(:,indFR2to3s),2))];
                modPyr2.meanFR2to3sStim = [modPyr2.meanFR2to3sStim...
                    mean(mean(filteredSpikeArrayStimTmp(:,indFR2to3s),2))];
                
                pRSMeanFRBefRunStimNonStim = ranksum(mean(filteredSpikeArrayNoStimTmp(:,indFRBefRun),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFRBefRun),2));
                pRSMeanFRBefRunStimStimCtrl = ranksum(mean(filteredSpikeArrayStimCtrlTmp(:,indFRBefRun),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFRBefRun),2));
               
                pRSMeanFRAftRunStimNonStim = ranksum(mean(filteredSpikeArrayNoStimTmp(:,indFRAftRun),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFRAftRun),2));
                pRSMeanFRAftRunStimStimCtrl = ranksum(mean(filteredSpikeArrayStimCtrlTmp(:,indFRAftRun),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFRAftRun),2));
                               
                pRSMeanFR0to1stStimNonStim = ranksum(mean(filteredSpikeArrayNoStimTmp(:,indFR0to1st),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFR0to1st),2));
                pRSMeanFR0to1stStimStimCtrl = ranksum(mean(filteredSpikeArrayStimCtrlTmp(:,indFR0to1st),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFR0to1st),2));
               
                pRSMeanFR2to3sStimNonStim = ranksum(mean(filteredSpikeArrayNoStimTmp(:,indFR2to3s),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFR2to3s),2));
                pRSMeanFR2to3sStimStimCtrl = ranksum(mean(filteredSpikeArrayStimCtrlTmp(:,indFR2to3s),2),...
                   mean(filteredSpikeArrayStimTmp(:,indFR2to3s),2));
                
                modPyr2.pRSMeanFRBefRunStimNonStim = [modPyr2.pRSMeanFRBefRunStimNonStim pRSMeanFRBefRunStimNonStim];
                modPyr2.pRSMeanFRBefRunStimStimCtrl = [modPyr2.pRSMeanFRBefRunStimStimCtrl pRSMeanFRBefRunStimStimCtrl];
                
                modPyr2.pRSMeanFRAftRunStimNonStim = [modPyr2.pRSMeanFRAftRunStimNonStim pRSMeanFRAftRunStimNonStim];
                modPyr2.pRSMeanFRAftRunStimStimCtrl = [modPyr2.pRSMeanFRAftRunStimStimCtrl pRSMeanFRAftRunStimStimCtrl];
                
                modPyr2.pRSMeanFR0to1stStimNonStim = [modPyr2.pRSMeanFR0to1stStimNonStim pRSMeanFR0to1stStimNonStim];
                modPyr2.pRSMeanFR0to1stStimStimCtrl = [modPyr2.pRSMeanFR0to1stStimStimCtrl pRSMeanFR0to1stStimStimCtrl];
                
                modPyr2.pRSMeanFR2to3sStimNonStim = [modPyr2.pRSMeanFR2to3sStimNonStim pRSMeanFR2to3sStimNonStim];
                modPyr2.pRSMeanFR2to3sStimStimCtrl = [modPyr2.pRSMeanFR2to3sStimStimCtrl pRSMeanFR2to3sStimStimCtrl];
            end
        end
    end
    modPyr2.timeStepRun = timeStepRun/sampleFq;
    
   