function accumRecDataRunStatMusc()
    RecordingListNT;
    
    fullPath = [folderPath 'allRecData.mat'];
    if(~exist(fullPath,'file'))
        disp([fullPath ' does not exist.']);
        return;
    end
    load(fullPath,'recDataRunPre','recDataRunManip','recDataRunPost');
    
    %% Mean
    disp('Calculate mean -- Run');
    meanRecDataRunPre = meanRun(recDataRunPre);
    meanRecDataRunManip = meanRun(recDataRunManip);
    meanRecDataRunPost = meanRun(recDataRunPost);
    
    %% SEM
    disp('Calculate sem -- Run');
    semRecDataRunPre = semRun(recDataRunPre);
    semRecDataRunManip = semRun(recDataRunManip);
    semRecDataRunPost = semRun(recDataRunPost);
    
    %% statistics for each pair using ranksum
    disp('Calculate statistics using ranksum -- Run');
    rankRecDataRunPrePost = statRunRankSum(recDataRunPre,recDataRunPost);
    rankRecDataRunPreM = statRunRankSum(recDataRunPre,recDataRunManip);
    rankRecDataRunPostM = statRunRankSum(recDataRunPost,recDataRunManip);
        
    %% statistics using one-way anova1
    disp('Calculate statistics using one-way anova1 -- Run');
    anovaRecDataRun = statRunAnova1(recDataRunPre,recDataRunManip,recDataRunPost);
    
%     %% correlation between time after injection and other behavioral parameters
%     disp('Calculate the correlation between time after injection and other behavioral parameters -- Run');
%     corrRecDataRunRecStartT = corrRun(recDataRunManip,'tDiffInjStart');
%     corrRecDataRunPercReward = corrRun(recDataRunManip,'percRewarded');
%     corrRecDataRunRecEndT = corrRun(recDataRunManip,'tDiffInjEnd');
%     
    fullPath = [folderPath 'allRecDataStats.mat'];
    save(fullPath,'meanRecDataRunPre','meanRecDataRunManip','meanRecDataRunPost',...
        'semRecDataRunPre','semRecDataRunManip','semRecDataRunPost',...
        'rankRecDataRunPrePost','rankRecDataRunPreM','rankRecDataRunPostM',...
        'anovaRecDataRun');
%     save(fullPath,'corrRecDataRunRecStartT','corrRecDataRunPercReward',...
%         'corrRecDataRunRecEndT','-append');
        
end

function meanRecDataRun = meanRun(recData)
    nCond = length(recData);
    for i = 1:nCond
        ind = ~isnan(recData{i}.numSamplesMean);
        meanRecDataRun{i}.numSamples = mean(recData{i}.numSamplesMean(ind));
        meanRecDataRun{i}.maxSpeed = mean(recData{i}.maxSpeedMean(ind));
        meanRecDataRun{i}.meanSpeed = mean(recData{i}.meanSpeedMean(ind));
        meanRecDataRun{i}.maxRunLenT = mean(recData{i}.maxRunLenTMean(ind));
        meanRecDataRun{i}.totRunLenT = mean(recData{i}.totRunLenTMean(ind));
        meanRecDataRun{i}.numRun = mean(recData{i}.numRunMean(ind));
        meanRecDataRun{i}.maxAcc = mean(recData{i}.maxAccMean(ind));
        meanRecDataRun{i}.meanAcc = mean(recData{i}.meanAccMean(ind));
        meanRecDataRun{i}.totStopLenT = mean(recData{i}.totStopLenTMean(ind));
        meanRecDataRun{i}.startCueToRun = mean(recData{i}.startCueToRunMean(ind));
        meanRecDataRun{i}.numLicksBefRew = mean(recData{i}.numLicksBefRewMean(ind));
        meanRecDataRun{i}.numLicksRew = mean(recData{i}.numLicksRewMean(ind));
        ind1 = ~isnan(recData{i}.med1stFiveLickDistMean);
        meanRecDataRun{i}.med1stFiveLickDist = mean(recData{i}.med1stFiveLickDistMean(ind1));
        ind1 = ~isnan(recData{i}.medLickDistMean);
        meanRecDataRun{i}.medLickDist = mean(recData{i}.medLickDistMean(ind1));
        ind1 = ~isnan(recData{i}.med1stFiveLickDistBefRewMean);
        meanRecDataRun{i}.med1stFiveLickDistBefRew = mean(recData{i}.med1stFiveLickDistBefRewMean(ind1));
        ind1 = ~isnan(recData{i}.medLickDistBefRewMean);
        meanRecDataRun{i}.medLickDistBefRew = mean(recData{i}.medLickDistBefRewMean(ind1));
        meanRecDataRun{i}.percRewarded = mean(recData{i}.percRewarded(ind));
        meanRecDataRun{i}.percNonStop = mean(recData{i}.percNonStop(ind));
        ind1 = ~isnan(recData{i}.pumpLfpIndMean);
        meanRecDataRun{i}.pumpLfpInd = mean(recData{i}.pumpLfpIndMean(ind1));
        meanRecDataRun{i}.pumpMM = mean(recData{i}.pumpMMMean(ind1)); 
        meanRecDataRun{i}.speedProfile = mean(recData{i}.speedProfile);
        meanRecDataRun{i}.lickProfile = mean(recData{i}.lickProfile);
    end
