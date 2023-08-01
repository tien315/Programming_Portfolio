% ME 341 Experiment #3: Vibrations.  This code computes FFT of a discre signal. 
% Add your name below.  
% After running Simulink, run this code in Matlab.

name = 'Alan Tieng';   % your name

%%%%%%%%%%%% DO NOT MODIFY BELOW THIS LINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=1/0.001;     % sampling frequency = 10,000 Samples/s
                % Equal to inverse of Simulink model fixed-step size, which is
                % set to 0.001 s

% Taking the FFT to see the frequency content
NFFT=2^ceil(log2(length(out.F)));   % number of points to use to compute the FFT, always choose power of 2 for speedy code execution
fw=fs*(-NFFT/2:NFFT/2-1)/NFFT;      % compute frequencies

%FFT of input signal F(t)
xw_F=fftshift(fft(out.F,NFFT));     % compute FFT with mean at f=0;

%FFT of output signal x(t)
xw_x=fftshift(fft(out.x,NFFT));       % compute FFT with mean at f=0;
xw_x_smooth = zeros(length(xw_x),1);

for i=3:length(xw_x)-2
    xw_x_smooth(i) = (xw_x(i)+xw_x(i+1)+xw_x(i+2)+xw_x(i-1)+xw_x(i-2))/5;
end

date = datestr(datetime);

% Plot spectrum
figure(1)
subplot(2,1,1)
plot(fw,abs(xw_F)); xlabel('Frequency (Hz)'); ylabel('FFT Magnitude for F(t)'); 
xlim([-10, 10]); 
subplot(2,1,2)
plot(fw,abs(xw_x_smooth)); xlabel('Frequency (Hz)'); ylabel('FFT Magnitude for x(t)');
xlim([-10, 10]); ylim([0 9]); text(-8,7.5,name,'fontsize',7); text(-8.7,7.0,date,'fontsize',7); 

% Zoom in on the FFT plot for x(t)
figure(2)
plot(fw,abs(xw_x_smooth)); xlabel('Frequency (Hz)'); ylabel('FFT Magnitude for x(t)'); 
xlim([0, 4]); ylim([0 4]); text(2.5,8.5,name,'fontsize',7); text(2.5,8.0,date,'fontsize',7); 