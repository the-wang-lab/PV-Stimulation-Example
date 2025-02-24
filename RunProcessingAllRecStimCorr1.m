RecordingList;

onlyRun = 1;
% numRec = size(listRecordingsNoCuePath,1);
% for i = 1:numRec
%     disp(listRecordingsNoCuePath(i,:))
%     cd(listRecordingsNoCuePath(i,:));
%     ProcessingMice_smTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun);
%     ProcessingMice_smTrSpeedLick(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun,mazeSessionNoCue(i));
%     disp(listRecordingsNoCuePath(i,:))
%     ProcessingMice_smTr_GoodTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun,mazeSessionNoCue(i));
%     disp(listRecordingsNoCuePath(i,:))
%     ProcessingMice_smTrCtrlOnly(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun,mazeSessionNoCue(i));
%     FieldWidthLR_GoodTr(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),20,1,2,0,...
%         onlyRun,mazeSessionNoCue(i));
%     pause;
%     close all;
%     disp(listRecordingsNoCuePath(i,:))
%     ProcessingAligned(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun,mazeSessionNoCue(i),1);
%     disp(listRecordingsNoCuePath(i,:))
%     ProcessingAlignedRun0(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),mazeSessionNoCue(i),1);
%     close all;
%     disp(listRecordingsNoCuePath(i,:))
%     FieldWidthLRAligned(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),1,0,onlyRun,mazeSessionNoCue(i));
%     ProcessingAlignedCtrlOnly(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),onlyRun,mazeSessionNoCue(i));
%     ProcessingAlignedCtrlOnlyRun0(listRecordingsNoCuePath(i,:),listRecordingsNoCueFileName(i,:),mazeSessionNoCue(i));
% end

numRec = size(listRecordingsActiveLickPath,1);
recNo = [173];
for i = recNo
    % disp(listRecordingsActiveLickPath(i,:))
    % cd(listRecordingsActiveLickPath(i,:));
    % ProcessingMice_smTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun);
    % ProcessingMice_smTrSpeedLick(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i));
    % disp(listRecordingsActiveLickPath(i,:))
    % ProcessingMice_smTr_GoodTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i));
    % disp(listRecordingsActiveLickPath(i,:))
    % ProcessingMice_smTrCtrlOnly(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i));
    % FieldWidthLR_GoodTr(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),20,1,2,0,...
    %     onlyRun,mazeSessionActiveLick(i));
% %     pause;
    close all;
    disp(listRecordingsActiveLickPath(i,:))
    ProcessingAlignedStimCorrection(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i),4);
    disp(listRecordingsActiveLickPath(i,:))
    ProcessingAlignedRun0StimCorrection(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),mazeSessionActiveLick(i),4);
    close all;
    disp(listRecordingsActiveLickPath(i,:))
    FieldWidthLRAligned(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),1,0,onlyRun,mazeSessionActiveLick(i)); 
    % ProcessingAlignedCtrlOnly(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),onlyRun,mazeSessionActiveLick(i));
    % ProcessingAlignedCtrlOnlyRun0(listRecordingsActiveLickPath(i,:),listRecordingsActiveLickFileName(i,:),mazeSessionActiveLick(i));
end

% numRec = size(listRecordingsPassiveLickPath,1);
% for i = 1:numRec
%     disp(listRecordingsPassiveLickPath(i,:))
%     cd(listRecordingsPassiveLickPath(i,:)); 
% %     ProcessingMice_smTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun);
% %     ProcessingMice_smTrSpeedLick(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun,mazeSessionPassiveLick(i));
% %     disp(listRecordingsPassiveLickPath(i,:))
% %     ProcessingMice_smTr_GoodTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun,mazeSessionPassiveLick(i));
% %     disp(listRecordingsPassiveLickPath(i,:))
% %     ProcessingMice_smTrCtrlOnly(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun,mazeSessionPassiveLick(i));
% %     FieldWidthLR_GoodTr(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),20,1,2,0,...
% %         onlyRun,mazeSessionPassiveLick(i));
% %     pause;
%     close all;
%     disp(listRecordingsPassiveLickPath(i,:))
%     ProcessingAligned(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun,mazeSessionPassiveLick(i),3);
%     disp(listRecordingsPassiveLickPath(i,:))
%     ProcessingAlignedRun0(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),mazeSessionPassiveLick(i),3);
%     close all;
%     disp(listRecordingsPassiveLickPath(i,:))
%     FieldWidthLRAligned(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),1,0,onlyRun,mazeSessionPassiveLick(i));
%     ProcessingAlignedCtrlOnly(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),onlyRun,mazeSessionPassiveLick(i));
%     ProcessingAlignedCtrlOnlyRun0(listRecordingsPassiveLickPath(i,:),listRecordingsPassiveLickFileName(i,:),mazeSessionPassiveLick(i));
% end
% 
numRec = size(listRecordingsPassiveLickBlackoutNoCuePath,1);
for i = 1:numRec
    disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
    cd(listRecordingsPassiveLickBlackoutNoCuePath(i,:));
%     ProcessingMice_smTr(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun);
%     ProcessingMice_smTrSpeedLick(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun,mazeSessionPassiveLickBlackoutNoCue(i));
%     disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
%     ProcessingMice_smTr_GoodTr(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun,mazeSessionPassiveLickBlackoutNoCue(i));
%     disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
%     ProcessingMice_smTrCtrlOnly(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun,mazeSessionPassiveLickBlackoutNoCue(i));
%     FieldWidthLR_GoodTr(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),20,1,2,0,...
%         onlyRun,mazeSessionPassiveLickBlackoutNoCue(i));
%     pause;
%     close all;
%     disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
%     ProcessingAligned(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun,mazeSessionPassiveLickBlackoutNoCue(i),1);
%     disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
%     ProcessingAlignedRun0(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),mazeSessionPassiveLickBlackoutNoCue(i),1);
%     close all;
%     disp(listRecordingsPassiveLickBlackoutNoCuePath(i,:))
%     FieldWidthLRAligned(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),1,2,onlyRun,mazeSessionPassiveLickBlackoutNoCue(i)); 
%     ProcessingAlignedCtrlOnly(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),onlyRun,mazeSessionPassiveLickBlackoutNoCue(i));
%     ProcessingAlignedCtrlOnlyRun0(listRecordingsPassiveLickBlackoutNoCuePath(i,:),listRecordingsPassiveLickBlackoutNoCueFileName(i,:),mazeSessionPassiveLickBlackoutNoCue(i));
end