end

function semRecDataRun = semRun(recData)
    nCond = length(recData);
    for i = 1:nCond
        ind = ~isnan(recData{i}.numSamplesMean);
        nInd = sqrt(sum(ind));
        semRecDataRun{i}.numSamples = std(recData{i}.numSamplesMean(ind))/nInd;
        semRecDataRun{i}.maxSpeed = std(recData{i}.maxSpeedMean(ind))/nInd;
        semRecDataRun{i}.meanSpeed = std(recData{i}.meanSpeedMean(ind))/nInd;
        semRecDataRun{i}.maxRunLenT = std(recData{i}.maxRunLenTMean(ind))/nInd;
        semRecDataRun{i}.totRunLenT = std(recData{i}.totRunLenTMean(ind))/nInd;
        semRecDataRun{i}.numRun = std(recData{i}.numRunMean(ind))/nInd;
        semRecDataRun{i}.maxAcc = std(recData{i}.maxAccMean(ind))/nInd;
        semRecDataRun{i}.meanAcc = std(recData{i}.meanAccMean(ind))/nInd;
        semRecDataRun{i}.totStopLenT = std(recData{i}.totStopLenTMean(ind))/nInd;
        semRecDataRun{i}.startCueToRun = std(recData{i}.startCueToRunMean(ind))/nInd;
        semRecDataRun{i}.numLicksBefRew = std(recData{i}.numLicksBefRewMean(ind))/nInd;
        semRecDataRun{i}.numLicksRew = std(recData{i}.numLicksRewMean(ind))/nInd;
        ind1 = ~isnan(recData{i}.med1stFiveLickDistMean);
        semRecDataRun{i}.med1stFiveLickDist = std(recData{i}.med1stFiveLickDistMean(ind1))/sqrt(sum(ind1));
        ind1 = ~isnan(recData{i}.medLickDistMean);
        semRecDataRun{i}.medLickDist = std(recData{i}.medLickDistMean(ind1))/sqrt(sum(ind1));
        ind1 = ~isnan(recData{i}.med1stFiveLickDistBefRewMean);
        semRecDataRun{i}.med1stFiveLickDistBefRew = std(recData{i}.med1stFiveLickDistBefRewMean(ind1))/sqrt(sum(ind1));
        ind1 = ~isnan(recData{i}.medLickDistBefRewMean);
        semRecDataRun{i}.medLickDistBefRew = std(recData{i}.medLickDistBefRewMean(ind1))/sqrt(sum(ind1));
        semRecDataRun{i}.percRewarded = std(recData{i}.percRewarded(ind))/nInd;
        semRecDataRun{i}.percNonStop = std(recData{i}.percNonStop(ind))/nInd;
        ind1 = ~isnan(recData{i}.pumpLfpIndMean);
        semRecDataRun{i}.pumpLfpInd = std(recData{i}.pumpLfpIndMean(ind1))/sqrt(sum(ind1));
        semRecDataRun{i}.pumpMM = std(recData{i}.pumpMMMean(ind1))/sqrt(sum(ind1));
        semRecDataRun{i}.speedProfile = std(recData{i}.speedProfile)/sqrt(size(recData{i}.speedProfile,1));
        semRecDataRun{i}.lickProfile = std(recData{i}.lickProfile)/sqrt(size(recData{i}.lickProfile,1));
    end
end

