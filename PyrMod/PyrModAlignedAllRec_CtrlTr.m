function PyrModAlignedAllRec_CtrlTr(pathS,onlyRun,taskSel,methodKMean)
%% accumulate information about individual pyramidal neurons' 
%% theta modulation, burstness and whether there is a field across recordings
%% Data are aligned to run onset 
%% only consider control trials

    if(nargin == 1)
        methodKMean = 2; % which kmean method is used
    end
    
    GlobalConstFq;
    
    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = [pathS '\Pyramidal\'];
    if(taskSel == 1) % including all the neurons
        pathAnal = [pathS '\PyramidalAlignedCtrlTr\' num2str(methodKMean) '\'];
    elseif(taskSel == 2) % including AL and PL neurons
        pathAnal = [pathS '\PyramidalAlignedCtrlTrALPL\' num2str(methodKMean) '\'];
    else % AL neurons only
        pathAnal = [pathS '\PyramidalAlignedCtrlTrAL\' num2str(methodKMean) '\'];
    end
    
    if(exist(pathAnal) == 0)
        mkdir(pathAnal);
    end
        
    if(exist([pathAnal0 'autoCorrPyrAllRec.mat']))
        load([pathAnal0 'autoCorrPyrAllRec.mat']);
    end
    
    if(exist([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat']))
        load([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat']);
    end
    
%     if(taskSel == 1 && exist('modPyr1NoCue_CtrlTr') == 0)
        %% pyramidal neurons in no cue passive task
        disp('No cue')
        modPyr1NoCue_CtrlTr = accumPyrNeurons1CtrlTr(listRecordingsNoCuePath,...
            listRecordingsNoCueFileName,mazeSessionNoCue,minFR,maxFR,1,methodTheta,onlyRun,intervalT);

        %% pyramidal neurons in active licking task
        disp('Active licking')
        modPyr1AL_CtrlTr = accumPyrNeurons1CtrlTr(listRecordingsActiveLickPath,...
            listRecordingsActiveLickFileName,mazeSessionActiveLick,minFR,maxFR,2,methodTheta,onlyRun,intervalT);
        
        %% pyramidal neurons in passive licking task with start cues
        disp('Passive licking')
        modPyr1PL_CtrlTr = accumPyrNeurons1CtrlTr(listRecordingsPassiveLickPath,...
            listRecordingsPassiveLickFileName,mazeSessionPassiveLick,minFR,maxFR,3,methodTheta,onlyRun,intervalT);

        if(exist([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat']))
            save([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat'],'modPyr1NoCue_CtrlTr','modPyr1AL_CtrlTr',...
                'modPyr1PL_CtrlTr','-append'); 
        else
            save([pathAnal0 'autoCorrPyrAlignedAllRec_CtrlTr.mat'],'modPyr1NoCue_CtrlTr','modPyr1AL_CtrlTr',...
                'modPyr1PL_CtrlTr');
        end
%     end
    
    mod_CtrlTr1 = PyrModAllRecByTypeAlignedCtrlTr(autoCorrPyrNoCue,autoCorrPyrAL,autoCorrPyrPL,...
                modPyr1NoCue_CtrlTr,modPyr1AL_CtrlTr,modPyr1PL_CtrlTr,autoCorrPyrAll,taskSel,methodKMean);
    
    save([pathAnal 'pyrAlignedAllRec_CtrlTr.mat'],'mod_CtrlTr1');
end




