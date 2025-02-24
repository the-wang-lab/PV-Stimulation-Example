function PyrIntInitPeakPVStimNonStim2ndStimCtrlSigGoodOnlyNoF(methodKMean)
% compare Pyramidal neurons and PV interneurons on their initial peak (neurons without field), only
% consider good trials during both control and stimulation
% stimCtrlCond = 1, include all the stim sessions
% stimCtrlCond = 2, only include sessions where 2 stim ctrl are followed by one stim trial
    
    pathAnal0 = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSigGoodOnlyNoF\'];
    pathAnal = ['Z:\Yingxue\Draft\PV\PyramidalStimALNonStim2ndStimCtrlSigGoodOnly\' num2str(methodKMean) '\'];
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlGoodOnly.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlGoodOnly.mat']);
    end
    
    if(exist([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlGoodOnly_km' num2str(methodKMean) '.mat']))
        load([pathAnal 'initPeakPyrAllRecSigStimNoStim2ndStimCtrlGoodOnly_km' num2str(methodKMean) '.mat']);
    end
    
    if(exist([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrlGoodOnly.mat']))
        load([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrlGoodOnly.mat']);
    end
    if(~exist(pathAnal0))
        mkdir(pathAnal0);
    end
    
    avgFRProfile = modPyr1AL.avgFRProfile; 
    avgFRProfileStim = modPyr1AL.avgFRProfileStim;
    avgFRProfileStimCtrl = modPyr1AL.avgFRProfileStimCtrl;
    isFieldGoodNonStim = modPyr1AL.isNeuWithFieldAlignedGoodNonStim;
    isFieldGoodNonStimAndStim = (modPyr1AL.isNeuWithFieldAlignedGoodNonStim | ...
        modPyr1AL.isNeuWithFieldAlignedStim);

    PyrStim.avgFRProfile = avgFRProfile;
    PyrStim.avgFRProfileStim = avgFRProfileStim;
    PyrStim.avgFRProfileStimCtrl = avgFRProfileStimCtrl;
    PyrStim.avgFRProfileNorm = zeros(size(avgFRProfile,1),size(avgFRProfile,2));
    for i = 1:size(avgFRProfile,1)
        if(max(avgFRProfile(i,:)) ~= 0)
            PyrStim.avgFRProfileNorm(i,:) = avgFRProfile(i,:)/max(avgFRProfile(i,:));
        end
    end
    PyrStim.avgFRProfileNormStim = zeros(size(avgFRProfileStim,1),size(avgFRProfileStim,2));
    for i = 1:size(avgFRProfileStim,1)
        if(max(avgFRProfileStim(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStim(i,:) = avgFRProfileStim(i,:)/max(avgFRProfileStim(i,:));
        end
    end
    PyrStim.avgFRProfileNormStimCtrl = zeros(size(avgFRProfileStimCtrl,1),size(avgFRProfileStimCtrl,2));
    for i = 1:size(avgFRProfileStimCtrl,1)
        if(max(avgFRProfileStimCtrl(i,:)) ~= 0)
            PyrStim.avgFRProfileNormStimCtrl(i,:) = avgFRProfileStimCtrl(i,:)/max(avgFRProfileStimCtrl(i,:));
        end
    end

%     if(~exist('PyrRise'))
        mean0to1 = mean(avgFRProfile(:,FRProfileMeanAll.indFR0to1),2);
        meanBefRun = mean(avgFRProfile(:,FRProfileMeanAll.indFRBefRun),2);
        ratio0to1BefRun = mean0to1./meanBefRun;
        [ratio0to1BefRunOrd,indOrd] = sort(ratio0to1BefRun,'descend');
        idxNan = isnan(ratio0to1BefRunOrd);
        idxInf = isinf(ratio0to1BefRunOrd);
    %     idx = find(ratio0to1BefRunOrd < 1.25,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.8,1,'last');

    %     idx = find(ratio0to1BefRunOrd < 2,1);
    %     idx1 = find(ratio0to1BefRunOrd >= 0.5,1,'last');

        idx = find(ratio0to1BefRunOrd < 1.5,1);
        idx1 = find(ratio0to1BefRunOrd >= 2/3,1,'last');
        
        tsneEmbed(PyrStim.avgFRProfileNorm(indOrd,FRProfileMeanAll.indFRBefRun(1):FRProfileMeanAll.indFR0to1(end)),...
            idx,idx1,pathAnal0,'tsneEmbedPyrRiseDown');

        %% neurons with FR increase around 0
        indOrdTmp = indOrd(1:idx);
        idxNanTmp = idxNan(1:idx);
        idxInfTmp = idxInf(1:idx);
        indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
        PyrRise.idxRise = indOrdTmp;
        PyrRise.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrRise.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrRise.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrRise.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrRise.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrRise.isField = isFieldGoodNonStim(indOrdTmp);

        %% neurons with FR decrease around 0
        indOrdTmp = indOrd(idx1:end);
        idxNanTmp = idxNan(idx1:end);
        idxInfTmp = idxInf(idx1:end);
        indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
        PyrDown.idxDown = indOrdTmp;
        PyrDown.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrDown.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrDown.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrDown.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrDown.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrDown.isField = isFieldGoodNonStim(indOrdTmp);
        
        %% other neurons (added on 7/8/2022)
        indOrdTmp = indOrd(idx+1:idx1-1);
        idxNanTmp = idxNan(idx+1:idx1-1);
        idxInfTmp = idxInf(idx+1:idx1-1);
        indOrdTmp = indOrdTmp(idxNanTmp == 0 & idxInfTmp == 0);
        PyrOther.idxOther = indOrdTmp;
        PyrOther.pulseMethod = modPyr1AL.pulseMeth(indOrdTmp);
        PyrOther.stimLoc = modPyr1AL.stimLoc(indOrdTmp);
        PyrOther.actOrInact = modPyr1AL.actOrInact(indOrdTmp);
        PyrOther.indRec = modPyr1AL.indRec(indOrdTmp);
        PyrOther.indNeu = modPyr1AL.indNeu(indOrdTmp);
        PyrOther.isField = isFieldGoodNonStim(indOrdTmp);

        pm3StimLoc{1} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
            & modPyr1AL.actOrInactPerRec == 1)); % stim location for inactivation
        pm3StimLoc{2} = unique(modPyr1AL.stimLocPerRec(modPyr1AL.pulseMethPerRec == 3 ...
            & modPyr1AL.actOrInactPerRec == 2)); % stim location for activation
        % activation or inactivation
        cond = 0;
        for i = 1: 2
            % different pulse methods
            for j = 1:length(pulseMethod{i})
                if(pulseMethod{i}(j) == 3)
                    stimLocs = pm3StimLoc{i};
                else
                    stimLocs = 0;
                end
                for m = 1:length(stimLocs)  
                    cond = cond + 1;
                    ind = find(PyrRise.actOrInact == i & PyrRise.pulseMethod == pulseMethod{i}(j) ...
                        & PyrRise.stimLoc == stimLocs(m) & PyrRise.isField == 0);
                    PyrStim1.FRProfile1{cond}.actOrInact = i;
                    PyrStim1.FRProfile1{cond}.pulseMethod = pulseMethod{i}(j);
                    PyrStim1.FRProfile1{cond}.stimLoc = stimLocs(m);
                    PyrStim1.FRProfile1{cond}.indPyrRise = PyrRise.idxRise(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrRise = PyrRise.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrRise = PyrRise.indNeu(ind);
                    ind = find(PyrDown.actOrInact == i & PyrDown.pulseMethod == pulseMethod{i}(j) ...
                        & PyrDown.stimLoc == stimLocs(m) & PyrDown.isField == 0);
                    PyrStim1.FRProfile1{cond}.indPyrDown = PyrDown.idxDown(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrDown = PyrDown.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrDown = PyrDown.indNeu(ind);
                    %% added on 7/8/2022
                    ind = find(PyrOther.actOrInact == i & PyrOther.pulseMethod == pulseMethod{i}(j) ...
                        & PyrOther.stimLoc == stimLocs(m) & PyrOther.isField == 0);
                    PyrStim1.FRProfile1{cond}.indPyrOther = PyrOther.idxOther(ind);
                    PyrStim1.FRProfile1{cond}.indRecPyrOther = PyrOther.indRec(ind);
                    PyrStim1.FRProfile1{cond}.indNeuPyrOther = PyrOther.indNeu(ind);
                    %%
                    ind = find(modPyr1AL.actOrInact == i & modPyr1AL.pulseMeth == pulseMethod{i}(j) ...
                        & modPyr1AL.stimLoc == stimLocs(m) & isFieldGoodNonStim == 0);
                    PyrStim1.FRProfile1{cond}.ind = ind;
                    
                    %% Pyramidal neurons
                    PyrStim1.FRProfileMean1{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStim1{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);
                    PyrStim1.FRProfileMeanStimCtrl1{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.ind,:),modPyr1AL.timeStepRun);

                    % compare good non-stim and stim trials
                    PyrStim1.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMean1{cond},PyrStim1.FRProfileMeanStim1{cond});
                    % compare good stim and stim ctrl trials
                    PyrStim1.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrStim1.FRProfileMeanStim1{cond},PyrStim1.FRProfileMeanStimCtrl1{cond});

                    
                    %% pyramidal neurons rise and down
                    PyrRise.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMean{cond} = accumMeanPVStim(avgFRProfile(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022
                    PyrRise.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanStim{cond} = accumMeanPVStim(avgFRProfileStim(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022
                    PyrRise.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrRise,:),modPyr1AL.timeStepRun);
                    PyrDown.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrDown,:),modPyr1AL.timeStepRun);
                    PyrOther.FRProfileMeanStimCtrl{cond} = accumMeanPVStim(avgFRProfileStimCtrl(PyrStim1.FRProfile1{cond}.indPyrOther,:),modPyr1AL.timeStepRun); % added on 7/8/2022

                    % compare good non-stim and stim trials rise neurons
                    PyrRise.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMean{cond},PyrRise.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials rise neurons
                    PyrRise.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrRise.FRProfileMeanStim{cond},PyrRise.FRProfileMeanStimCtrl{cond});

                    % compare good non-stim and stim trials down neurons
                    PyrDown.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMean{cond},PyrDown.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials down neurons
                    PyrDown.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrDown.FRProfileMeanStim{cond},PyrDown.FRProfileMeanStimCtrl{cond});

                    %% added on 7/8/2022
                    % compare good non-stim and stim trials other neurons
                    PyrOther.FRProfileMeanStatNonStimVsStim{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMean{cond},PyrOther.FRProfileMeanStim{cond});
                    % compare good stim and stim ctrl trials other neurons
                    PyrOther.FRProfileMeanStatStimVsStimCtrl{cond} = accumMeanPVStimStatGoodBad(PyrOther.FRProfileMeanStim{cond},PyrOther.FRProfileMeanStimCtrl{cond});
                    
                    
          
                end
            end
        end

        save([pathAnal0 'initPeakPyrIntAllRecStimSigNoStim2ndStimCtrlGoodOnlyNoF.mat'],'PyrStim1','PyrRise','PyrDown','PyrOther','-v7.3'); 
%     end
    
    % 
    plotPyrNeuStimUpDown(pathAnal0,PyrStim1.FRProfileMean1,modPyr1AL,PyrStim,PyrStim1.FRProfile1);
    close all;

    %% statistics
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMean1,PyrStim1.FRProfileMeanStim1,...
        PyrStim1.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrStim1.FRProfileMeanStimCtrl1,PyrStim1.FRProfileMeanStim1,...
        PyrStim1.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'StimCtrl',0);
    close all;

    % pyr rise
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMean,PyrRise.FRProfileMeanStim,...
        PyrRise.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrRise',0);
    close all;

    plotPyrNeuWithFieldStimStats(pathAnal0,PyrRise.FRProfileMeanStimCtrl,PyrRise.FRProfileMeanStim,...
        PyrRise.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrRiseStimCtrl',0);
    close all;

    plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrRise.FRProfileMean,PyrRise.FRProfileMeanStim,...
        PyrRise.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrRiseBox');
    close all;
    
    % pyr down
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMean,PyrDown.FRProfileMeanStim,...
        PyrDown.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrDown',0);
    close all;
    
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrDown.FRProfileMeanStimCtrl,PyrDown.FRProfileMeanStim,...
        PyrDown.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrDownStimCtrl',0);
    close all;
    
    plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrDown.FRProfileMean,PyrDown.FRProfileMeanStim,...
        PyrDown.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrDownBox');
    close all;
    
    % pyr other
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMean,PyrOther.FRProfileMeanStim,...
        PyrOther.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrOther',0);
    close all;
    
    plotPyrNeuWithFieldStimStats(pathAnal0,PyrOther.FRProfileMeanStimCtrl,PyrOther.FRProfileMeanStim,...
        PyrOther.FRProfileMeanStatStimVsStimCtrl,[{'StimCtrl'} {'Stim'}],'PyrOtherStimCtrl',0);
    close all;
    
    plotPyrNeuWithFieldStimStatsBox(pathAnal0,PyrOther.FRProfileMean,PyrOther.FRProfileMeanStim,...
        PyrOther.FRProfileMeanStatNonStimVsStim,[{'Nonstim'} {'Stim'}],'PyrOtherBox');
    close all;
    
end







