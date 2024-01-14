clc;clear all;
fp=5E3;fs=6E3;Ts=1/2E4;N=51;bp=0.001;bs=0.01;%bp:通带波纹系数 %bs:阻带波纹系数
wp=2*pi*fp*Ts;ws=2*pi*fs*Ts;wc=(ws+wp)/2;%wc截止频率
%======================> kaiser窗参数计算============================
A=-20*log10(bp);
Belta = 0;
if A > 50
    Belta = 0.1102 * (A-8.7);
elseif A>=21&&A<=50
    Belta = 0.5842 * (A-21)^0.4 + 0.07886 * (A-21);
end
M=ceil((A - 8)/(2.285*(ws-wp)));
%======================> |============================
n=[0:N-1];
hd=Ideal_LP(wc,N);  %理想低通的冲激响应
w_Window=(kaiser(N,Belta))';
h=hd.*w_Window      %加窗,时域相乘 %FIR滤波器的冲激响应
ans=ceil(h.*(2^8-1))
%======================> ============================
[db,mag,pha,grd,w]=freqz_m(h,[1]); %FIR极点都在圆心
DeltaW=2*pi/1000;
Rp=-(min(db(1:1:wp/DeltaW+1)))
As=-round(max(db(ws/DeltaW+1:1:501)))
%======================> Show It============================
figure(1);
subplot(2,3,1);stem(n,hd);title('理想冲激响应')
axis([0 N-1 -0.1 0.3]);
subplot(2,3,2);stem(n, w_Window);title('窗函数');
axis([0 N-1 0 1.1]);xlabel('n');ylabel('w(n)')
subplot(2,3,3);stem(n,h);title('实际冲激响应')
axis([0 N-1 -0.1 0.3]);xlabel('n');ylabel('h(n)')
%==========
subplot(2,3,4);plot(w/(2*pi*Ts),mag);title('幅度响应');grid;
%axis([0 0.8 0 1.1]);ylabel('幅度');xlabel('以\pi为单位的频率')
subplot(2,3,5);plot(w/(2*pi*Ts),db);title('幅度响应(dB)');grid;
%axis([0 0.8 -100 1]);ylabel('对数幅度/dB');xlabel('以\pi为单位的频率')
subplot(2,3,6);plot(w/(2*pi*Ts),pha);title('相位响应');grid;
%axis([0 0.8 -4 4]);xlabel( '以\pi为单位的频率');ylabel('相位')
% subplot(3,2,4);plot(w/pi,grd);title('群延迟');grid;
% axis([0 0.8 0 15]);xlabel( '以\pi为单位的频率');ylabel('样本')
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function hd =Ideal_LP(wc,M) %理想低通单位脉冲响应:Hlp[n] = sin(Wc*n) / pi*n; n=(-inf,inf)
% n=-(N-1)/2:(N-1)/2;
% hd=sin(wc*n)./(pi*n);
alpha=(M-1)/2;
n=[0:1:(M-1)];
m=n-alpha +eps;
hd=sin(wc*m)./(pi*m);
end
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function [db,mag,pha,grd,w] = freqz_m(b,a);%计算IIR幅频、相频相应
%b,a:Transfer function coefficients
[H,w] = freqz(b,a,1000,'whole');    %数字滤波器的响应
H = (H(1:1:501))'; w = (w(1:1:501))';
mag = abs(H);   %幅频响应
db = 20*log10((mag+eps)/max(mag));%对数幅频响应
pha = angle(H); %相频响应
grd = grpdelay(b,a,w);%群时延
end
%主要代码源于《数字信号处理》课本%电设俱乐部：梨菇LiGu，参上~