function ProcessAllRecBehMusc()
%% process all the recordings of the muscimol infusion experiments


    RecordingListNT;
        
    accumulateRecDataMusc();
    accumRecDataRunStatMusc();
    accumRecDataCueStatMusc();
   
    plotAccumulateRecDataMusc();
    plotAccumulateRecDataCueMusc();
end

