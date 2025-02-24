function CompPyrIntInitPeakNoCueVsAL(pathS,mode)
%% compare the run onset response for PyrRise and PyrDown neurons
%% for No cue and AL (or ALPL) tasks
%% mode = 1, No cue vs ALPL
%% mode = 2, No cue vs AL
%% mode = 3, No cue vs AL first 10 recordings

pathAnal0 = [pathS '\Pyramidal\'];
    
if(exist([pathAnal0 'initPeakPyrAllRec.mat']))
    load([pathAnal0 'initPeakPyrAllRec.mat'],'modPyr1NoCue');
end
    
if(mode == 1)
    pathAnalAL = [pathS '\PyramidalIntInitPeakALPL\'];
    pathAnal = [pathS '\PyramidalIntInitPeakCmpNoCueALPL\'];
elseif(mode == 2)
    pathAnalAL = [pathS '\PyramidalIntInitPeakAL\'];
    pathAnal = [pathS '\PyramidalIntInitPeakCmpNoCueAL\'];
else
    pathAnalAL = [pathS '\PyramidalIntInitPeakAL10\'];
    pathAnal = [pathS '\PyramidalIntInitPeakCmpNoCueAL10\'];
end
pathAnalNoCue = [pathS '\PyramidalIntInitPeakNoCue\'];

if(exist(pathAnal) == 0)
    mkdir(pathAnal);
end    

if(exist([pathAnalAL 'initPeakPyrIntAllRec.mat']))
    load([pathAnalAL 'initPeakPyrIntAllRec.mat']);
    InitAllAL = InitAll;
    PyrRiseAL = PyrRise;
    PyrDownAL = PyrDown;
    PyrOtherAL = PyrOther;
    FRProfileMeanPyrAL = FRProfileMeanPyr;
end

if(exist([pathAnalNoCue 'initPeakPyrIntAllRec.mat']))
    load([pathAnalNoCue 'initPeakPyrIntAllRec.mat']);
    InitAllNoCue = InitAll;
    PyrRiseNoCue = PyrRise;
    PyrDownNoCue = PyrDown;
    PyrOtherNoCue = PyrOther;
    FRProfileMeanPyrNoCue = FRProfileMeanPyr;
end

FRProfileMeanPyrStat1.RiseALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Rise,FRProfileMeanPyrNoCue.Rise);
FRProfileMeanPyrStat1.DownALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Down,FRProfileMeanPyrNoCue.Down);
FRProfileMeanPyrStat1.OtherALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.Other,FRProfileMeanPyrNoCue.Other);

FRProfileMeanPyrStat1.RiseBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.RiseBad,FRProfileMeanPyrNoCue.RiseBad);
FRProfileMeanPyrStat1.DownBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.DownBad,FRProfileMeanPyrNoCue.DownBad);
FRProfileMeanPyrStat1.OtherBadALNoCue = accumMeanPyrIntInitPeakStatGoodBad(FRProfileMeanPyrAL.OtherBad,FRProfileMeanPyrNoCue.OtherBad);

save([pathAnal 'initPeakPyrIntAllRecNoCueVsAL.mat'],'FRProfileMeanPyrStat1'); 

colorSel = 0;
plotPyrNeuRiseDownNoCueVsAL(pathAnal,modPyr1NoCue.timeStepRun,...
            InitAllAL,InitAllNoCue,PyrRiseAL,PyrRiseNoCue,PyrDownAL,PyrDownNoCue,...
            PyrOtherAL,PyrOtherNoCue,FRProfileMeanPyrAL,FRProfileMeanPyrNoCue,...
            FRProfileMeanPyrStat1,colorSel,[{'NoCue'} {'AL'}]);
close all;