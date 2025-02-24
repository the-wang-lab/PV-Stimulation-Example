function InterneuronInitPeakSpeedAllRec(pathS,taskSel,methodKMean)
%% accumulating information about the speed at different time during the trial for each interneuron;
%% And calculating the relationship between running speed and firing rate 
%% Data aligned to run onset

    GlobalConstFq;
    
    RecordingListPyrInt;
    pathAnal0 = [pathS '\Interneuron\'];
    if(taskSel == 1) % including all the neurons
        pathAnal = [pathS '\InterneuronInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = [pathS '\InterneuronInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = [pathS '\InterneuronInitPeakAL\' num2str(methodKMean) '\'];
    end
   
    load([pathAnal0 'autoCorrIntAllRec.mat']);
    if(exist([pathAnal0 'initPeakIntSpeedAllRec.mat']))
        load([pathAnal0 'initPeakIntSpeedAllRec.mat']);
    end
    if(exist([pathAnal0 'initPeakIntAllRec.mat']))
        load([pathAnal0 'initPeakIntAllRec.mat']);
    end
    
%     if(taskSel == 1 && exist('modInt2NoCue') == 0)
        disp('No cue - firing rate vs. speed')
        modInt2NoCue = accumInterneurons3(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFRInt,1,sampleFq,nSampBef);

        disp('Active licking - firing rate vs. speed')
        modInt2AL = accumInterneurons3(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFRInt,2,sampleFq,nSampBef);

        disp('Passive licking - firing rate vs. speed')
        modInt2PL = accumInterneurons3(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFRInt,3,sampleFq,nSampBef);

        save([pathAnal0 'initPeakIntSpeedAllRec.mat'],'modInt2NoCue','modInt2AL','modInt2PL','-v7.3'); 
%     end
    
    modInt2 = InterneuronInitPeakSpeedAllRecByType(modInt2NoCue,modInt2AL,modInt2PL,...
        modInt1NoCue,modInt1AL,modInt1PL,taskSel,methodKMean);
      
    save([pathAnal 'initPeakIntSpeedAllRecSel.mat'],'modInt2');      
end

