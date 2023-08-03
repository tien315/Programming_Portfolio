plot(1:5)
xTick = 1:5;
set(gca,'xtick',xTick)
yTick = get(gca,'ytick');
set(gca,'xticklabel',[])
xTickLabel = {{'first';'label'},'second',{'third';'label'},'long fourth tick label ','fifth'};
for k = 1:length(xTick)
    text(xTick(k),yTick(1)-0.05*(yTick(end)-yTick(1)),xTickLabel{k},'HorizontalAlignment','center')
end