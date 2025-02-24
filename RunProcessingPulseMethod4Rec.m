RecordingListPyrInt;
numRec = size(listRecordingsActiveLickPath,1);
onlyRun = 1;
for i = 77:77 %numRec
    cd(listRecordingsActiveLickPath(i,:));
    load([listRecordingsActiveLickFileName(i,:) '_Info.mat']);
    pm = unique(beh.pulseMethod);
    if(sum(pm == 4) > 0)
        disp(listRecordingsActiveLickPath(i,:))
        ProcessingAligned(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i),4);
        disp(listRecordingsActiveLickPath(i,:))
        ProcessingAlignedRun0(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),mazeSessionActiveLick(i),4);
    end
end