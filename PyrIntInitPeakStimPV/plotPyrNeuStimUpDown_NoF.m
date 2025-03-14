function plotPyrNeuStimUpDown_NoF(pathAnal0,FRProfileMeanRise, timeStepRun, PyrStim, FRProfile)

    %% all pyramidal neurons
    for i = 1:length(FRProfileMeanRise)
        %% normalized
        %% compare good non stim trials with stim trials, pyr rise
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile{i}.indPyrRise,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrRise,:),...
                ['FR PyrRise Norm'],...
                ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile{i}.indPyrDown,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrDown,:),...
                ['FR PyrDown Norm'],...
                ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
        % added on 7/8/2022    
        %% compare good non stim trials with stim trials, pyr other
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile{i}.indPyrOther,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrOther,:),...
                ['FR PyrOther Norm'],...
                ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
 
        %% not normalized, fields from good non-stim trials
        %% compare good non stim trials with stim trials, pyr rise
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfile(FRProfile{i}.indPyrRise,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrRise,:),...
                ['FR PyrRise'],...
                ['Pyr_FRProfilePyrRiseNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfile(FRProfile{i}.indPyrDown,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrDown,:),...
                ['FR PyrDown'],...
                ['Pyr_FRProfilePyrDownNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
            
        % added on 7/8/2022        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfile(FRProfile{i}.indPyrOther,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrOther,:),...
                ['FR PyrOther'],...
                ['Pyr_FRProfilePyrOtherNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
            
            
        %% stimctrl vs stim    
        %% compare stim Ctrl trials with stim trials, pyr rise
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile{i}.indPyrRise,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrRise,:),...
                ['FR PyrRise Norm'],...
                ['Pyr_FRProfileNormPyrRiseStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
        
        %% compare stim Ctrl trials with stim trials, pyr down
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile{i}.indPyrDown,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrDown,:),...
                ['FR PyrDown Norm'],...
                ['Pyr_FRProfileNormPyrDownStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
        % added on 7/8/2022   
        %% compare stim Ctrl trials with stim trials, pyr other
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile{i}.indPyrOther,:),...
                PyrStim.avgFRProfileNormStim(FRProfile{i}.indPyrOther,:),...
                ['FR PyrOther Norm'],...
                ['Pyr_FRProfileNormPyrOtherStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
 
        %% not normalized, fields from stim Ctrl trials
        %% compare stim Ctrl  trials with stim trials, pyr rise
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile{i}.indPyrRise,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrRise,:),...
                ['FR PyrRise'],...
                ['Pyr_FRProfilePyrRiseStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
        
        %% compare stim Ctrl trials with stim trials, pyr down
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile{i}.indPyrDown,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrDown,:),...
                ['FR PyrDown'],...
                ['Pyr_FRProfilePyrDownStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
            
        % added on 7/8/2022   
        %% compare stim Ctrl trials with stim trials, pyr other
        plotAvgFRProfileCmp(timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile{i}.indPyrOther,:),...
                PyrStim.avgFRProfileStim(FRProfile{i}.indPyrOther,:),...
                ['FR PyrOther'],...
                ['Pyr_FRProfilePyrOtherStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
    end