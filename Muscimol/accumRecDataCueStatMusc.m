function accumRecDataCueStatMusc()
    RecordingListNT;
    
    fullPath = [folderPath 'allRecData.mat'];
    if(~exist(fullPath,'file'))
        disp([fullPath ' does not exist.']);
        return;
    end
    load(fullPath,'recDataCuePre','recDataCueManip','recDataCuePost');
    
    %% Mean
    disp('Calculate mean -- Cue');
    meanRecDataCuePre = meanCue(recDataCuePre);
    meanRecDataCueManip = meanCue(recDataCueManip);
    meanRecDataCuePost = meanCue(recDataCuePost);
    
    %% SEM
    disp('Calculate sem -- Cue');
    semRecDataCuePre = semCue(recDataCuePre);
    semRecDataCueManip = semCue(recDataCueManip);
    semRecDataCuePost = semCue(recDataCuePost);
    
    %% statistics for each pair using ranksum
    disp('Calculate statistics using ranksum -- Cue');
    rankRecDataCuePrePost = statCueRankSum(recDataCuePre,recDataCuePost);
    rankRecDataCuePreM = statCueRankSum(recDataCuePre,recDataCueManip);
    rankRecDataCuePostM = statCueRankSum(recDataCuePost,recDataCueManip);
        
    %% statistics using one-way anova1
    disp('Calculate statistics using one-way anova1 -- Cue');
    anovaRecDataCue = statCueAnova1(recDataCuePre,recDataCueManip,recDataCuePost);
    
%     %% correlation between time after injection and other behavioral parameters
%     disp('Calculate the correlation between time after injection and other behavioral parameters -- Cue');
%     corrRecDataCueRecStartT = corrCue(recDataCueManip,'tDiffInjStart');
%     corrRecDataCuePercReward = corrCue(recDataCueManip,'percRewarded');
%     corrRecDataCueRecEndT = corrCue(recDataCueManip,'tDiffInjEnd');
    
    fullPath = [folderPath 'allRecDataStats.mat'];
    save(fullPath,'meanRecDataCuePre','meanRecDataCueManip','meanRecDataCuePost',...
        'semRecDataCuePre','semRecDataCueManip','semRecDataCuePost',...
        'rankRecDataCuePrePost','rankRecDataCuePreM','rankRecDataCuePostM',...
        'anovaRecDataCue','-append');
%     save(fullPath,'corrRecDataCueRecStartT','corrRecDataCuePercReward',...
%         'corrRecDataCueRecEndT','-append');
end

function meanRecDataRun = meanCue(recData)
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
        ind1 = ~isnan(recData{i}.med1stFiveLickDistMean);
        meanRecDataRun{i}.med1stFiveLickDist = mean(recData{i}.med1stFiveLickDistMean(ind1));
        ind1 = ~isnan(recData{i}.medLickDistMean);
        meanRecDataRun{i}.medLickDist = mean(recData{i}.medLickDistMean(ind1));
        meanRecDataRun{i}.speedProfile = mean(recData{i}.speedProfile);
        meanRecDataRun{i}.lickProfile = mean(recData{i}.lickProfile);
    end
end

function semRecDataRun = semCue(recData)
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
        ind1 = ~isnan(recData{i}.med1stFiveLickDistMean);
        semRecDataRun{i}.med1stFiveLickDist = std(recData{i}.med1stFiveLickDistMean(ind1))/sqrt(sum(ind1));
        ind1 = ~isnan(recData{i}.medLickDistMean);
        semRecDataRun{i}.medLickDist = std(recData{i}.medLickDistMean(ind1))/sqrt(sum(ind1));
        semRecDataRun{i}.speedProfile = std(recData{i}.speedProfile)/sqrt(size(recData{i}.speedProfile,1));
        semRecDataRun{i}.lickProfile = std(recData{i}.lickProfile)/sqrt(size(recData{i}.lickProfile,1));
    end
end

function statRecDataRun = statCueRankSum(recData1,recData2)
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
        statRecDataRun{i}.med1stFiveLickDist = ranksum(recData1{i}.med1stFiveLickDistMean,...
            recData2{i}.med1stFiveLickDistMean);
        statRecDataRun{i}.medLickDist = ranksum(recData1{i}.medLickDistMean,...
            recData2{i}.medLickDistMean);
        
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
        
        %% total mean lick between 100-180 cm
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
    end
end

function statRecDataRun = statCueAnova1(recData1,recData2,recData3)
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


% function corrRecData = corrCue(recData,fieldName)
%     nCond = length(recData);
%     for i = 1:nCond   
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
%        [corrRecData{i}.med1stFiveLickDistB,~,~,~,corrRecData{i}.med1stFiveLickDistStats] = regress(...
%             recData{i}.med1stFiveLickDistMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%         [corrRecData{i}.medLickDistB,~,~,~,corrRecData{i}.medLickDistStats] = regress(...
%             recData{i}.medLickDistMean',[ones(nElem,1),recData{i}.(fieldName)']);
%         
%     end
% end