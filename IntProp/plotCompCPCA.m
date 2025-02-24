function plotCompCPCA(x,y,z,xl,yl,zl,idx,ti,xlimit,ylimit,zlimit)
    if(nargin == 8)
        xlimit = [];
        ylimit = [];
        zlimit = [];
    end
    [figNew,pos] = CreateFig();
    set(0,'Units','pixels')
    set(figure(figNew),'OuterPosition',...
            [pos(1) pos(2) 400 400])
    colorArr = [51/255 102/255 255/255;...      
                218/255 179/255 255/255;...                
                255/255 100/255 100/255;...   
                0.9 0.9 0.3;...
                0.3 0.9 0.3;...
                59/255 113/255 86/255;...           
                0.2 0.8 0.5;...
                0.8 0.5 0.2;...
                0.3 0.7 0.3];
    
    for i = 1:max(idx)
        indTmp = idx == i;
        disp(['Cluster' num2str(i) ' has ' num2str(sum(indTmp)) ' components']);
        h = plot3(x(indTmp),y(indTmp),z(indTmp),'.');
        set(h,'MarkerSize',11,'Color',colorArr(mod(i,max(idx))+1,:));
        if(i == 1)
            hold on;
        end
    end
    if(isempty(xlimit))
        maxX = max(x);
        minX = min(x);        
    else
        maxX = xlimit(2);
        minX = xlimit(1);
    end
    if(isempty(ylimit))
        maxY = max(y);
        minY = min(y);        
    else
        maxY = ylimit(2);
        minY = ylimit(1);
    end
    if(isempty(zlimit))
        maxZ = max(z);
        minZ = min(z);        
    else
        maxZ = zlimit(2);
        minZ = zlimit(1);
    end
    set(gca,'XLim',[minX maxX],'YLim',[minY maxY]);
    xlabel(xl)
    ylabel(yl)
    zlabel(zl)
    title(ti);
end