%% Demonstration of truncation error
dx = 0.0001;
x  = 0:dx:0.7;

f1 = 1 - x;
f2 = 1 - x + x.^2;
f3 = 1 - x + x.^2 - x.^3;
f4 = 1 - x + x.^2 - x.^3 + x.^4;
exact = 1./(1+x);

%% Creation of figures
% Create figure
figure1 = figure;
% Create axes
axes1 = axes('Parent',figure1,'FontSize',20);
xlim(axes1,[0 0.7]);
ylim(axes1,[0 4]);
box(axes1,'on');
hold(axes1,'on');
% Create loglog
plot(x,f1,'LineWidth',2,'Color','r');
hold on;
plot(x,f2,'LineWidth',2,'Color',[.1 .9 .1]);
plot(x,f3,'LineWidth',2,'Color','b');
plot(x,f4,'LineWidth',2,'Color','cy');
plot(x,exact,'--','LineWidth',2,'Color','k');

legend('f(x)=1-x','f(x)=1-x+x^2','f(x)=1-x+x^2-x^3','f(x)=1-x+x^2-x^3+x^4','Exact','Location','best')
%legend('f(x)=1/(1+x)','Location','best')

%save the figure for powerpoint
print('TE_example','-dpng','-r600')

disp(f1(0.5))