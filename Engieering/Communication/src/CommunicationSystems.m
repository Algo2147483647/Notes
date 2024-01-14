clear all;close all;clc;
%% 基本参数
fs0 = 3; Ts0 = 1/fs0;                    % fs0信源频率 
fs = 50; trellis = 0:1/fs:1;                    %fs采样频率
%% *********************** 发送端 ********************************
%**************************************************************************
%% 信源——随机信号发生
SignalSourceNum = 3;
s0 = sin(2*pi*fs0*trellis);                                                       % 正弦波信号发生
s1 = trellis; s1(mod(s1,Ts0)<Ts0/2) = 1; s1(s1~=1)=0;                         % 矩形波信号发生
s2 = s1; s2(s2==0) = -1;s2 = cumsum(s2);s2 = s2/max(s2);                                  % 三角波信号发生
s0 = (s0+1)/2;
SignalSource = zeros(3,length(trellis));
SignalSource(1,:) = s0;
SignalSource(2,:) = s1;
SignalSource(3,:) = s2;
figure;
subplot(311);plot(SignalSource(1,:));
subplot(312);plot(SignalSource(2,:));
subplot(313);plot(SignalSource(3,:));
%% 时分复用TDMA
SignalTdma = TDMA(SignalSource);
figure;
subplot(321);stairs(SignalTdma(1:300));title("TDMA前300码元");hold on;plot(0,1.2);
%% 卷积码编码
% trellis = poly2trellis(ConstraintLength,CodeGenerator) 将卷积码多项式转换成MATLAB的trellis网格表达式
% convenc(msg,t) 卷积码编码库函数
trellis = poly2trellis(3,[7 5]); 
SignalConvCode = SignalTdma;          %卷积码编码
SignalConvCodeT = convenc(SignalTdma,trellis);
subplot(322);stairs(SignalConvCode(1:300));title("卷积码编码前300");hold on;plot(0,1.2);
%% GMSK数字调制
Rb= fs * 8;                     %码元速率
SampleNumber = 64;             %采样点数 
fc = 900;                    %载波频率
[SignalGMSK,ThetaGmsk] = GMSK(SignalConvCode,SampleNumber,fc,Rb);
subplot(312);plot(1:3000,SignalGMSK(1:3000));title("GMSK数字调制");
%% *********************** 接收端 ********************************
%**************************************************************************
%% GMSK数字非相干解调
SignalDeGMSK = DeGMSK(SignalGMSK,ThetaGmsk,fc,Rb,SampleNumber);
figure;
subplot(311);plot(1:6000,SignalDeGMSK(1:6000));title("GMSK解调");
% 低通滤波
SignalDeGMSK_F = fft(SignalDeGMSK);
for i = 500:length(SignalDeGMSK_F)-500+1
    SignalDeGMSK_F(i) = 0;
end
SignalDeGMSK = ifft(SignalDeGMSK_F);
subplot(412);plot(1:6000,SignalDeGMSK(1:6000));title("GMSK解调");
subplot(413);plot(1:1200*SampleNumber,SignalDeGMSK(1:1200*SampleNumber));title("GMSK解调");hold on;plot(0,1.2);
% 采样判决
cur = 1;
for i = SampleNumber/2:SampleNumber :length(SignalDeGMSK)
    s_deGMSKT(cur) = SignalDeGMSK(i);
    cur = cur + 1;
end
Threshold = 0.15;
SignalDeGMSK = s_deGMSKT;SignalDeGMSK(s_deGMSKT<Threshold) = 1; SignalDeGMSK(s_deGMSKT>=Threshold) = 0;
subplot(414);stairs(SignalDeGMSK(1:1200));title("GMSK解调");hold on;plot(0,1.2);
%% 卷积码解码
% decoded = vitdec(code,trellis,tblen,opmode,dectype) 卷积码解码库函数  'soft'软判决
SignalDeConvCode = vitdec(SignalConvCodeT,trellis,1,'cont','hard');
for i = 1:length(SignalDeConvCode)-1
    SignalDeConvCode(i) = SignalDeConvCode(i+1);
end
figure(10);subplot(311);stairs(SignalTdma(1:1000));title("原");hold on;plot(0,1.2);
figure(10);subplot(312);stairs(SignalDeConvCode(1:1000));title("卷积码解调");hold on;plot(0,1.2);
%% 时分复用解复用
SignalDeTdma  = DeTDMA(SignalDeConvCode,SignalSourceNum);
figure;
subplot(311);plot(SignalDeTdma(1,:));title("TDMA解复用");
subplot(312);plot(SignalDeTdma(2,:));title("TDMA解复用");
subplot(313);plot(SignalDeTdma(3,:));title("TDMA解复用");



