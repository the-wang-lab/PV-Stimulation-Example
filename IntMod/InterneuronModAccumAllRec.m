function InterneuronModAccumAllRec(pathS,onlyRun,methodKMean)
%% accumulate information about individual interneurons'
%% theta modulation, burstness and whether there is a field across recordings
%% e.g. PyrModAccumAllRec(1,2)

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = [pathS '\Interneuron\'];
    
    pathAnal = [pathS '\Interneuron\' num2str(methodKMean) '\'];
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
    
    GlobalConstFq;
    
    load([pathAnal0 'autoCorrIntAllRec.mat']);
    
    if(~exist([pathAnal 'modIntAllRec.mat']))
        %% interneurons in no cue passive task
        disp('No cue')
        modIntNoCue = accumInterneurons1(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFRInt,minFR,maxFR,1,methodTheta,onlyRun);

        disp('Active licking')
        modIntAL = accumInterneurons1(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFRInt,minFR,maxFR,2,methodTheta,onlyRun);

        disp('Passive licking')
        modIntPL = accumInterneurons1(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFRInt,minFR,maxFR,3,methodTheta,onlyRun);

        save([pathAnal 'modIntAllRec.mat'],'modIntNoCue','modIntAL','modIntPL'); 
    else
        load([pathAnal 'modIntAllRec.mat']);
    end
    
    plotConditions(modIntNoCue.thetaModHist,modIntNoCue.phaseMeanDire,...
        modIntAL.thetaModHist,modIntAL.phaseMeanDire,...
        modIntPL.thetaModHist,modIntPL.phaseMeanDire,...
        'Theta modulation (hist)','Theta phase mean direction',[]);
    
    plotConditions(modIntNoCue.thetaModHist,modIntNoCue.thetaModInd3,...
        modIntAL.thetaModHist,modIntAL.thetaModInd3,...
        modIntPL.thetaModHist,modIntPL.thetaModInd3,...
        'Theta modulation (hist)','Theta modulation 3',[]);
    
    if(methodKMean == 1)
        idxC = autoCorrIntAll.idxC1;
    elseif(methodKMean == 2)
        idxC = autoCorrIntAll.idxC2;
    elseif(methodKMean == 3)
        idxC = autoCorrIntAll.idxC3;
    end
    
    colorArr = [0.5 0.5 0.9;...
        163/255 207/255 98/255;...
        234/255 131/255 114/255;...
        0.7 0.3 0.3;...
        0.5 0.9 0.5;...
        0.2 0.5 0.8;...
        0.2 0.8 0.5;...
        0.8 0.5 0.2;...
        0.3 0.7 0.3];
        
    %% plot each interneuron clusters based on the task type
%     plotClusters(modIntNoCue.burstMeanDire,modIntNoCue.phaseMeanDire,...
%         idxC(autoCorrIntAll.task == autoCorrIntNoCue.task(1)),...
%         'Burst mean direction','Theta phase mean direction','No cue task',colorArr)
%     plot([0 2*pi],[0 2*pi],'k-')
    
    plotClusters(modIntAL.burstMeanDire,modIntAL.phaseMeanDire,...
        idxC(autoCorrIntAll.task == autoCorrIntAL.task(1)),...
        'Burst mean direction','Theta phase mean direction','AL task',colorArr)
    plot([0 2*pi],[0 2*pi],'k-')
    
%     plotClusters(modIntPL.burstMeanDire,modIntPL.phaseMeanDire,...
%         idxC(autoCorrIntAll.task == autoCorrIntPL.task(1)),...
%         'Burst mean direction','Theta phase mean direction','PL task',colorArr)
%     plot([0 2*pi],[0 2*pi],'k-')
    
    %% number of fields
    plotClusters(modIntAL.burstMeanDire,modIntAL.nNeuWithField,...
        idxC(autoCorrIntAll.task == autoCorrIntAL.task(1)),...
        'Burst mean direction','Num. fields','AL task',colorArr)
    
%     plotClusters(modIntPL.burstMeanDire,modIntPL.nNeuWithField,...
%         idxC(autoCorrIntAll.task == autoCorrIntPL.task(1)),...
%         'Burst mean direction','Num. fields','PL task',colorArr)
    