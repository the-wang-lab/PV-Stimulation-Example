function behAlignedMean = accumMeanBehTime(behAlignedNoCue,behAlignedAL,behAlignedPL,behAligned,task)   
%% mean behavior for recordings with fields
%% Data aligned to run onset
%% this function is called by PyrBehTimeAlignedAllRec.m

    %% find recordings
    [indNonStimRecNoCueField,nonStimRecNoCueField] = intersect(behAlignedNoCue.indRecNonStim,behAligned.indRecNoCueField);
    [indNonStimRecALField,nonStimRecALField] = intersect(behAlignedAL.indRecNonStim,behAligned.indRecALField);
    [indNonStimRecPLField,nonStimRecPLField] = intersect(behAlignedPL.indRecNonStim,behAligned.indRecPLField);
    
    [indNonStimGoodRecNoCueField,nonStimGoodRecNoCueField] = intersect(behAlignedNoCue.indRecNonStimGood,behAligned.indRecNoCueField);
    [indNonStimGoodRecALField,nonStimGoodRecALField] = intersect(behAlignedAL.indRecNonStimGood,behAligned.indRecALField);
    [indNonStimGoodRecPLField,nonStimGoodRecPLField] = intersect(behAlignedPL.indRecNonStimGood,behAligned.indRecPLField);
    
    [~,nonStimBadRecNoCueField] = intersect(behAlignedNoCue.indRecNonStimBad,behAligned.indRecNoCueField);
    [~,nonStimBadRecALField] = intersect(behAlignedAL.indRecNonStimBad,behAligned.indRecALField);
    [~,nonStimBadRecPLField] = intersect(behAlignedPL.indRecNonStimBad,behAligned.indRecPLField);
    
    [~,stimRecNoCueField] = intersect(behAlignedNoCue.indRecStim,behAligned.indRecNoCueField);
    [~,stimRecALField] = intersect(behAlignedAL.indRecStim,behAligned.indRecALField);
    [~,stimRecPLField] = intersect(behAlignedPL.indRecStim,behAligned.indRecPLField);
    
    [indNonStimRecNoCueNoField,nonStimRecNoCueNoField] = intersect(behAlignedNoCue.indRecNonStim,behAligned.indRecNoCueNoField);
    [indNonStimRecALNoField,nonStimRecALNoField] = intersect(behAlignedAL.indRecNonStim,behAligned.indRecALNoField);
    [indNonStimRecPLNoField,nonStimRecPLNoField] = intersect(behAlignedPL.indRecNonStim,behAligned.indRecPLNoField);
    
    [indNonStimGoodRecNoCueNoField,nonStimGoodRecNoCueNoField] = intersect(behAlignedNoCue.indRecNonStimGood,behAligned.indRecNoCueNoField);
    [indNonStimGoodRecALNoField,nonStimGoodRecALNoField] = intersect(behAlignedAL.indRecNonStimGood,behAligned.indRecALNoField);
    [indNonStimGoodRecPLNoField,nonStimGoodRecPLNoField] = intersect(behAlignedPL.indRecNonStimGood,behAligned.indRecPLNoField);
    
    [~,nonStimBadRecNoCueNoField] = intersect(behAlignedNoCue.indRecNonStimBad,behAligned.indRecNoCueNoField);
    [~,nonStimBadRecALNoField] = intersect(behAlignedAL.indRecNonStimBad,behAligned.indRecALNoField);
    [~,nonStimBadRecPLNoField] = intersect(behAlignedPL.indRecNonStimBad,behAligned.indRecPLNoField);
    
    [~,stimRecNoCueNoField] = intersect(behAlignedNoCue.indRecStim,behAligned.indRecNoCueNoField);
    [~,stimRecALNoField] = intersect(behAlignedAL.indRecStim,behAligned.indRecALNoField);
    [~,stimRecPLNoField] = intersect(behAlignedPL.indRecStim,behAligned.indRecPLNoField);
    
    if(task == 1)
        % mean behavior for recordings with fields
        
        %% lick
        behAlignedMean.meanLickPerRecField = ...
            [behAlignedNoCue.meanLickPerRec(behAligned.indRecNoCueField,:);...
            behAlignedAL.meanLickPerRec(behAligned.indRecALField,:);...
            behAlignedPL.meanLickPerRec(behAligned.indRecPLField,:)];
        
        fieldTmp = [behAlignedNoCue.lickTraceNonStimPerRec(indNonStimRecNoCueField) ...
            behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALField) ...
            behAlignedPL.lickTraceNonStimPerRec(indNonStimRecPLField)];
        behAlignedMean.lickTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimPerRecField = [...
                behAlignedMean.lickTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end    
        
        behAlignedMean.meanLickNonStimGoodPerRecField = ...
            [behAlignedNoCue.meanLickNonStimGoodPerRec(nonStimGoodRecNoCueField,:);...
            behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALField,:);...
            behAlignedPL.meanLickNonStimGoodPerRec(nonStimGoodRecPLField,:)];

        fieldTmp = [behAlignedNoCue.lickTraceNonStimGoodPerRec(indNonStimGoodRecNoCueField) ...
            behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALField) ...
            behAlignedPL.lickTraceNonStimGoodPerRec(indNonStimGoodRecPLField)];
        behAlignedMean.lickTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end    

        behAlignedMean.meanLickNonStimBadPerRecField = ...
            [behAlignedNoCue.meanLickNonStimBadPerRec(nonStimBadRecNoCueField,:);...
            behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALField,:);...
            behAlignedPL.meanLickNonStimBadPerRec(nonStimBadRecPLField,:)];

        behAlignedMean.meanLickStimPerRecField = ...
            [behAlignedNoCue.meanLickStimPerRec(stimRecNoCueField,:);...
            behAlignedAL.meanLickStimPerRec(stimRecALField,:);...
            behAlignedPL.meanLickStimPerRec(stimRecPLField,:)];

        %% speed
        behAlignedMean.meanSpeedPerRecField = ...
            [behAlignedNoCue.meanSpeedPerRec(behAligned.indRecNoCueField,:);...
            behAlignedAL.meanSpeedPerRec(behAligned.indRecALField,:);...
            behAlignedPL.meanSpeedPerRec(behAligned.indRecPLField,:)];

        fieldTmp = [behAlignedNoCue.speedTraceNonStimPerRec(indNonStimRecNoCueField) ...
            behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALField) ...
            behAlignedPL.speedTraceNonStimPerRec(indNonStimRecPLField)];
        behAlignedMean.speedTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimPerRecField = [...
                behAlignedMean.speedTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecField = ...
            [behAlignedNoCue.meanSpeedNonStimGoodPerRec(nonStimGoodRecNoCueField,:);...
            behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALField,:);...
            behAlignedPL.meanSpeedNonStimGoodPerRec(nonStimGoodRecPLField,:)];

        fieldTmp = [behAlignedNoCue.speedTraceNonStimGoodPerRec(indNonStimGoodRecNoCueField) ...
            behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALField) ...
            behAlignedPL.speedTraceNonStimGoodPerRec(indNonStimGoodRecPLField)];
        behAlignedMean.speedTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecField = ...
            [behAlignedNoCue.meanSpeedNonStimBadPerRec(nonStimBadRecNoCueField,:);...
            behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALField,:);...
            behAlignedPL.meanSpeedNonStimBadPerRec(nonStimBadRecPLField,:)];

        behAlignedMean.meanSpeedStimPerRecField = ...
            [behAlignedNoCue.meanSpeedStimPerRec(stimRecNoCueField,:);...
            behAlignedAL.meanSpeedStimPerRec(stimRecALField,:);...
            behAlignedPL.meanSpeedStimPerRec(stimRecPLField,:)];

        % mean behavior for recordings without fields
        
        %% lick
        behAlignedMean.meanLickPerRecNoField = ...
            [behAlignedNoCue.meanLickPerRec(behAligned.indRecNoCueNoField,:);...
            behAlignedAL.meanLickPerRec(behAligned.indRecALNoField,:);...
            behAlignedPL.meanLickPerRec(behAligned.indRecPLNoField,:)];

        noFieldTmp = [behAlignedNoCue.lickTraceNonStimPerRec(indNonStimRecNoCueNoField) ...
            behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALNoField) ...
            behAlignedPL.lickTraceNonStimPerRec(indNonStimRecPLNoField)];
        behAlignedMean.lickTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimPerRecNoField = [...
                behAlignedMean.lickTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanLickNonStimGoodPerRecNoField = ...
            [behAlignedNoCue.meanLickNonStimGoodPerRec(nonStimGoodRecNoCueNoField,:);...
            behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALNoField,:);...
            behAlignedPL.meanLickNonStimGoodPerRec(nonStimGoodRecPLNoField,:)];

        noFieldTmp = [behAlignedNoCue.lickTraceNonStimGoodPerRec(indNonStimGoodRecNoCueNoField) ...
            behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALNoField) ...
            behAlignedPL.lickTraceNonStimGoodPerRec(indNonStimGoodRecPLNoField)];
        behAlignedMean.lickTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanLickNonStimBadPerRecNoField = ...
            [behAlignedNoCue.meanLickNonStimBadPerRec(nonStimBadRecNoCueNoField,:);...
            behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALNoField,:);...
            behAlignedPL.meanLickNonStimBadPerRec(nonStimBadRecPLNoField,:)];

        behAlignedMean.meanLickStimPerRecNoField = ...
            [behAlignedNoCue.meanLickStimPerRec(stimRecNoCueNoField,:);...
            behAlignedAL.meanLickStimPerRec(stimRecALNoField,:);...
            behAlignedPL.meanLickStimPerRec(stimRecPLNoField,:)];

        %% speed
        behAlignedMean.meanSpeedPerRecNoField = ...
            [behAlignedNoCue.meanSpeedPerRec(behAligned.indRecNoCueNoField,:);...
            behAlignedAL.meanSpeedPerRec(behAligned.indRecALNoField,:);...
            behAlignedPL.meanSpeedPerRec(behAligned.indRecPLNoField,:)];

        noFieldTmp = [behAlignedNoCue.speedTraceNonStimPerRec(indNonStimRecNoCueNoField) ...
            behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALNoField) ...
            behAlignedPL.speedTraceNonStimPerRec(indNonStimRecPLNoField)];
        behAlignedMean.speedTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimPerRecNoField = [...
                behAlignedMean.speedTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecNoField = ...
            [behAlignedNoCue.meanSpeedNonStimGoodPerRec(nonStimGoodRecNoCueNoField,:);...
            behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALNoField,:);...
            behAlignedPL.meanSpeedNonStimGoodPerRec(nonStimGoodRecPLNoField,:)];

        noFieldTmp = [behAlignedNoCue.speedTraceNonStimGoodPerRec(indNonStimGoodRecNoCueNoField) ...
            behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALNoField) ...
            behAlignedPL.speedTraceNonStimGoodPerRec(indNonStimGoodRecPLNoField)];
        behAlignedMean.speedTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecNoField = ...
            [behAlignedNoCue.meanSpeedNonStimBadPerRec(nonStimBadRecNoCueNoField,:);...
            behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALNoField,:);...
            behAlignedPL.meanSpeedNonStimBadPerRec(nonStimBadRecPLNoField,:)];

        behAlignedMean.meanSpeedStimPerRecNoField = ...
            [behAlignedNoCue.meanSpeedStimPerRec(stimRecNoCueNoField,:);...
            behAlignedAL.meanSpeedStimPerRec(stimRecALNoField,:);...
            behAlignedPL.meanSpeedStimPerRec(stimRecPLNoField,:)];
    elseif(task == 2)
        % mean behavior for recordings with fields
        
        %% lick
        behAlignedMean.meanLickPerRecField = ...
            [behAlignedAL.meanLickPerRec(behAligned.indRecALField,:);...
            behAlignedPL.meanLickPerRec(behAligned.indRecPLField,:)];

        fieldTmp = [behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALField) ...
            behAlignedPL.lickTraceNonStimPerRec(indNonStimRecPLField)];
        behAlignedMean.lickTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimPerRecField = [...
                behAlignedMean.lickTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end    
        
        behAlignedMean.meanLickNonStimGoodPerRecField = ...
            [behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALField,:);...
            behAlignedPL.meanLickNonStimGoodPerRec(nonStimGoodRecPLField,:)];

        fieldTmp = [behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALField) ...
            behAlignedPL.lickTraceNonStimGoodPerRec(indNonStimGoodRecPLField)];
        behAlignedMean.lickTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end    

        behAlignedMean.meanLickNonStimBadPerRecField = ...
            [behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALField,:);...
            behAlignedPL.meanLickNonStimBadPerRec(nonStimBadRecPLField,:)];

        behAlignedMean.meanLickStimPerRecField = ...
            [behAlignedAL.meanLickStimPerRec(stimRecALField,:);...
            behAlignedPL.meanLickStimPerRec(stimRecPLField,:)];

        %% speed
        behAlignedMean.meanSpeedPerRecField = ...
            [behAlignedAL.meanSpeedPerRec(behAligned.indRecALField,:);...
            behAlignedPL.meanSpeedPerRec(behAligned.indRecPLField,:)];

        fieldTmp = [behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALField) ...
            behAlignedPL.speedTraceNonStimPerRec(indNonStimRecPLField)];
        behAlignedMean.speedTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimPerRecField = [...
                behAlignedMean.speedTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecField = ...
            [behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALField,:);...
            behAlignedPL.meanSpeedNonStimGoodPerRec(nonStimGoodRecPLField,:)];

        fieldTmp = [behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALField) ...
            behAlignedPL.speedTraceNonStimGoodPerRec(indNonStimGoodRecPLField)];
        behAlignedMean.speedTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecField = ...
            [behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALField,:);...
            behAlignedPL.meanSpeedNonStimBadPerRec(nonStimBadRecPLField,:)];

        behAlignedMean.meanSpeedStimPerRecField = ...
            [behAlignedAL.meanSpeedStimPerRec(stimRecALField,:);...
            behAlignedPL.meanSpeedStimPerRec(stimRecPLField,:)];

        % mean behavior for recordings without fields
        
        %% lick
        behAlignedMean.meanLickPerRecNoField = ...
            [behAlignedAL.meanLickPerRec(behAligned.indRecALNoField,:);...
            behAlignedPL.meanLickPerRec(behAligned.indRecPLNoField,:)];

        noFieldTmp = [behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALNoField) ...
            behAlignedPL.lickTraceNonStimPerRec(indNonStimRecPLNoField)];
        behAlignedMean.lickTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimPerRecNoField = [...
                behAlignedMean.lickTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end
        
        behAlignedMean.meanLickNonStimGoodPerRecNoField = ...
            [behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALNoField,:);...
            behAlignedPL.meanLickNonStimGoodPerRec(nonStimGoodRecPLNoField,:)];

        noFieldTmp = [behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALNoField) ...
            behAlignedPL.lickTraceNonStimGoodPerRec(indNonStimGoodRecPLNoField)];
        behAlignedMean.lickTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanLickNonStimBadPerRecNoField = ...
            [behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALNoField,:);...
            behAlignedPL.meanLickNonStimBadPerRec(nonStimBadRecPLNoField,:)];

        behAlignedMean.meanLickStimPerRecNoField = ...
            [behAlignedAL.meanLickStimPerRec(stimRecALNoField,:);...
            behAlignedPL.meanLickStimPerRec(stimRecPLNoField,:)];

        %% speed
        behAlignedMean.meanSpeedPerRecNoField = ...
            [behAlignedAL.meanSpeedPerRec(behAligned.indRecALNoField,:);...
            behAlignedPL.meanSpeedPerRec(behAligned.indRecPLNoField,:)];

        noFieldTmp = [behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALNoField) ...
            behAlignedPL.speedTraceNonStimPerRec(indNonStimRecPLNoField)];
        behAlignedMean.speedTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimPerRecNoField = [...
                behAlignedMean.speedTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecNoField = ...
            [behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALNoField,:);...
            behAlignedPL.meanSpeedNonStimGoodPerRec(nonStimGoodRecPLNoField,:)];

        noFieldTmp = [behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALNoField) ...
            behAlignedPL.speedTraceNonStimGoodPerRec(indNonStimGoodRecPLNoField)];
        behAlignedMean.speedTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecNoField = ...
            [behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALNoField,:);...
            behAlignedPL.meanSpeedNonStimBadPerRec(nonStimBadRecPLNoField,:)];

        behAlignedMean.meanSpeedStimPerRecNoField = ...
            [behAlignedAL.meanSpeedStimPerRec(stimRecALNoField,:);...
            behAlignedPL.meanSpeedStimPerRec(stimRecPLNoField,:)];
    elseif(task == 3)
        % mean behavior for recordings with fields
        
        %% lick
        behAlignedMean.meanLickPerRecField = ...
            behAlignedAL.meanLickPerRec(behAligned.indRecALField,:);

        fieldTmp = behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALField);
        behAlignedMean.lickTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimPerRecField = [...
                behAlignedMean.lickTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end
        
        behAlignedMean.meanLickNonStimGoodPerRecField = ...
            behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALField,:);

        fieldTmp = behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALField);
        behAlignedMean.lickTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end    

        behAlignedMean.meanLickNonStimBadPerRecField = ...
            behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALField,:);

        behAlignedMean.meanLickStimPerRecField = ...
            behAlignedAL.meanLickStimPerRec(stimRecALField,:);

        %% speed
        behAlignedMean.meanSpeedPerRecField = ...
            behAlignedAL.meanSpeedPerRec(behAligned.indRecALField,:);

        fieldTmp = behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALField);
        behAlignedMean.speedTraceNonStimPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimPerRecField = [...
                behAlignedMean.speedTraceNonStimPerRecField; ...
                fieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecField = ...
            behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALField,:);

        fieldTmp = behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALField);
        behAlignedMean.speedTraceNonStimGoodPerRecField = [];
        for i = 1:length(fieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecField; ...
                fieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecField = ...
            behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALField,:);

        behAlignedMean.meanSpeedStimPerRecField = ...
            behAlignedAL.meanSpeedStimPerRec(stimRecALField,:);

        %% lick
        behAlignedMean.meanLickPerRecNoField = ...
            behAlignedAL.meanLickPerRec(behAligned.indRecALNoField,:);

        noFieldTmp = behAlignedAL.lickTraceNonStimPerRec(indNonStimRecALNoField);
        behAlignedMean.lickTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimPerRecNoField = [...
                behAlignedMean.lickTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end
        
        behAlignedMean.meanLickNonStimGoodPerRecNoField = ...
            behAlignedAL.meanLickNonStimGoodPerRec(nonStimGoodRecALNoField,:);

        noFieldTmp = behAlignedAL.lickTraceNonStimGoodPerRec(indNonStimGoodRecALNoField);
        behAlignedMean.lickTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.lickTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.lickTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanLickNonStimBadPerRecNoField = ...
            behAlignedAL.meanLickNonStimBadPerRec(nonStimBadRecALNoField,:);

        behAlignedMean.meanLickStimPerRecNoField = ...
            behAlignedAL.meanLickStimPerRec(stimRecALNoField,:);

        %% speed
        behAlignedMean.meanSpeedPerRecNoField = ...
            behAlignedAL.meanSpeedPerRec(behAligned.indRecALNoField,:);

        noFieldTmp = behAlignedAL.speedTraceNonStimPerRec(indNonStimRecALNoField);
        behAlignedMean.speedTraceNonStimPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimPerRecNoField = [...
                behAlignedMean.speedTraceNonStimPerRecNoField; ...
                noFieldTmp{i}];
        end
        
        behAlignedMean.meanSpeedNonStimGoodPerRecNoField = ...
            behAlignedAL.meanSpeedNonStimGoodPerRec(nonStimGoodRecALNoField,:);

        noFieldTmp = behAlignedAL.speedTraceNonStimGoodPerRec(indNonStimGoodRecALNoField);
        behAlignedMean.speedTraceNonStimGoodPerRecNoField = [];
        for i = 1:length(noFieldTmp)
            behAlignedMean.speedTraceNonStimGoodPerRecNoField = [...
                behAlignedMean.speedTraceNonStimGoodPerRecNoField; ...
                noFieldTmp{i}];
        end

        behAlignedMean.meanSpeedNonStimBadPerRecNoField = ...
            behAlignedAL.meanSpeedNonStimBadPerRec(nonStimBadRecALNoField,:);

        behAlignedMean.meanSpeedStimPerRecNoField = ...
            behAlignedAL.meanSpeedStimPerRec(stimRecALNoField,:);
    end
    
    %% calculating mean 
    % non stim trials with field
    behAlignedMean.meanLickTraceNonStimPerRecField = ...
        mean(behAlignedMean.lickTraceNonStimPerRecField);
    behAlignedMean.semLickTraceNonStimPerRecField = ...
        std(behAlignedMean.lickTraceNonStimPerRecField)/...
        sqrt(size(behAlignedMean.lickTraceNonStimPerRecField,1));
    
    behAlignedMean.meanSpeedTraceNonStimPerRecField = ...
        mean(behAlignedMean.speedTraceNonStimPerRecField);
    behAlignedMean.semSpeedTraceNonStimPerRecField = ...
        std(behAlignedMean.speedTraceNonStimPerRecField)/...
        sqrt(size(behAlignedMean.speedTraceNonStimPerRecField,1));
    
    % non stim good trials without field
    behAlignedMean.meanLickTraceNonStimPerRecNoField = ...
        mean(behAlignedMean.lickTraceNonStimPerRecNoField);
    behAlignedMean.semLickTraceNonStimPerRecNoField = ...
        std(behAlignedMean.lickTraceNonStimPerRecNoField)/...
        sqrt(size(behAlignedMean.lickTraceNonStimPerRecNoField,1));
    
    behAlignedMean.meanSpeedTraceNonStimPerRecNoField = ...
        mean(behAlignedMean.speedTraceNonStimPerRecNoField);
    behAlignedMean.semSpeedTraceNonStimPerRecNoField = ...
        std(behAlignedMean.speedTraceNonStimPerRecNoField)/...
        sqrt(size(behAlignedMean.speedTraceNonStimPerRecNoField,1));
    
    % non stim good trials with field
    behAlignedMean.meanLickTraceNonStimGoodPerRecField = ...
        mean(behAlignedMean.lickTraceNonStimGoodPerRecField);
    behAlignedMean.semLickTraceNonStimGoodPerRecField = ...
        std(behAlignedMean.lickTraceNonStimGoodPerRecField)/...
        sqrt(size(behAlignedMean.lickTraceNonStimGoodPerRecField,1));
    
    behAlignedMean.meanSpeedTraceNonStimGoodPerRecField = ...
        mean(behAlignedMean.speedTraceNonStimGoodPerRecField);
    behAlignedMean.semSpeedTraceNonStimGoodPerRecField = ...
        std(behAlignedMean.speedTraceNonStimGoodPerRecField)/...
        sqrt(size(behAlignedMean.speedTraceNonStimGoodPerRecField,1));
    
    % non stim good trials without field
    behAlignedMean.meanLickTraceNonStimGoodPerRecNoField = ...
        mean(behAlignedMean.lickTraceNonStimGoodPerRecNoField);
    behAlignedMean.semLickTraceNonStimGoodPerRecNoField = ...
        std(behAlignedMean.lickTraceNonStimGoodPerRecNoField)/...
        sqrt(size(behAlignedMean.lickTraceNonStimGoodPerRecNoField,1));
    
    behAlignedMean.meanSpeedTraceNonStimGoodPerRecNoField = ...
        mean(behAlignedMean.speedTraceNonStimGoodPerRecNoField);
    behAlignedMean.semSpeedTraceNonStimGoodPerRecNoField = ...
        std(behAlignedMean.speedTraceNonStimGoodPerRecNoField)/...
        sqrt(size(behAlignedMean.speedTraceNonStimGoodPerRecNoField,1));
end