function statRecDataRun = statRunRankSum(recData1,recData2)
    nCond = length(recData1);
    for i = 1:nCond
        disp(['Ranksum Condition ' num2str(i)]);
        indComm = ~isnan(recData1{i}.numSamplesMean) & ...
                         ~isnan(recData2{i}.numSamplesMean);
        if(sum(indComm) == 0)
            statRecDataRun{i} = [];
            continue;
        end
        statRecDataRun{i}.indComm = indComm;
        statRecDataRun{i}.numSamples = ranksum(recData1{i}.numSamplesMean,...
            recData2{i}.numSamplesMean);
        statRecDataRun{i}.maxSpeed = ranksum(recData1{i}.maxSpeedMean,...
            recData2{i}.maxSpeedMean);
        statRecDataRun{i}.meanSpeed = ranksum(recData1{i}.meanSpeedMean,...
            recData2{i}.meanSpeedMean);
        statRecDataRun{i}.maxRunLenT = ranksum(recData1{i}.maxRunLenTMean,...
            recData2{i}.maxRunLenTMean);
        statRecDataRun{i}.totRunLenT = ranksum(recData1{i}.totRunLenTMean,...
            recData2{i}.totRunLenTMean);
        statRecDataRun{i}.numRun = ranksum(recData1{i}.numRunMean,...
            recData2{i}.numRunMean);
        statRecDataRun{i}.maxAcc = ranksum(recData1{i}.maxAccMean,...
            recData2{i}.maxAccMean);
        statRecDataRun{i}.meanAcc = ranksum(recData1{i}.meanAccMean,...
            recData2{i}.meanAccMean);
        statRecDataRun{i}.totStopLenT = ranksum(recData1{i}.totStopLenTMean,...
            recData2{i}.totStopLenTMean);
        statRecDataRun{i}.startCueToRun = ranksum(recData1{i}.startCueToRunMean,...
            recData2{i}.startCueToRunMean);
        statRecDataRun{i}.numLicksBefRew = ranksum(recData1{i}.numLicksBefRewMean,...
            recData2{i}.numLicksBefRewMean);
        statRecDataRun{i}.numLicksRew = ranksum(recData1{i}.numLicksRewMean,...
            recData2{i}.numLicksRewMean);
        statRecDataRun{i}.med1stFiveLickDist = ranksum(recData1{i}.med1stFiveLickDistMean,...
            recData2{i}.med1stFiveLickDistMean);
        statRecDataRun{i}.medLickDist = ranksum(recData1{i}.medLickDistMean,...
            recData2{i}.medLickDistMean);
        statRecDataRun{i}.med1stFiveLickDistBefRew = ranksum(recData1{i}.med1stFiveLickDistBefRewMean,...
            recData2{i}.med1stFiveLickDistBefRewMean);
        statRecDataRun{i}.medLickDistBefRew = ranksum(recData1{i}.medLickDistBefRewMean,...
            recData2{i}.medLickDistBefRewMean);
        statRecDataRun{i}.percRewarded = ranksum(recData1{i}.percRewarded,...
            recData2{i}.percRewarded);
        statRecDataRun{i}.percNonStop = ranksum(recData1{i}.percNonStop,...
            recData2{i}.percNonStop);
        statRecDataRun{i}.pumpLfpInd = ranksum(recData1{i}.pumpLfpIndMean,...
            recData2{i}.pumpLfpIndMean);
        statRecDataRun{i}.pumpMM = ranksum(recData1{i}.pumpMMMean,...
            recData2{i}.pumpMMMean);
        
        %% total mean lick before reward
        indLickAfter30 = find(recData1{i}.spaceStepsLick >= 300 & recData1{i}.spaceStepsLick < 1800);
        statRecDataRun{i}.indLickAfter30 = indLickAfter30;
        statRecDataRun{i}.meanLickPerRec = [...
            mean(mean(recData1{i}.lickProfile(:,indLickAfter30))),...
            mean(mean(recData2{i}.lickProfile(:,indLickAfter30)))];
        statRecDataRun{i}.semLickPerRec = [...
            std(mean(recData1{i}.lickProfile(:,indLickAfter30)))/...
                sqrt(size(recData1{i}.lickProfile,1)),...
            std(mean(recData2{i}.lickProfile(:,indLickAfter30)))/...
                sqrt(size(recData2{i}.lickProfile,1))];
        statRecDataRun{i}.pRSMeanLickPerRec = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLickAfter30),[],1),...
            reshape(recData2{i}.lickProfile(:,indLickAfter30),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLickAfter30),2),...
            mean(recData2{i}.lickProfile(:,indLickAfter30),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLickAfter30),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLickAfter30),2));
        
        %% distance 30 to 150 lick
        indLick30to150 = find(recData1{i}.spaceStepsLick >= 300 & recData1{i}.spaceStepsLick < 1500);
        statRecDataRun{i}.indLick30to150 = indLick30to150;
        statRecDataRun{i}.meanLickPerRec30to150 = [...
            mean(mean(recData1{i}.lickProfile(:,indLick30to150))),...
            mean(mean(recData2{i}.lickProfile(:,indLick30to150)))];
        statRecDataRun{i}.pRSMeanLickPerRec30to150 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLick30to150),[],1),...
            reshape(recData2{i}.lickProfile(:,indLick30to150),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec30to150 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLick30to150),2),...
            mean(recData2{i}.lickProfile(:,indLick30to150),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec30to150 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLick30to150),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLick30to150),2));
        %%%%%% added by Yingxue on 10/28/2020
        statRecDataRun{i}.meanSumLickPerRec30to150 = [...
            mean(sum(recData1{i}.lickProfile(:,indLick30to150))),...
            mean(sum(recData2{i}.lickProfile(:,indLick30to150)))];
        statRecDataRun{i}.semSumLickPerRec30to150 = [...
            std(sum(recData1{i}.lickProfile(:,indLick30to150)))/sqrt(size(recData1{i}.lickProfile,1)),...
            std(sum(recData2{i}.lickProfile(:,indLick30to150)))/sqrt(size(recData2{i}.lickProfile,1))];
        statRecDataRun{i}.pRSSumLickPerRec30to150 = ...
            ranksum(sum(recData1{i}.lickProfile(:,indLick30to150)),...
            sum(recData2{i}.lickProfile(:,indLick30to150)));
        statRecDataRun{i}.pRSSumLickRndSelMeanPerRec30to150 = ...
            ranksum(sum(recData1{i}.lickProfileRndSel(:,indLick30to150),2),...
            sum(recData2{i}.lickProfileRndSel(:,indLick30to150),2));
        %%%%%% 
        
        %% distance 30 to 100 lick
        indLick30to100 = find(recData1{i}.spaceStepsLick >= 300 & recData1{i}.spaceStepsLick < 1000);
        statRecDataRun{i}.indLick30to100 = indLick30to100;
        statRecDataRun{i}.meanLickPerRec30to100 = [...
            mean(mean(recData1{i}.lickProfile(:,indLick30to100))),...
            mean(mean(recData2{i}.lickProfile(:,indLick30to100)))];
        statRecDataRun{i}.semLickPerRec30to100 = [...
            std(mean(recData1{i}.lickProfile(:,indLick30to100)))/...
                sqrt(size(recData1{i}.lickProfile,1)),...
            std(mean(recData2{i}.lickProfile(:,indLick30to100)))/...
                sqrt(size(recData2{i}.lickProfile,1))];
        statRecDataRun{i}.pRSMeanLickPerRec30to100 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLick30to100),[],1),...
            reshape(recData2{i}.lickProfile(:,indLick30to100),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec30to100 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLick30to100),2),...
            mean(recData2{i}.lickProfile(:,indLick30to100),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec30to100 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLick30to100),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLick30to100),2));
        %%%%%% added by Yingxue on 10/28/2020
        statRecDataRun{i}.meanSumLickPerRec30to100 = [...
            mean(sum(recData1{i}.lickProfile(:,indLick30to100))),...
            mean(sum(recData2{i}.lickProfile(:,indLick30to100)))];
        statRecDataRun{i}.semSumLickPerRec30to100 = [...
            std(sum(recData1{i}.lickProfile(:,indLick30to100)))/sqrt(size(recData1{i}.lickProfile,1)),...
            std(sum(recData2{i}.lickProfile(:,indLick30to100)))/sqrt(size(recData2{i}.lickProfile,1))];
        statRecDataRun{i}.pRSSumLickPerRec30to100 = ...
            ranksum(sum(recData1{i}.lickProfile(:,indLick30to100)),...
            sum(recData2{i}.lickProfile(:,indLick30to100)));
        statRecDataRun{i}.pRSSumLickRndSelMeanPerRec30to100 = ...
            ranksum(sum(recData1{i}.lickProfileRndSel(:,indLick30to100),2),...
            sum(recData2{i}.lickProfileRndSel(:,indLick30to100),2));
        %%%%%% 
        
        %% distance 100 to 150 lick
        indLick100to150 = find(recData1{i}.spaceStepsLick >= 1000 & recData1{i}.spaceStepsLick < 1500);
        statRecDataRun{i}.indLick100to150 = indLick100to150;
        statRecDataRun{i}.meanLickPerRec100to150 = [...
            mean(mean(recData1{i}.lickProfile(:,indLick100to150))),...
            mean(mean(recData2{i}.lickProfile(:,indLick100to150)))];
        statRecDataRun{i}.pRSMeanLickPerRec100to150 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLick100to150),[],1),...
            reshape(recData2{i}.lickProfile(:,indLick100to150),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec100to150 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLick100to150),2),...
            mean(recData2{i}.lickProfile(:,indLick100to150),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec100to150 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLick100to150),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLick100to150),2));

        %% distance 150 to 180 lick
        indLick150to180 = find(recData1{i}.spaceStepsLick >= 1500 & recData1{i}.spaceStepsLick < 1800);
        statRecDataRun{i}.indLick150to180 = indLick150to180;
        statRecDataRun{i}.meanLickPerRec150to180 = [...
            mean(mean(recData1{i}.lickProfile(:,indLick150to180))),...
            mean(mean(recData2{i}.lickProfile(:,indLick150to180)))];
        statRecDataRun{i}.pRSMeanLickPerRec150to180 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLick150to180),[],1),...
            reshape(recData2{i}.lickProfile(:,indLick150to180),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec150to180 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLick150to180),2),...
            mean(recData2{i}.lickProfile(:,indLick150to180),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec150to180 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLick150to180),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLick150to180),2));
        
        %% total mean lickbetween 100-180 cm
        indLick100to180 = find(recData1{i}.spaceStepsLick >= 1000 & recData1{i}.spaceStepsLick < 1800);
        statRecDataRun{i}.indLick100to180 = indLick100to180;
        statRecDataRun{i}.meanLickPerRec100to180 = [...
            mean(mean(recData1{i}.lickProfile(:,indLick100to180))),...
            mean(mean(recData2{i}.lickProfile(:,indLick100to180)))];
        statRecDataRun{i}.semLickPerRec100to180 = [...
            std(mean(recData1{i}.lickProfile(:,indLick100to180)))/...
                sqrt(size(recData1{i}.lickProfile,1)),...
            std(mean(recData2{i}.lickProfile(:,indLick100to180)))/...
                sqrt(size(recData2{i}.lickProfile,1))];
        statRecDataRun{i}.pRSMeanLickPerRec100to180 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLick100to180),[],1),...
            reshape(recData2{i}.lickProfile(:,indLick100to180),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRec100to180 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLick100to180),2),...
            mean(recData2{i}.lickProfile(:,indLick100to180),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRec100to180 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLick100to180),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLick100to180),2));
        
        %% After 180 lick
        indLickAfter180 = find(recData1{i}.spaceStepsLick >= 1800 & recData1{i}.spaceStepsLick < 2100);
        statRecDataRun{i}.indLickAfter180 = indLickAfter180;
        statRecDataRun{i}.meanLickPerRecAfter180 = [...
            mean(mean(recData1{i}.lickProfile(:,indLickAfter180))),...
            mean(mean(recData2{i}.lickProfile(:,indLickAfter180)))];
        statRecDataRun{i}.pRSMeanLickPerRecAfter180 = ...
            ranksum(reshape(recData1{i}.lickProfile(:,indLickAfter180),[],1),...
            reshape(recData2{i}.lickProfile(:,indLickAfter180),[],1));
        statRecDataRun{i}.pRSMeanLickMeanPerRecAfter180 = ...
            ranksum(mean(recData1{i}.lickProfile(:,indLickAfter180),2),...
            mean(recData2{i}.lickProfile(:,indLickAfter180),2));
        statRecDataRun{i}.pRSMeanLickRndSelMeanPerRecAfter180 = ...
            ranksum(mean(recData1{i}.lickProfileRndSel(:,indLickAfter180),2),...
            mean(recData2{i}.lickProfileRndSel(:,indLickAfter180),2));

        %% total mean speed
        statRecDataRun{i}.meanSpeedPerRec = [...
            mean(recData1{i}.speedProfile(:)),...
            mean(recData2{i}.speedProfile(:))];
        statRecDataRun{i}.pRSMeanSpeedPerRec = ...
            ranksum(recData1{i}.speedProfile(:),...
            recData2{i}.speedProfile(:));
        statRecDataRun{i}.pRSMeanSpeedMeanPerRec = ...
            ranksum(mean(recData1{i}.speedProfile,2),...
            mean(recData2{i}.speedProfile,2));
        statRecDataRun{i}.pRSMeanSpeedRndSelMeanPerRec = ...
            ranksum(mean(recData1{i}.speedProfileRndSel,2),...
            mean(recData2{i}.speedProfileRndSel,2));
        
        %% distance 30 to 100
        indSpeed30to100 = find(recData1{i}.spaceStepsSpeed >= 300 & recData1{i}.spaceStepsSpeed < 1000);
        statRecDataRun{i}.indSpeed30to100 = indSpeed30to100;
        statRecDataRun{i}.meanSpeedPerRec30to100 = [...
            mean(mean(recData1{i}.speedProfile(:,indSpeed30to100))),...
            mean(mean(recData2{i}.speedProfile(:,indSpeed30to100)))];
        statRecDataRun{i}.pRSMeanSpeedPerRec30to100 = ...
            ranksum(reshape(recData1{i}.speedProfile(:,indSpeed30to100),[],1),...
            reshape(recData2{i}.speedProfile(:,indSpeed30to100),[],1));
        statRecDataRun{i}.pRSMeanSpeedMeanPerRec30to100 = ...
            ranksum(mean(recData1{i}.speedProfile(:,indSpeed30to100),2),...
            mean(recData2{i}.speedProfile(:,indSpeed30to100),2));
        statRecDataRun{i}.pRSMeanSpeedRndSelMeanPerRec30to100 = ...
            ranksum(mean(recData1{i}.speedProfileRndSel(:,indSpeed30to100),2),...
            mean(recData2{i}.speedProfileRndSel(:,indSpeed30to100),2));
                
        %% After 100
        indSpeedAfter100 = find(recData1{i}.spaceStepsSpeed >= 1000);
        statRecDataRun{i}.indSpeedAfter100 = indSpeedAfter100;
        statRecDataRun{i}.meanSpeedPerRecAfter100 = [...
            mean(mean(recData1{i}.speedProfile(:,indSpeedAfter100))),...
            mean(mean(recData2{i}.speedProfile(:,indSpeedAfter100)))];
        statRecDataRun{i}.pRSMeanSpeedPerRecAfter100 = ...
            ranksum(reshape(recData1{i}.speedProfile(:,indSpeedAfter100),[],1),...
            reshape(recData2{i}.speedProfile(:,indSpeedAfter100),[],1));
        statRecDataRun{i}.pRSMeanSpeedMeanPerRecAfter100 = ...
            ranksum(mean(recData1{i}.speedProfile(:,indSpeedAfter100),2),...
            mean(recData2{i}.speedProfile(:,indSpeedAfter100),2));
        statRecDataRun{i}.pRSMeanSpeedRndSelMeanPerRecAfter100 = ...
            ranksum(mean(recData1{i}.speedProfileRndSel(:,indSpeedAfter100),2),...
            mean(recData2{i}.speedProfileRndSel(:,indSpeedAfter100),2));
    end
