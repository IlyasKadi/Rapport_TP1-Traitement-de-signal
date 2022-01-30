clear all;
close all;
clc;

%--------------I------------------
figure(1);
%--------------1------------------
Te=1/50;
x=[0:Te:10-Te];
y = sin(30*pi*x) + sin(40*pi*x);
subplot(3,2,1);
plot(x,y);
title('signal x(t) :');


%--------------2------------------
f=(0:length(x)-1)*(1/Te*length(x)); 
fy=abs(fft(y));
subplot(3,2,2);
plot(f,fy);
title('spectre du  x(t) :');


%--------------3------------------
fsh=[-500/2:(500/2)-1]*50/500;
fy=abs(fft(y));
subplot(3,2,3);
plot(fsh,fftshift(fy));
title('spectre du  x(t) :');


%--------------4------------------
w_noise = randn(size(x));
subplot(3,2,4);
plot(w_noise);
title('noise');

%--------------5------------------
fy2 = abs(fft((y+w_noise))); 
DS=(fy2.^2)/length(x);
subplot(3,2,5);
plot(fsh,fftshift(DS));
title('x(t) noised');

fy2 = abs(fft((y+1.5*w_noise))); 
subplot(3,2,6);
plot(fsh,fftshift(fy2.^2));
title('x(t) noised (old noise*1.5)');




%--------------II------------------
figure(2);
%--------------1------------------
whaleFile = fullfile(matlabroot,'examples','matlab','data','bluewhale.au');
[w,ft] = audioread(whaleFile);
interval=w(2.45e4:3.10e4);


%--------------2------------------
soundsc(w,ft);

%--------------3------------------
subplot(2,1,1);
Nint=length(interval);
t=[0:Nint-1]*1/ft;
plot(t,interval);
title('Bluewhale signal');
%DS de la puissance du signal
fshift=[-Nint/2:Nint/2-1]*(ft/Nint)/10;
DSP=abs(fft(interval).^2/Nint);
subplot(2,1,2);
plot(fshift,fftshift(DSP));
title('DS de la puissance du signal')



