clear all
x = textread('temps.txt');
x_bar = geomean(x);
plot(1:length(x), x, 'bo', 'MarkerSize', 10)
hold on;
y(1:length(x)) = deal(x_bar);
plot(1:length(x), y, 'r');
grid on;
legend('data','avg');
ylabel("Temperature, " + native2unicode(176) + "F)")
xlabel("days");

function x_bar = geomean(x)
x_bar = length(x)/sum(x.^(-1));
end