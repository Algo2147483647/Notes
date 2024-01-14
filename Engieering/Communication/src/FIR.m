clc;clear all;
fp=5E3;fs=6E3;Ts=1/2E4;N=51;bp=0.001;bs=0.01;%bp:ͨ������ϵ�� %bs:�������ϵ��
wp=2*pi*fp*Ts;ws=2*pi*fs*Ts;wc=(ws+wp)/2;%wc��ֹƵ��
%======================> kaiser����������============================
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
hd=Ideal_LP(wc,N);  %�����ͨ�ĳ弤��Ӧ
w_Window=(kaiser(N,Belta))';
h=hd.*w_Window      %�Ӵ�,ʱ����� %FIR�˲����ĳ弤��Ӧ
ans=ceil(h.*(2^8-1))
%======================> ============================
[db,mag,pha,grd,w]=freqz_m(h,[1]); %FIR���㶼��Բ��
DeltaW=2*pi/1000;
Rp=-(min(db(1:1:wp/DeltaW+1)))
As=-round(max(db(ws/DeltaW+1:1:501)))
%======================> Show It============================
figure(1);
subplot(2,3,1);stem(n,hd);title('����弤��Ӧ')
axis([0 N-1 -0.1 0.3]);
subplot(2,3,2);stem(n, w_Window);title('������');
axis([0 N-1 0 1.1]);xlabel('n');ylabel('w(n)')
subplot(2,3,3);stem(n,h);title('ʵ�ʳ弤��Ӧ')
axis([0 N-1 -0.1 0.3]);xlabel('n');ylabel('h(n)')
%==========
subplot(2,3,4);plot(w/(2*pi*Ts),mag);title('������Ӧ');grid;
%axis([0 0.8 0 1.1]);ylabel('����');xlabel('��\piΪ��λ��Ƶ��')
subplot(2,3,5);plot(w/(2*pi*Ts),db);title('������Ӧ(dB)');grid;
%axis([0 0.8 -100 1]);ylabel('��������/dB');xlabel('��\piΪ��λ��Ƶ��')
subplot(2,3,6);plot(w/(2*pi*Ts),pha);title('��λ��Ӧ');grid;
%axis([0 0.8 -4 4]);xlabel( '��\piΪ��λ��Ƶ��');ylabel('��λ')
% subplot(3,2,4);plot(w/pi,grd);title('Ⱥ�ӳ�');grid;
% axis([0 0.8 0 15]);xlabel( '��\piΪ��λ��Ƶ��');ylabel('����')
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function hd =Ideal_LP(wc,M) %�����ͨ��λ������Ӧ:Hlp[n] = sin(Wc*n) / pi*n; n=(-inf,inf)
% n=-(N-1)/2:(N-1)/2;
% hd=sin(wc*n)./(pi*n);
alpha=(M-1)/2;
n=[0:1:(M-1)];
m=n-alpha +eps;
hd=sin(wc*m)./(pi*m);
end
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function [db,mag,pha,grd,w] = freqz_m(b,a);%����IIR��Ƶ����Ƶ��Ӧ
%b,a:Transfer function coefficients
[H,w] = freqz(b,a,1000,'whole');    %�����˲�������Ӧ
H = (H(1:1:501))'; w = (w(1:1:501))';
mag = abs(H);   %��Ƶ��Ӧ
db = 20*log10((mag+eps)/max(mag));%������Ƶ��Ӧ
pha = angle(H); %��Ƶ��Ӧ
grd = grpdelay(b,a,w);%Ⱥʱ��
end
%��Ҫ����Դ�ڡ������źŴ����α�%������ֲ����湽LiGu������~