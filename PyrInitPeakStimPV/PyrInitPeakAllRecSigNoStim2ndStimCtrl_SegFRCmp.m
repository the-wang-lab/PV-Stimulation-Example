function PyrInitPeakAllRecSigNoStim2ndStimCtrl_SegFRCmp()
%% compare the firing rate of each neurons between ctrl and stim trials, for pulse method 2 and 3

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    pathAnal0 = ['Z:\Yingxue\Draft\PV\Pyramidal\'];
    
    if(exist([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']))
        load([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl.mat']);
    end
        
    GlobalConstFq;
    
%     if(exist('modPyr1SigAL') == 0)
        disp('Active licking - peak firing rate')
        modPyr2AL = accumPyr3NoStim2ndStimCtrlFRChange(listRecordingsActiveLickPath,...
                    listRecordingsActiveLickFileName,mazeSessionActiveLick,...
                        modPyr1SigAL,2,sampleFq,anmNoInact,anmNoAct);
                        
        save([pathAnal0 'initPeakPyrAllRecSigNoStim2ndStimCtrl_SegFRCmp.mat'],...
           'modPyr2AL');        
%     end
end

