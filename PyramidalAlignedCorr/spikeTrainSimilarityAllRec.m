function spikeTrainSimilarityAllRec(onlyRun)
% compare the spike train similarity for different alignment conditions over all the recordings 

    GlobalConst;
    intervalT = 20;
    intervalD = 1800;
    tc = 500; % ms
    cost = 2/(tc/1000*sampleFq);
    
    thrCorrT = -1; %0.03;
    
    RecordingList;
    
    spikeSimRunAll.CorrTNonZeroGood = [];
    spikeSimRunAll.CorrTGood = [];
    spikeSimRunAll.CorrTNonZeroGoodMeanPerRec = [];
    spikeSimRunAll.CorrTGoodMeanPerRec = [];
    spikeSimRunAll.CorrTNeuSelGood = [];
    spikeSimRunAll.CorrTRecNoGood = [];
    spikeSimRunAll.CorrTNonZeroMeanPerRec = [];
    spikeSimRunAll.CorrTMeanPerRec = [];
    spikeSimRunAll.CorrTNonZero = [];
    spikeSimRunAll.CorrT = [];
    spikeSimRunAll.CorrTNeuSel = [];
    spikeSimRunAll.CorrTRecNo = [];
    
    spikeSimRewAll.CorrTNonZeroGood = [];
    spikeSimRewAll.CorrTGood = [];
    spikeSimRewAll.CorrTNonZeroGoodMeanPerRec = [];
    spikeSimRewAll.CorrTGoodMeanPerRec = [];
    spikeSimRewAll.CorrTNonZero = [];
    spikeSimRewAll.CorrT = [];
    spikeSimRewAll.CorrTNonZeroMeanPerRec = [];
    spikeSimRewAll.CorrTMeanPerRec = [];
    
    spikeSimCueAll.CorrTNonZeroGood = [];
    spikeSimCueAll.CorrTGood = [];
    spikeSimCueAll.CorrTNonZeroGoodMeanPerRec = [];
    spikeSimCueAll.CorrTGoodMeanPerRec = [];
    spikeSimCueAll.CorrTNonZero = [];
    spikeSimCueAll.CorrT = [];
    spikeSimCueAll.CorrTNonZeroMeanPerRec = [];
    spikeSimCueAll.CorrTMeanPerRec = [];
    
    for i = 1:size(listRecordingsActiveLickPath,1)
        path = listRecordingsActiveLickPath(i,:);
        fileName = listRecordingsActiveLickFileName(i,:);
        mazeSess = mazeSessionActiveLick(i);
        fullPath = [path,fileName, '_meanSpikesCorrTAligned_msess' num2str(mazeSess) '_Run' num2str(onlyRun) '_intT' ...
            num2str(intervalT) '.mat'];
        load(fullPath,'meanCorrTRun','meanCorrTRew','meanCorrTCue');
        
        fileNameInfo = [fileName '_Info.mat'];
        fullPath = [path fileNameInfo];
        if(exist(fullPath) == 0)
            disp('_Info.mat file does not exist.');
            return;
        end
        load(fullPath,'autoCorr','beh'); 
        
        fullPathFR = [fileName '_FR_Run' num2str(onlyRun) '.mat'];
        fullPath = [path fullPathFR];
        if(exist(fullPath) == 0)
            disp('_FR_Run.mat file does not exist.');
            return;
        end
        load(fullPath,'mFRStruct','mFRStructSess'); 
        if(length(beh.mazeSessAll) > 1)
            mFR = mFRStructSess{mazeSess};
        else
            mFR = mFRStruct;
        end
        
        indNeuSel = mFR.mFR > minFR & mFR.mFR < maxFR &...
                    autoCorr.isPyrneuron == 1;
                
        indSelCorrT = meanCorrTRun.meanGoodNZ > thrCorrT;
        indSelCorrT = indNeuSel & indSelCorrT;
        spikeSimRunAll.CorrTNeuSelGood = [spikeSimRunAll.CorrTNeuSelGood ...
            find(indSelCorrT == 1)];
        spikeSimRunAll.CorrTRecNoGood = [spikeSimRunAll.CorrTRecNoGood ...
            i*ones(1,sum(indSelCorrT))];
        spikeSimRunAll.CorrTNonZeroGood = [spikeSimRunAll.CorrTNonZeroGood ...
            meanCorrTRun.meanGoodNZ(indSelCorrT)];
        spikeSimRewAll.CorrTNonZeroGood = [spikeSimRewAll.CorrTNonZeroGood ...
            meanCorrTRew.meanGoodNZ(indSelCorrT)];
        spikeSimCueAll.CorrTNonZeroGood = [spikeSimCueAll.CorrTNonZeroGood ...
            meanCorrTCue.meanGoodNZ(indSelCorrT)];
        
        spikeSimRunAll.CorrTNonZeroGoodMeanPerRec = [...
            spikeSimRunAll.CorrTNonZeroGoodMeanPerRec ...
            mean(meanCorrTRun.meanGoodNZ(indSelCorrT))];
        spikeSimRewAll.CorrTNonZeroGoodMeanPerRec = [...
            spikeSimRewAll.CorrTNonZeroGoodMeanPerRec ...
            mean(meanCorrTRew.meanGoodNZ(indSelCorrT))];
        spikeSimCueAll.CorrTNonZeroGoodMeanPerRec = [...
            spikeSimCueAll.CorrTNonZeroGoodMeanPerRec ...
            mean(meanCorrTCue.meanGoodNZ(indSelCorrT))];
        
        spikeSimRunAll.CorrTGood = [spikeSimRunAll.CorrTGood ...
            meanCorrTRun.meanGood(indSelCorrT)];
        spikeSimRewAll.CorrTGood = [spikeSimRewAll.CorrTGood ...
            meanCorrTRew.meanGood(indSelCorrT)];
        spikeSimCueAll.CorrTGood = [spikeSimCueAll.CorrTGood ...
            meanCorrTCue.meanGood(indSelCorrT)];
        
        spikeSimRunAll.CorrTGoodMeanPerRec = [...
            spikeSimRunAll.CorrTGoodMeanPerRec ...
            mean(meanCorrTRun.meanGood(indSelCorrT))];
        spikeSimRewAll.CorrTGoodMeanPerRec = [...
            spikeSimRewAll.CorrTGoodMeanPerRec ...
            mean(meanCorrTRew.meanGood(indSelCorrT))];
        spikeSimCueAll.CorrTGoodMeanPerRec = [...
            spikeSimCueAll.CorrTGoodMeanPerRec ...
            mean(meanCorrTCue.meanGood(indSelCorrT))];
                
        indSelCorrT = meanCorrTRun.meanNZ > thrCorrT;
        indSelCorrT = indNeuSel & indSelCorrT;
        spikeSimRunAll.CorrTNeuSel = [spikeSimRunAll.CorrTNeuSel ...
            find(indSelCorrT == 1)];
        spikeSimRunAll.CorrTRecNo = [spikeSimRunAll.CorrTRecNo ...
            i*ones(1,sum(indSelCorrT))];
        spikeSimRunAll.CorrTNonZero = [spikeSimRunAll.CorrTNonZero ...
            meanCorrTRun.meanNZ(indSelCorrT)];
        spikeSimRewAll.CorrTNonZero = [spikeSimRewAll.CorrTNonZero ...
            meanCorrTRew.meanNZ(indSelCorrT)];
        spikeSimCueAll.CorrTNonZero = [spikeSimCueAll.CorrTNonZero ...
            meanCorrTCue.meanNZ(indSelCorrT)];
        
        spikeSimRunAll.CorrTNonZeroMeanPerRec = [...
            spikeSimRunAll.CorrTNonZeroMeanPerRec ...
            mean(meanCorrTRun.meanNZ(indSelCorrT))];
        spikeSimRewAll.CorrTNonZeroMeanPerRec = [...
            spikeSimRewAll.CorrTNonZeroMeanPerRec ...
            mean(meanCorrTRew.meanNZ(indSelCorrT))];
        spikeSimCueAll.CorrTNonZeroMeanPerRec = [...
            spikeSimCueAll.CorrTNonZeroMeanPerRec ...
            mean(meanCorrTCue.meanNZ(indSelCorrT))];
        
        spikeSimRunAll.CorrT = [spikeSimRunAll.CorrT ...
            meanCorrTRun.mean(indSelCorrT)];
        spikeSimRewAll.CorrT = [spikeSimRewAll.CorrT ...
            meanCorrTRew.mean(indSelCorrT)];
        spikeSimCueAll.CorrT = [spikeSimCueAll.CorrT ...
            meanCorrTCue.mean(indSelCorrT)];
        
        spikeSimRunAll.CorrTMeanPerRec = [...
            spikeSimRunAll.CorrTMeanPerRec ...
            mean(meanCorrTRun.mean(indSelCorrT))];
        spikeSimRewAll.CorrTMeanPerRec = [...
            spikeSimRewAll.CorrTMeanPerRec ...
            mean(meanCorrTRew.mean(indSelCorrT))];
        spikeSimCueAll.CorrTMeanPerRec = [...
            spikeSimCueAll.CorrTMeanPerRec ...
            mean(meanCorrTCue.mean(indSelCorrT))];
    end
    
    spikeSimRunAll.pRS_CorrTNonZeroGood_RR = ranksum(spikeSimRunAll.CorrTNonZeroGood,...
        spikeSimRewAll.CorrTNonZeroGood);
    spikeSimRunAll.pRS_CorrTNonZeroGood_RC = ranksum(spikeSimRunAll.CorrTNonZeroGood,...
        spikeSimCueAll.CorrTNonZeroGood);
    
    spikeSimRunAll.pRS_CorrTGood_RR = ranksum(spikeSimRunAll.CorrTGood,...
        spikeSimRewAll.CorrTGood);
    spikeSimRunAll.pRS_CorrTGood_RC = ranksum(spikeSimRunAll.CorrTGood,...
        spikeSimCueAll.CorrTGood);
    
    spikeSimRunAll.pRS_CorrTNonZero_RR = ranksum(spikeSimRunAll.CorrTNonZero,...
        spikeSimRewAll.CorrTNonZero);
    spikeSimRunAll.pRS_CorrTNonZero_RC = ranksum(spikeSimRunAll.CorrTNonZero,...
        spikeSimCueAll.CorrTNonZero);
    
    spikeSimRunAll.pRS_CorrT_RR = ranksum(spikeSimRunAll.CorrT,...
        spikeSimRewAll.CorrT);
    spikeSimRunAll.pRS_CorrT_RC = ranksum(spikeSimRunAll.CorrT,...
        spikeSimCueAll.CorrT);
    
    save('Z:\Yingxue\DataAnalysisRaphi\SpikeCorrTAlignedAL.mat','spikeSimRunAll',...
        'spikeSimRewAll','spikeSimCueAll');
    
    plotSimComp(spikeSimRunAll.CorrTNonZeroGood,...
        spikeSimRewAll.CorrTNonZeroGood,...
        spikeSimRunAll.pRS_CorrTNonZeroGood_RR,...
        'Spike corr. NZgood aligned to run onset',...
        'Spike corr. NZgood aligned to reward onset');
    fileName1 = ['SpikeCorrTAligned_NZGood_RunVsRew_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');

    plotSimComp(spikeSimRunAll.CorrTNonZeroGood,...
        spikeSimCueAll.CorrTNonZeroGood,...
        spikeSimRunAll.pRS_CorrTNonZeroGood_RC,...
        'Spike corr. NZgood aligned to run onset',...
        'Spike corr. NZgood aligned to cue onset');
    fileName1 = ['SpikeCorrTAligned_NZGood_RunVsCue_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    plotSimComp(spikeSimRunAll.CorrTGood,...
        spikeSimRewAll.CorrTGood,...
        spikeSimRunAll.pRS_CorrTGood_RR,...
        'Spike corr. good aligned to run onset',...
        'Spike corr. good aligned to reward onset');
    fileName1 = ['SpikeCorrTAligned_Good_RunVsRew_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');

    plotSimComp(spikeSimRunAll.CorrTGood,...
        spikeSimCueAll.CorrTGood,...
        spikeSimRunAll.pRS_CorrTGood_RC,...
        'Spike corr. good aligned to run onset',...
        'Spike corr. good aligned to cue onset');
    fileName1 = ['SpikeCorrTAligned_Good_RunVsCue_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    
    plotSimComp(spikeSimRunAll.CorrTNonZero,...
        spikeSimRewAll.CorrTNonZero,...
        spikeSimRunAll.pRS_CorrTNonZero_RR,...
        'Spike corr. NZ aligned to run onset',...
        'Spike corr. NZ aligned to reward onset');
    fileName1 = ['SpikeCorrTAligned_NZ_RunVsRew_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');

    plotSimComp(spikeSimRunAll.CorrTNonZero,...
        spikeSimCueAll.CorrTNonZero,...
        spikeSimRunAll.pRS_CorrTNonZero_RC,...
        'Spike corr. NZ aligned to run onset',...
        'Spike corr. NZ aligned to cue onset');
    fileName1 = ['SpikeCorrTAligned_NZ_RunVsCue_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    plotSimComp(spikeSimRunAll.CorrT,...
        spikeSimRewAll.CorrT,...
        spikeSimRunAll.pRS_CorrT_RR,...
        'Spike corr. aligned to run onset',...
        'Spike corr. aligned to reward onset');
    fileName1 = ['SpikeCorrTAligned_RunVsRew_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');

    plotSimComp(spikeSimRunAll.CorrT,...
        spikeSimCueAll.CorrT,...
        spikeSimRunAll.pRS_CorrT_RC,...
        'Spike corr. aligned to run onset',...
        'Spike corr. aligned to cue onset');
    fileName1 = ['SpikeCorrTAligned_RunVsCue_ALRec'];
    print('-painters','-dpdf',['Z:\Yingxue\DataAnalysisRaphi\' fileName1],'-r600');
    
    colorSel= 0;
    plotBoxPlot(spikeSimRunAll.CorrTGood,...
        spikeSimCueAll.CorrTGood,'Spike corr. good',...
        'SpikeCorrTAligned_Good_RunVsCue_ALRecBox',...
        'Z:\Yingxue\DataAnalysisRaphi\',[],spikeSimRunAll.pRS_CorrTGood_RC,colorSel);
    
    plotBoxPlot(spikeSimRunAll.CorrTNonZeroGood,...
        spikeSimCueAll.CorrTNonZeroGood,'Spike corr. good (nonzero)',...
        'SpikeCorrTAligned_NZGood_RunVsCue_ALRecBox',...
        'Z:\Yingxue\DataAnalysisRaphi\',[],spikeSimRunAll.pRS_CorrTNonZeroGood_RC,colorSel);
    
    plotBoxPlot(spikeSimRunAll.CorrT,...
        spikeSimCueAll.CorrT,'Spike corr.',...
        'SpikeCorrTAligned_RunVsCue_ALRecBox',...
        'Z:\Yingxue\DataAnalysisRaphi\',[],spikeSimRunAll.pRS_CorrT_RC,colorSel);
    
    plotBoxPlot(spikeSimRunAll.CorrTNonZero,...
        spikeSimCueAll.CorrTNonZero,'Spike corr.(nonzero)',...
        'SpikeCorrTAligned_NZ_RunVsCue_ALRecBox',...
        'Z:\Yingxue\DataAnalysisRaphi\',[],spikeSimRunAll.pRS_CorrTNonZero_RC,colorSel);
end

function plotSimComp(x,y,p,xl,yl)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 280 280])
    h = plot(x,y,'.');
    set(h,'MarkerSize',4,'Color',[0.5 0.5 0.9]);
    maxXY = max([x,y]);
    hold on;
    h = plot([0 maxXY],[0 maxXY],'r:');
    set(h,'LineWidth',1);
    set(gca,'XLim',[0 maxXY],'YLim',[0 maxXY]);
    title(['p = ' num2str(p)]);
    xlabel(xl)
    ylabel(yl)
end

function plotBoxPlot(x1,x2,yl,fn,pathAnal,ylimit,p,colorSel)
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 200 400])
    if(colorSel == 0)
        colorArr = [163 207 98;...
                234 131 114]/255;
    elseif(colorSel == 1)            
        colorArr = [234 131 114;...
                116 53 61]/255;
    else        
        colorArr = [163 207 98;... 
            63 79 37]/255;
    end
    x = [x1';x2'];
    g = [repmat({'C1'},length(x1),1);...
        repmat({'C2'},length(x2),1)];
    boxplot(x,g,'Notch','on','Widths',0.3,'Symbol','');
    h = findobj(gca,'Tag','Box');
    for j = 1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),colorArr(j,:),'FaceAlpha',0.5);
    end
    if(~isempty(ylimit))
        set(gca,'YLim',ylimit);
    end
    ylabel(yl);
    title(['p = ' num2str(p)]);
    
    fileName1 = [pathAnal fn];
    saveas(gcf,fileName1);
    print('-painters', '-dpdf', fileName1, '-r600')
end