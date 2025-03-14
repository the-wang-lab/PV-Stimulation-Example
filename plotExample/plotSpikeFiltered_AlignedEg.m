function plotSpikeFiltered_AlignedEg(path, fileName, onlyRun, mazeSess, trialNo1, neuronNo)
% plot spikes rasters across run segments
% E.G.: plotSpikeRaster_aligned('./','A002-20181005-01_DataStructure_mazeSection1_TrialType1',1)
% e.g. plotSpikeRaster_AlignedEg('./','A016-20190603-01_DataStructure_mazeSection1_TrialType1',0,3,[],49)
% e.g. plotSpikeRaster_AlignedEg('./','A016-20190531-01_DataStructure_mazeSection1_TrialType1',0,5,[],19)
% e.g. plotSpikeRaster_AlignedEg('./','A023-20191219-01_DataStructure_mazeSection1_TrialType1',0,1,[],65)

    if(nargin == 4)
        trialNo1 = [];
        neuronNo = [];
    elseif(nargin == 5)
        neuronNo = [];
    end

    %%%%%%%%% load recording file
    fullPath = [path fileName '.mat']; 
    if(exist(fullPath) == 0)
        disp('The recording file does not exist');
        return;
    end
    load(fullPath,'cluList','lap');
    if(isempty(neuronNo))
        neuronNo = 1:length(cluList.all);
    end
       
    
    fullPath = [path fileName '_PeakFR_msess' num2str(mazeSess) '_RunOnset' num2str(onlyRun) '.mat'];
    if(exist(fullPath) == 0)
        disp('The peak firing rate aligned to run file does not exist');
        return;
    end
    load(fullPath,'pFRNonStimGoodStruct','pFRNonStimBadStruct');
    if(isempty(trialNo1))
        trialNo1 = pFRNonStimGoodStruct.indLapList;
        trialNo1 = trialNo1(trialNo1 ~= 1);
    end
        
    fullPath = [path fileName '_convSpikesAligned_msess' num2str(mazeSess) '_BefRun' num2str(onlyRun) '.mat'];
    if(exist(fullPath,'file') == 0)
        disp(['The firing profile file does not exist. Try to run the',...
                    'function again with fileState = 0.']);
    end
    load(fullPath,'timeStepRun','paramC','filteredSpikeArrayRunOnSet');
    
    fullPath = [path fileName '_behPar_msess' num2str(mazeSess) '.mat']; 
    if(exist(fullPath) == 0)
        disp('The _behPar file does not exist');
        return;
    end
    load(fullPath);
    
    fullPath = [path fileName '_Info.mat']; 
    if(exist(fullPath) == 0)
        disp('The aligned to run file does not exist');
        return;
    end
    load(fullPath,'beh');
    
    GlobalConst;
    
    trialLenT = 4; %sec
    for i = neuronNo
        disp(['Neuron ' num2str(i)]);
        
        [figNew,pos] = CreateFig();
        set(0,'Units','pixels') 
        figTitle = 'Spikes vs Time';
%             figTitle = 'Spikes vs Dist';        
        set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 350 350],'Name',figTitle)
                
        hold on;
        for j = trialNo1'   
            % filtered spike array over time
            h = plot(timeStepRun,filteredSpikeArrayRunOnSet{j}(i,:));    
            set(h,'Color',[0.5 0.5 0.5],'LineWidth',0.3)
        end
        set(gca, 'XLim', [-1 trialLenT], 'YLim',[0 n]);
        
        h = plot(timeStepRun/sampleFq,pFRNonStimGoodStruct.avgFRProfile(i,:),'r-');
        set(h,'LineWidth',0.5);
        ylabel('FR (Hz)');        
        set(gca, 'XLim', [-1 trialLenT]);       
        xlabel('Time (s)');
        figTitle = ['Neu ' num2str(i) '(' num2str(cluList.shank(i))...
                    ' ' num2str(cluList.localClu(i)) ')'];
        title(figTitle);
        
        ind = findstr(fileName,'_');
        print ('-painters', '-dpdf', ['spikeFilteredAlignedRun_' fileName(1:ind(1)-1) 'Neu' num2str(i)], '-r600')
        savefig(['spikeFilteredAlignedRun_' fileName(1:ind(1)-1) 'Neu' num2str(i) '.fig']);        
    end