end

function statRecDataRun = statRunAnova1(recData1,recData2,recData3)
    nCond = length(recData1);
    for i = 1:nCond       
        disp(['Anova1 Condition ' num2str(i)]);
        [statRecDataRun{i}.numSamplesP,statRecDataRun{i}.numSamplesStats,...
            statRecDataRun{i}.numSamplesC,statRecDataRun{i}.numSamplesPreM,...
            statRecDataRun{i}.numSamplesPostM,statRecDataRun{i}.numSamplesPrePost]...
            = anovaPerParam(recData1{i}.numSamplesMean,...
            recData2{i}.numSamplesMean,recData3{i}.numSamplesMean,...
            ['Num. samples, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.maxSpeedP,statRecDataRun{i}.maxSpeedStats,...
            statRecDataRun{i}.maxSpeedC,statRecDataRun{i}.maxSpeedPreM,...
            statRecDataRun{i}.maxSpeedPostM,statRecDataRun{i}.maxSpeedPrePost]...
            = anovaPerParam(recData1{i}.maxSpeedMean,...
            recData2{i}.maxSpeedMean,recData3{i}.maxSpeedMean,...
            ['Max speed, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.meanSpeedP,statRecDataRun{i}.meanSpeedStats,...
            statRecDataRun{i}.meanSpeedC,statRecDataRun{i}.meanSpeedPreM,...
            statRecDataRun{i}.meanSpeedPostM,statRecDataRun{i}.meanSpeedPrePost]...
            = anovaPerParam(recData1{i}.meanSpeedMean,...
            recData2{i}.meanSpeedMean,recData3{i}.meanSpeedMean,...
            ['Mean speed, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.maxRunLenTP,statRecDataRun{i}.maxRunLenTStats,...
            statRecDataRun{i}.maxRunLenTC,statRecDataRun{i}.maxRunLenTPreM,...
            statRecDataRun{i}.maxRunLenTPostM,statRecDataRun{i}.maxRunLenTPrePost]...
            = anovaPerParam(recData1{i}.maxRunLenTMean,...
            recData2{i}.maxRunLenTMean,recData3{i}.maxRunLenTMean,...
            ['Max run len T, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.totRunLenTP,statRecDataRun{i}.totRunLenTStats,...
            statRecDataRun{i}.totRunLenTC,statRecDataRun{i}.totRunLenTPreM,...
            statRecDataRun{i}.totRunLenTPostM,statRecDataRun{i}.totRunLenTPrePost]...
            = anovaPerParam(recData1{i}.totRunLenTMean,...
            recData2{i}.totRunLenTMean,recData3{i}.totRunLenTMean,...
            ['Tot. run len T, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.numRunP,statRecDataRun{i}.numRunStats,...
            statRecDataRun{i}.numRunC,statRecDataRun{i}.numRunPreM,...
            statRecDataRun{i}.numRunPostM,statRecDataRun{i}.numRunPrePost]...
            = anovaPerParam(recData1{i}.numRunMean,...
            recData2{i}.numRunMean,recData3{i}.numRunMean,...
            ['Num runs, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.maxAccP,statRecDataRun{i}.maxAccStats,...
            statRecDataRun{i}.maxAccC,statRecDataRun{i}.maxAccPreM,...
            statRecDataRun{i}.maxAccPostM,statRecDataRun{i}.maxAccPrePost]...
            = anovaPerParam(recData1{i}.maxAccMean,...
            recData2{i}.maxAccMean,recData3{i}.maxAccMean,...
            ['Max acc., Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.meanAccP,statRecDataRun{i}.meanAccStats,...
            statRecDataRun{i}.meanAccC,statRecDataRun{i}.meanAccPreM,...
            statRecDataRun{i}.meanAccPostM,statRecDataRun{i}.meanAccPrePost]...
            = anovaPerParam(recData1{i}.meanAccMean,...
            recData2{i}.meanAccMean,recData3{i}.meanAccMean,...
            ['Mean acc., Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.totStopLenTP,statRecDataRun{i}.totStopLenTStats,...
            statRecDataRun{i}.totStopLenTC,statRecDataRun{i}.totStopLenTPreM,...
            statRecDataRun{i}.totStopLenTPostM,statRecDataRun{i}.totStopLenTPrePost]...
            = anovaPerParam(recData1{i}.totStopLenTMean,...
            recData2{i}.totStopLenTMean,recData3{i}.totStopLenTMean,...
            ['Tot. stop len T, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.startCueToRunP,statRecDataRun{i}.startCueToRunStats,...
            statRecDataRun{i}.startCueToRunC,statRecDataRun{i}.startCueToRunPreM,...
            statRecDataRun{i}.startCueToRunPostM,statRecDataRun{i}.startCueToRunPrePost]...
            = anovaPerParam(recData1{i}.startCueToRunMean,...
            recData2{i}.startCueToRunMean,recData3{i}.startCueToRunMean,...
            ['Start cue to run, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.numLicksBefRewP,statRecDataRun{i}.numLicksBefRewStats,...
            statRecDataRun{i}.numLicksBefRewC,statRecDataRun{i}.numLicksBefRewPreM,...
            statRecDataRun{i}.numLicksBefRewPostM,statRecDataRun{i}.numLicksBefRewPrePost]...
            = anovaPerParam(recData1{i}.numLicksBefRewMean,...
            recData2{i}.numLicksBefRewMean,recData3{i}.numLicksBefRewMean,...
            ['Num licks bef rew., Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.numLicksRewP,statRecDataRun{i}.numLicksRewStats,...
            statRecDataRun{i}.numLicksRewC,statRecDataRun{i}.numLicksRewPreM,...
            statRecDataRun{i}.numLicksRewPostM,statRecDataRun{i}.numLicksRewPrePost]...
            = anovaPerParam(recData1{i}.numLicksRewMean,...
            recData2{i}.numLicksRewMean,recData3{i}.numLicksRewMean,...
            ['Num likcs rew, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.med1stFiveLickDistP,statRecDataRun{i}.med1stFiveLickDistStats,...
            statRecDataRun{i}.med1stFiveLickDistC,statRecDataRun{i}.med1stFiveLickDistPreM,...
            statRecDataRun{i}.med1stFiveLickDistPostM,statRecDataRun{i}.med1stFiveLickDistPrePost]...
            = anovaPerParam(recData1{i}.med1stFiveLickDistMean,...
            recData2{i}.med1stFiveLickDistMean,recData3{i}.med1stFiveLickDistMean,...
            ['Med 1st five licks dist, Cond.'  num2str(i)]);
       
        [statRecDataRun{i}.medLickDistP,statRecDataRun{i}.medLickDistStats,...
            statRecDataRun{i}.medLickDistC,statRecDataRun{i}.medLickDistPreM,...
            statRecDataRun{i}.medLickDistPostM,statRecDataRun{i}.medLickDistPrePost]...
            = anovaPerParam(recData1{i}.medLickDistMean,...
            recData2{i}.medLickDistMean,recData3{i}.medLickDistMean,...
            ['Med lick dist, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.med1stFiveLickDistBefRewP,statRecDataRun{i}.med1stFiveLickDistBefRewStats,...
            statRecDataRun{i}.med1stFiveLickDistBefRewC,statRecDataRun{i}.med1stFiveLickDistBefRewPreM,...
            statRecDataRun{i}.med1stFiveLickDistBefRewPostM,statRecDataRun{i}.med1stFiveLickDistBefRewPrePost]...
            = anovaPerParam(recData1{i}.med1stFiveLickDistBefRewMean,...
            recData2{i}.med1stFiveLickDistBefRewMean,recData3{i}.med1stFiveLickDistBefRewMean,...
            ['Med 1st five lick dist bef rew, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.medLickDistBefRewP,statRecDataRun{i}.medLickDistBefRewStats,...
            statRecDataRun{i}.medLickDistBefRewC,statRecDataRun{i}.medLickDistBefRewPreM,...
            statRecDataRun{i}.medLickDistBefRewPostM,statRecDataRun{i}.medLickDistBefRewPrePost]...
            = anovaPerParam(recData1{i}.medLickDistBefRewMean,...
            recData2{i}.medLickDistBefRewMean,recData3{i}.medLickDistBefRewMean,...
            ['Med lick dist bef rew, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.percRewardedP,statRecDataRun{i}.percRewardedStats,...
            statRecDataRun{i}.percRewardedC,statRecDataRun{i}.percRewardedPreM,...
            statRecDataRun{i}.percRewardedPostM,statRecDataRun{i}.percRewardedPrePost]...
            = anovaPerParam(recData1{i}.percRewarded,...
            recData2{i}.percRewarded,recData3{i}.percRewarded,...
            ['Perc rewarded, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.percNonStopP,statRecDataRun{i}.percNonStopStats,...
            statRecDataRun{i}.percNonStopC,statRecDataRun{i}.percNonStopPreM,...
            statRecDataRun{i}.percNonStopPostM,statRecDataRun{i}.percNonStopPrePost]...
            = anovaPerParam(recData1{i}.percNonStop,...
            recData2{i}.percNonStop,recData3{i}.percNonStop,...
            ['Perc non-stop, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.pumpLfpIndP,statRecDataRun{i}.pumpLfpIndStats,...
            statRecDataRun{i}.pumpLfpIndC,statRecDataRun{i}.pumpLfpIndPreM,...
            statRecDataRun{i}.pumpLfpIndPostM,statRecDataRun{i}.pumpLfpIndPrePost]...
            = anovaPerParam(recData1{i}.pumpLfpIndMean,...
            recData2{i}.pumpLfpIndMean,recData3{i}.pumpLfpIndMean,...
            ['Pump lfp ind, Cond.'  num2str(i)]);
        
        [statRecDataRun{i}.pumpMMP,statRecDataRun{i}.pumpMMStats,...
            statRecDataRun{i}.pumpMMC,statRecDataRun{i}.pumpMMPreM,...
            statRecDataRun{i}.pumpMMPostM,statRecDataRun{i}.pumpMMPrePost]...
            = anovaPerParam(recData1{i}.pumpMMMean,...
            recData2{i}.pumpMMMean,recData3{i}.pumpMMMean,...
            ['Pump MM, Cond.'  num2str(i)]);
        
%         pause;
        close all;
    end
end

function [p,stats,c,preM,postM,prepost] = anovaPerParam(data1,data2,data3,ti)
    [p,~,stats]= anova1([data1',data2',data3']);
    title(ti)
    c = multcompare(stats,'CType','hsd','Display','off');
    preM = c(1,end);
    if(size(c,1) == 3)
        prepost = c(2,end);            
        postM = c(3,end);
    else
        prepost = [];            
        postM = [];
    end
end


% function corrRecData = corrRun(recData,fieldName)
%     nCond = length(recData);
%     for i = 10 
%         nElem = length(recData{i}.(fieldName));
%         [corrRecData{i}.numSamplesB,~,~,~,corrRecData{i}.numSamplesStats] = regress(...
%             recData{i}.numSamplesMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.maxSpeedB,~,~,~,corrRecData{i}.maxSpeedStats] = regress(...
%             recData{i}.maxSpeedMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.meanSpeedB,~,~,~,corrRecData{i}.meanSpeedStats] = regress(...
%             recData{i}.meanSpeedMean',[ones(nElem,1), recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.maxRunLenTB,~,~,~,corrRecData{i}.maxRunLenTStats] = regress(...
%             recData{i}.maxRunLenTMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.totRunLenTB,~,~,~,corrRecData{i}.totRunLenTStats] = regress(...
%             recData{i}.totRunLenTMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.numRunB,~,~,~,corrRecData{i}.numRunStats] = regress(...
%             recData{i}.numRunMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.maxAccB,~,~,~,corrRecData{i}.maxAccStats] = regress(...
%             recData{i}.maxAccMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.meanAccB,~,~,~,corrRecData{i}.meanAccStats] = regress(...
%             recData{i}.meanAccMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.totStopLenTB,~,~,~,corrRecData{i}.totStopLenTStats] = regress(...
%             recData{i}.totStopLenTMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.startCueToRunB,~,~,~,corrRecData{i}.startCueToRunStats] = regress(...
%             recData{i}.startCueToRunMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.numLicksBefRewB,~,~,~,corrRecData{i}.numLicksBefRewStats] = regress(...
%             recData{i}.numLicksBefRewMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.numLicksRewB,~,~,~,corrRecData{i}.numLicksRewStats] = regress(...
%             recData{i}.numLicksRewMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.med1stFiveLickDistB,~,~,~,corrRecData{i}.med1stFiveLickDistStats] = regress(...
%             recData{i}.med1stFiveLickDistMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.medLickDistB,~,~,~,corrRecData{i}.medLickDistStats] = regress(...
%             recData{i}.medLickDistMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.med1stFiveLickDistBefRewB,~,~,~,corrRecData{i}.med1stFiveLickDistBefRewStats] = regress(...
%             recData{i}.med1stFiveLickDistBefRewMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.medLickDistBefRewB,~,~,~,corrRecData{i}.medLickDistBefRewStats] = regress(...
%             recData{i}.medLickDistBefRewMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.percRewardedB,~,~,~,corrRecData{i}.percRewardedStats] = regress(...
%             recData{i}.percRewarded',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.percNonStopB,~,~,~,corrRecData{i}.percNonStopStats] = regress(...
%             recData{i}.percNonStop',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.pumpLfpIndB,~,~,~,corrRecData{i}.pumpLfpIndStats] = regress(...
%             recData{i}.pumpLfpIndMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.pumpMMB,~,~,~,corrRecData{i}.pumpMMStats] = regress(...
%             recData{i}.pumpMMMean',[ones(nElem,1),recData{i}.(fieldName)']);
%     
%     end
%end