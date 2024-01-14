clear, close all, clf; 

%% 参数
Fs = 3000; Ts = 1/Fs;   % Sampling frequency % Sampling period  
Rb = 100;   Tb = 1/Rb;   %码元速率 %码元时间
Fc = 1000;

SignalNum = 64;
t = Ts : Ts : SignalNum * Tb;    %时间
L = length(t);

%% 信源
Signal = randi([0 1], 1, SignalNum);
S = zeros(size(t));
for i = 1 : length(t)
    S(i) = Signal(ceil(t(i) / Tb));
end
X = S .* exp(1j*2*pi * Fc * t);

% 绘图
subplot(5,1,1); plot(Signal);
subplot(5,1,2); plot(S);
subplot(5,1,3); plot(real(X));

ff = fft(S); 
P2 = abs(ff/L); 
P1 = P2(1:L/2+1); 
P1(2:end-1) = 2*P1(2:end-1);
fP1 = Fs*(0:(L/2))/L;
subplot(5,1,4); plot(fP1, P1);

ff = fft(real(X)); 
P2 = abs(ff/L); 
P1 = P2(1:L/2+1); 
P1(2:end-1) = 2*P1(2:end-1);
fP1 = Fs*(0:(L/2))/L;
subplot(5,1,5); plot(fP1, P1);
figure();


%% 信道
PathNum = 10;
Y = zeros(1, length(t));

for i = 1 : PathNum
    delay_i = abs(Ts * (50 * randn() + 1));
    Fi = Fc/100 * randn();

    H_dirac = zeros(1, length(t));
    H_dirac(ceil(delay_i / Ts)) = 1;
    H_i = H_dirac .* exp(1j*2*pi * (Fi * t - (Fc + Fi) * delay_i));
    
    Y_i = conv(X, H_i) + 0.05 * randn(1, 2 * length(t) - 1);
    Y = Y + 1/PathNum * Y_i(1 : length(t));
end


% 绘图
subplot(2,1,1); hold on; plot(real(X)); plot(real(Y));

subplot(2,1,2);  hold on; 
ff = fft(real(X)); 
P2 = abs(ff/L); 
P1 = P2(1:L/2+1); 
P1(2:end-1) = 2*P1(2:end-1);
fP1 = Fs*(0:(L/2))/L;
plot(fP1, P1);

ff = fft(real(Y)); 
P2 = abs(ff/L); 
P1 = P2(1:L/2+1); 
P1(2:end-1) = 2*P1(2:end-1);
fP1 = Fs*(0:(L/2))/L;
plot(fP1, P1);

%figure();
