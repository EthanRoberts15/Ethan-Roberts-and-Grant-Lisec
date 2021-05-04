function [] = animateCropYields()
    close all;
    global gui;
    gui.fig = figure();
    gui.p = plot(0,0);
    gui.p.Parent.Postition = [0.2 0.25 0.7 0.7];
    
    gui.buttonGroup = uibuttongroup('visible','on','units','normalized',[0 .04 .15 .25],'selectionchangedfcn',(@radioSelect));
    gui.r1 = uicontrol(guibuttonGoup,'style','radiobutton','units','normalized','position',[.1 .8 1 .2],'HandleVisibility','off','string','Corn');
    gui.r2 = uicontrol(guibuttonGoup,'style','radiobutton','units','normalized','position',[.1 .5 1 .2],'HandleVisibility','off','string','Soybeans');
    gui.r3 = uicontrol(guibuttonGoup,'style','radiobutton','units','normalized','position',[.1 .2 1 .2],'HandleVisibility','off','string','Milo');
    
    gui.scrollBar = uicontrol('style','slider','units','normalized','position',[0.2 0.10 .6 0.05],'value',1,'min',1,'max',12,'sliderstep',[1/11 1/11],'callback',(@scrollbar));
    scrollbar();
    gui.animateButton = uicontrol('style','pushbutton','units','normalized','position',[0.05 0.05 0.1 0.1],'string','Animate',(@animate));

  gui.p = plot(1:length('seasonYields'),'seasonYields','bx');
switch currentSeason
    case 1
        seasonString = 'Fall 2010';
    case 2
        seasonString = 'Fall 2011';
    case 3
        seasonString = 'Fall 2012';
    case 4
        seasonString = 'Fall 2013';
    case 5
        seasonString = 'Fall 2014';    
    case 6
        seasonString = 'Fall 2015';
    case 7
        seasonString = 'Fall 2016';
    case 8
        seasonString = 'Fall 2017';
    case 9
        seasonString = 'Fall 2018';    
    case 10
        seasonString = 'Fall 2019';
        
end  
    
end
function [] = animate(~,~)
    global gui;
    for i =1:10
        gui.scrollBar.Value = i;
        scrollbar();
        pause(1);
    end
end
    
function [] = scrollbar(~,~)
    global gui;
    gui.scrollBar.Value = round(gui.scrollBar.Value);
    type = gui.buttonGroup.SelectedObject.String;
    plotCurrentSeason(type);
 end
    
function [] = radioSelect(~,~)
    global gui;
    type = gui.buttonGroup.SelectedObject.String;
    plotCurrentSeason(type);
end

function [] = plotCurrentSeason(type)
    global gui;
    data = readmatrix('yields.csv');
    seasonListing = data(:,1);
    yields = data(:,2);
    
    CurrentSeason = gui.scrollBar.Value;
    seasonYields = yields(seasonListing == CurrentSeason);
    if strcmp(type,'Soybeans')
        seasonYields = (seasonYields - 54);
    elseif strcmp(type,'Milo')
        seasonYields = (seasonYields - 125)
    end
end