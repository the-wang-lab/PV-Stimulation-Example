function plotIndNeuronStimVsCtrl(path,filename,indPyr,timeStep,avgFRProfileStim,avgFRProfile,...
    indRec,indNeu)
    % Assuming PyrRiseMidCueAct.indPyrAct, PyrStim.avgFRProfileStim, and PyrStim.avgFRProfile are already defined

    for i = 1:length(indPyr)
        f = figure('Position', [400, 400, 250, 250]);
        plot(timeStep,avgFRProfileStim(indPyr(i),:), 'r');
        hold on;
        plot(timeStep,avgFRProfile(indPyr(i),:), 'b');
        hold off;

        % Set font size for the current figure
        ax = gca; % Get current axis
        ax.FontSize = 12;
        ax.XLim = [-1 4];
        xlabel('Time(s)');
        ylabel('FR(Hz)');

        % Save the figure
        fileNameFig = [path,filename,'-rec' num2str(indRec(i)) '-neu' num2str(indNeu(i))];
        savefig(f, [fileNameFig, '.fig']); % Save as .fig
        print('-painters', '-dpdf', fileNameFig, '-r600'); % Save as .pdf
    end
   
end