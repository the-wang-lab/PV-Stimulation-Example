function PyrInitPeakAllRec_LongShortTr(pathS,taskSel,methodKMean)
%% accumulate the firing rate profiles separately for trials where the
%% reward is given around 180 cm vs 200cm
    
    if(nargin == 0)
        methodKMean = 2;
    end
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    pathAnal0 = [pathS '\Pyramidal\'];
    if(taskSel == 1) % including all the neurons
        pathAnal = [pathS '\PyramidalInitPeak\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = [pathS '\PyramidalInitPeakALPL\' num2str(methodKMean) '\'];
    else
        pathAnal = [pathS '\PyramidalInitPeakAL\' num2str(methodKMean) '\'];
    end
    
    GlobalConstFq;
    
    load([pathAnal0 'autoCorrPyrAllRec.mat']);
    if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
        load([pathAnal0 'initPeakPyrAllRec.mat']);
    end
    
%     if(taskSel == 2 && exist('modPyr2NoCue') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue - peak firing rate')
        modPyr2NoCue = accumLongShorTrialProfile(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,autoCorrPyrAll,...
            minFR,maxFR,1,sampleFq);

        %% pyramidal neurons in active licking task
        disp('Active licking - peak firing rate')
        modPyr2AL = accumLongShorTrialProfile(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,autoCorrPyrAll,...
            minFR,maxFR,2,sampleFq);

        %% pyramidal neurons in passive licking task with start cues
        disp('Passive licking - peak firing rate')
        modPyr2PL = accumLongShorTrialProfile(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,autoCorrPyrAll,...
            minFR,maxFR,3,sampleFq);

        save([pathAnal 'initPeakPyrAllRec_LongShortTr.mat'],'modPyr2NoCue','modPyr2AL','modPyr2PL','-v7.3'); 
%     end