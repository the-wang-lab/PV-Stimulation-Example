function ProcessPyrNeurons()

onlyRun = 1;

%% accumulation all the relevant data from every recordings for pyramidal neurons
PyrPropAllRec(onlyRun);
methodKMean = 2;
PyrModAccumAllRec(onlyRun, methodKMean);

for taskSel = 1:3
    % taskSel == 1 % including all the neurons
    % taskSel == 2 % including AL and PL neurons
    % taskSel == 3 % AL neurons only
    PyrModAllRec(onlyRun,taskSel,methodKMean);
    
    PyrModAlignedAllRec(onlyRun,taskSel,methodKMean);
     
    PyrInitPeakAllRec(taskSel,methodKMean); % including non-run time

    PyrBehAlignedAllRec(0,taskSel); 
 
end

%% find neurons that are significantly changing their FRaft/FRbef
PyrInitPeakAllRecSig(); % calculate 
InterneuronInitPeakAllRecSig();

%% classify PyrUp and PyrDown neurons based on the FR change before and after the run onset
for taskSel = 2:3
    for pshuffle = 2:3
        PyrIntInitPeakSig(taskSel,pshuffle); % select the ones that has a significant change in FR around run onset       
    end
          %      (pshuffle = 1 -> 99.9%, 2 -> 99%, 3 -> 95%)
    PyrIntInitPeak(taskSel);

    PyrIntInitPeakRelRatio(taskSel); % using relative ratio instead of
             % direct 0to1s/befRun FR 
end

%% accumulation all the relevant data from every recordings for interneurons
InterneuronPropAllRec(onlyRun);

methodKMean = 2;
InterneuronModAccumAllRec(onlyRun,methodKMean);
for taskSel = 1:3
    InterneuronInitPeakAllRec(taskSel,methodKMean);
end
