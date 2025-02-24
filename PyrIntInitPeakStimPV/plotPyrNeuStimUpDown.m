function plotPyrNeuStimUpDown(pathAnal0,FRProfileMean1, modPyr1AL, PyrStim, FRProfile1)

    %% all pyramidal neurons
    for i = 1:length(FRProfileMean1)
        %% normalized
        %% order pyramidal neurons based on the peak firing rate after 0
        % and compare good non-stim with stim trials
        plotIndFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile1{i}.ind,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.ind,:),['Neuron no.'],...
                ['Pyr_IndFRProfileNormFRPeakAftRunNeuCmpGoodNoStimVsStim_Cond' num2str(i)],...
                pathAnal0,[],5,[],[])
        
        %% order pyramidal neurons based on before and after run FR ratio 
        % and compare good non-stim with stim trials
        plotIndFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile1{i}.ind,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.ind,:),['Neuron no.'],...
                ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuCmpGoodNoStimVsStim_Cond' num2str(i)],...
                pathAnal0,[],4,FRProfileMean1{i}.indFRBefRun,...
                FRProfileMean1{i}.indFR0to1)
    
        %% compare good non stim trials with stim trials, pyr rise
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile1{i}.indPyrRise,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrRise,:),...
                ['FR PyrRise Norm'],...
                ['Pyr_FRProfileNormPyrRiseNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile1{i}.indPyrDown,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrDown,:),...
                ['FR PyrDown Norm'],...
                ['Pyr_FRProfileNormPyrDownNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
            
        % added on 7/8/2022    
        %% compare good non stim trials with stim trials, pyr other
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNorm(FRProfile1{i}.indPyrOther,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrOther,:),...
                ['FR PyrOther Norm'],...
                ['Pyr_FRProfileNormPyrOtherNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'GoodNoStim'},{'Stim'}])
 
        %% not normalized, fields from good non-stim trials
        %% compare good non stim trials with stim trials, pyr rise
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfile(FRProfile1{i}.indPyrRise,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrRise,:),...
                ['FR PyrRise'],...
                ['Pyr_FRProfilePyrRiseNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfile(FRProfile1{i}.indPyrDown,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrDown,:),...
                ['FR PyrDown'],...
                ['Pyr_FRProfilePyrDownNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
            
        % added on 7/8/2022        
        %% compare good non stim trials with stim trials, pyr down
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfile(FRProfile1{i}.indPyrOther,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrOther,:),...
                ['FR PyrOther'],...
                ['Pyr_FRProfilePyrOtherNoStimGoodVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'GoodNoStim'},{'Stim'}])
            
            
        %% stimctrl vs stim    
        %% order pyramidal neurons based on the peak firing rate after 0
        % and compare stim Ctrl with stim trials
        plotIndFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile1{i}.ind,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.ind,:),['Neuron no.'],...
                ['Pyr_IndFRProfileNormFRPeakAftRunNeuCmpStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],5,[],[])
        
        %% order pyramidal neurons based on before and after run FR ratio 
        % and compare stim Ctrl with stim trials
        plotIndFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile1{i}.ind,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.ind,:),['Neuron no.'],...
                ['Pyr_IndFRProfileNormFR0to1VsBefRunNeuCmpStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],4,FRProfileMean1{i}.indFRBefRun,...
                FRProfileMean1{i}.indFR0to1)
    
        %% compare stim Ctrl trials with stim trials, pyr rise
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile1{i}.indPyrRise,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrRise,:),...
                ['FR PyrRise Norm'],...
                ['Pyr_FRProfileNormPyrRiseStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
        
        %% compare stim Ctrl trials with stim trials, pyr down
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile1{i}.indPyrDown,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrDown,:),...
                ['FR PyrDown Norm'],...
                ['Pyr_FRProfileNormPyrDownStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
            
        % added on 7/8/2022   
        %% compare stim Ctrl trials with stim trials, pyr other
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileNormStimCtrl(FRProfile1{i}.indPyrOther,:),...
                PyrStim.avgFRProfileNormStim(FRProfile1{i}.indPyrOther,:),...
                ['FR PyrOther Norm'],...
                ['Pyr_FRProfileNormPyrOtherStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[0 0.6],[{'StimCtrl'},{'Stim'}])
 
        %% not normalized, fields from stim Ctrl trials
        %% compare stim Ctrl  trials with stim trials, pyr rise
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile1{i}.indPyrRise,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrRise,:),...
                ['FR PyrRise'],...
                ['Pyr_FRProfilePyrRiseStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
        
        %% compare stim Ctrl trials with stim trials, pyr down
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile1{i}.indPyrDown,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrDown,:),...
                ['FR PyrDown'],...
                ['Pyr_FRProfilePyrDownStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
            
        % added on 7/8/2022   
        %% compare stim Ctrl trials with stim trials, pyr other
        plotAvgFRProfileCmp(modPyr1AL.timeStepRun,...
                PyrStim.avgFRProfileStimCtrl(FRProfile1{i}.indPyrOther,:),...
                PyrStim.avgFRProfileStim(FRProfile1{i}.indPyrOther,:),...
                ['FR PyrOther'],...
                ['Pyr_FRProfilePyrOtherStimCtrlVsStim_Cond' num2str(i)],...
                pathAnal0,[],[{'StimCtrl'},{'Stim'}])
    end