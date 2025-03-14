function PyrNaiveBayesEncoder()

    RecordingListPyrInt;  % include all the early NoCue (no blackout), PL and AL (up to A057)
    
    onlyRun = 0;

    for upDown = 3
%         NaiveBayesClassifier(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,upDown,1,onlyRun);
        
        NaiveBayesClassifierGpu2(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
        
        NaiveBayesClassifierGpu2(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
        
        close all;
    end

    
%     
%     for upDown = 3
% %         NaiveBayesClassifier(listRecordingsNoCuePath,listRecordingsNoCueFileName,mazeSessionNoCue,upDown,1,onlyRun);
%         
%         NaiveBayesClassifier(listRecordingsActiveLickPath,listRecordingsActiveLickFileName,mazeSessionActiveLick,upDown,2,onlyRun);
%         
%         NaiveBayesClassifier(listRecordingsPassiveLickPath,listRecordingsPassiveLickFileName,mazeSessionPassiveLick,upDown,3,onlyRun);
%         
%         close all;
%     endc