%% *********************** 核心函数 ********************************
%**************************************************************************
%% 时分复用TDMA - Function
function [SignalTdma] = TDMA(Signal)
SignalNum = size(Signal,1);
SignalTdma = zeros(1,8 * SignalNum * size(Signal,2));
cur = 1;
for tt = 1:size(Signal,2)
    for signalIndex = 1 : SignalNum                         % 依此对三个波形
        temp = Signal(signalIndex,tt);
        temp = bitget(int8(temp*128),8:-1:1);   % 目标数值，转二进制，按位取出
        SignalTdma(cur:cur+7) = temp;               % 二进制存入s_tdma时分复用信号波形中
        cur = cur+8;
    end
end
end
%% 时分复用解复用 - Function
function [SignalDeTdma] = DeTDMA(Signal, SignalNum)
SignalDeTdma = zeros(SignalNum,length(Signal)/SignalNum/8);
for signalIndex = 1 : SignalNum                   %各时序解复用
    cur = 1;
    for tt = 1 + 8*(signalIndex-1):3*8:length(Signal)-3*8           %对于第一路信号时隙，二进制转十进制
        for i = 1:8
            SignalDeTdma(signalIndex,cur) = SignalDeTdma(signalIndex,cur) * 2 + Signal(tt+i);
        end
        SignalDeTdma(signalIndex,cur) = SignalDeTdma(signalIndex,cur)/128;
        cur = cur +1;
    end
end
end
%% 差分编码
function [SignalDiff] = DiffCode(Signal)
SignalDiff=zeros(1,length(Signal));
SignalDiff(1) = Signal(1);                       % c0 = a0
for i = 2 : length(Signal)
    SignalDiff(i)=xor(SignalDiff(i-1),Signal(i));    % ck = ck-1 * ak
end
end
%% [2]高斯滤波器Gasse
function [SignalGasse] = GasseFliter(Signal,xb,Rb,fs)
a = sqrt(2/log(2))*xb*Rb;
f = 1:length(Signal);f=f*fs/2/length(Signal);
H = exp(-(f.^2/a.^2));
SignalGasse = ifft( fft(Signal) .* H );
SignalGasse = real(SignalGasse);
end
%% GMSK数字调制  - Function
function [SignalGMSK,ThetaGmsk] = GMSK(Signal,SampleNumber,fc,Rb)
fs = Rb*SampleNumber;          %采样频率
SignalDiff = (Signal);          %差分编码
SignalDiff(SignalDiff==0)=-1;           %转双极性码
%转模拟信号
SignalAnalog = zeros(1,length(SignalDiff)*SampleNumber);
for i=1:SampleNumber
    SignalAnalog(i:SampleNumber:length(SignalDiff)*SampleNumber)=SignalDiff;
end
%高斯滤波
xb = 0.6;[SignalGasse] = GasseFliter(SignalAnalog,xb,Rb,fs);                %高斯滤波
subplot(313);plot(1:30000,SignalGasse(1:30000));title("GMSK高斯滤波后");
%GMSK相位路径: θ(t) = θ(k·Tb) + Δθ(t)         % θ(t)可通过对Δθ(t)的累加得到
%正交调制 s_GMSK = cos[θ(t)]·cos(Ωct) - sin[θ(t)]·sin(Ωct)
ThetaGmsk = cumsum(SignalGasse);
t = 1/fs:1/fs:length(Signal)*1/Rb;    %时间
SignalGMSK = cos(2*pi*fc*t).*cos(ThetaGmsk) - sin(2*pi*fc*t).*sin(ThetaGmsk); %s_GMSK
end
%% GMSK数字非相干解调
function [SignalDeGMSK] = DeGMSK(SignalGMSK,ThetaGmsk,fc,Rb,SampleNumber)
%   (1bt延迟差分解调) % 延迟1bt，移相pi/2  
ThetadeGmsk = ThetaGmsk;
for i = 1 : length(ThetaGmsk)             %延迟1bt，移相pi/2 GMSK波形
    if i <= SampleNumber   % 1bt内
        ThetadeGmsk(i)=0;      % Alpha 前1bt 置0
    else
        ThetadeGmsk(i)=ThetaGmsk(i-SampleNumber);%右移1bt
    end
end
ThetadeGmsk = ThetadeGmsk + pi/2;       %移相pi/2
fs = Rb*SampleNumber;          %采样频率
t = 1/fs:1/fs:length(SignalGMSK)/SampleNumber*1/Rb;    %时间
SignalDeGMSK = cos(2*pi*fc*t).*cos(ThetadeGmsk) - sin(2*pi*fc*t).*sin(ThetadeGmsk); %s_GMSK
SignalDeGMSK = SignalDeGMSK .* SignalGMSK;% 相乘
end