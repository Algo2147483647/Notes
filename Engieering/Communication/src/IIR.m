clear all;clc;
wp=0.2*pi;ws=0.3*pi;Rp=1;As=45;
T=1;Fs=1/T;
%OmgP:通带角频率 %OmgS:阻带角频率 %fp:通带截止频率 %fs:阻带截止频率
%bp:通带波纹系数 %bs:阻带波纹系数 %Ap:通带增益 %As:阻带增益 %Td=1
%======================> ============================
OmgP=(2/T)* tan(wp/2);    %预畸变
OmgS=(2/T)* tan(ws/2);    %预畸变
[cs,ds,s,N,Ak]=Buttap(OmgP,OmgS,Rp,As);
%$$$$$$$$$$$$$$$$$$$$$$$$
syms z Hz(z)
Hz(z)=0;
esk=exp(s(1:N))
for i = 1:N
    Hz=Hz+Ak/(1-esk(i)*z^-1);
end
i = 0:pi/100:pi;
plot(i, abs(Hz(exp(i*1j))) );figure;
%$$$$$$$$$$$$$$$$$$$$$$$$
[b,a]=bilinear(cs,ds,Fs);
%fvtool(b,a,'Fs',Fs);figure; %显示IIR幅频曲线
[db,mag,pha,grd,w]=freqz_m(b,a); %计算IIR幅频、相频相应
%======================> IIR直联->级联============================
%[C,B,A]=sdir2cas(b,a);  %IIR直联->级联
%======================> Show It============================
subplot(2,2,1);plot(w/pi,mag);title('幅度响应');grid;
axis([0 0.8 0 1]);ylabel('幅度');xlabel('以\pi为单位的频率')
subplot(2,2,3);plot(w/pi,db);title('幅度响应(dB)');grid;
axis([0 0.8 -60 0]);ylabel('对数幅度/dB');xlabel('以\pi为单位的频率')
subplot(2,2,2);plot(w/pi,pha);title('相位响应');grid;
axis([0 0.8 -4 4]);xlabel( '以\pi为单位的频率');ylabel('相位')
subplot(2,2,4);plot(w/pi,grd);title('群延迟');grid;
axis([0 0.8 0 15]);xlabel( '以\pi为单位的频率');ylabel('样本')
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function[b,a,s,N,Ak]=Buttap(OmgP,OmgS,Ap,As)   % 模拟巴特沃斯滤波器设计函数
%=================> 阶数N,截止频率OmgC==============================
Ap = 10^(-Ap/20);   %dB->倍数
As = 10^(-As/20);   %dB->倍数
%巴特沃斯幅度公式：|H(j * Omg)|^2 = 1 / [1 + Omg/OmgC]^2N
%=======求阶数N======
% 1+(OmgP/OmgC)^(2*N)==1/Ap^2;  1+(OmgS/OmgC)^(2*N)==1/As^2;
% 通过通带、阻带截止点 + 巴特沃斯幅度公式，构建二元一次不等式。
% 解得 N = {log10[(1/Ap)^2 -1] - log10[(1/As)^2 -1]} / 2log10[OmgP/OmgS]
N = log10( (1/Ap^2 - 1)/(1/As^2 - 1) );
N = N / ( 2 * log10(OmgP/OmgS) );
N = ceil(N);    % N取整重算
%=======求OmgC======
% 解得 OmgC = OmgP / [1/Ap^2 - 1]^1/2N
OmgC = 1/Ap^2 -1;
OmgC = OmgP / (OmgC^(1/(2*N))); %幅度公式,求OmgC
%=======Ak======
N,OmgC
Ak = OmgC^N;
%=================> 极点sk==============================
% (s/jOmgC)^2N - 1 == 0
syms s;
eqn1 = (s/(j*OmgC))^(2*N) + 1==0;
s = solve(eqn1,real(s)<0,s);         %解方程求极点sk
s=double(s)
%====> |======
b=real(poly([]));
a=real(poly(s/OmgC))
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
%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
function[C,B,A]=sdir2cas(b,a)%IIR直联->级联
%C为增益系数 %B为包含各bk的K乘3维实系数矩阵 %A为包含各ak的K乘3维实系数矩阵
%b为直接形式的分子多项式系数 %a为直接形式的分母多项式系数
b0=b(1);b=b/b0;a0=a(1);a=a/a0;C=b0/a0, 
Na=length(a)-1;Nb=length(b)-1
p=cplxpair(roots(a));K=floor(Na/2)
if K*2==Na
    A=zeros(K,3);
    for n=1:2:Na
        Arow=p(n:1:n+1,:);
        Arow=poly(Arow);
        A(fix((n+1)/2),:)=real(Arow);
    end
elseif Na==1
    A=[o real(poly(p))]
else
    zeros(K+1,3);
    for n=l:2:2*K
        Arow=p(n:l:n+l,:)
        Arow =poly(Arow);
        A(fix(n+1/2),:)=real(Arow);
    end
    A(K+1,:)=[0 real(poly(p(Na)))];
end
z=cplxpair(roots(b));
K=floor(Nb/2);
if Nb==0
B=[0 0 poly(z)]
elseif K*2==Nb
    B=zeros(K,3)
    for n=1:2:Nb
    Brow=z(n:1:n+1,:);
    Brow = poly(Brow);
    B(fix((n+1)/2),:)=real(Brow);
    end
elseif Nb==1
    B=[0 real(poly(2))];
else
    B=zeros(K+1,3)
    for n=1:2:2*K
       Brow=z(n:1:n+1,:);
       Brow=poly(Brow);
       B(fix((n+1)/2),:)=real(Brow)
    end
B(K+1,:)=[0 real(poly(z(Nb)))];
end
end