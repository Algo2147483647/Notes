clear all;close all;clc;
%% 信号发生
fs0 = 5;fs = 200; t = 0:1/fs:1;            % fs0信源频率 %fs采样频率
s0 = sin(2*pi*fs0*t);                      % 正弦波信号发生
s1 = s0;                                   % 矩形波信号发生
for i = 1:length(s1)
    if(s1(i)>0)s1(i) = 1;
    else s1(i)=0;
    end
end
s2=s1;                                      % 三角波信号发生
for i = 2:length(s1)
    if(s1(i)>0)s2(i) =s2(i-1)+5/fs;
    else s2(i)=s2(i-1)-5/fs;
    end
end
s2 =s2.*2;
s0 = s0./2+0.5;
%% 绘图
subplot(131);plot(s0);title("信号发生");
subplot(132);plot(s1);title("信号发生");
subplot(133);plot(s2);title("信号发生");
%% 时分复用
s_tdma = zeros(1,3*8*fs);
cur = 1;
for tt = 1:fs
    for i = 1:3             % 依此对三个波形
        temp = 0;
        if(i==1) temp = s0(tt);
        elseif(i==2) temp = s1(tt);
        else temp = s2(tt);
        end
        temp = bitget(int8(temp*128),8:-1:1);   % 目标数值，转二进制，按位取出
        s_tdma(cur:cur+7) = temp;               % 二进制存入s_tdma时分复用信号波形中
        cur = cur+8;
    end
end
figure;
stairs(s_tdma(1:100),'Linewidth',2);title("前100个时分复用信号码元")
%% 时分复用解复用
%% 第一时序解复用
des0 = zeros(fs);
cur = 1;
for tt = 1:3*8:length(s_tdma)-3*8           %对于第一路信号时隙，二进制转十进制
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des0(cur) = des0(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% 第二时序解复用   %(同上)
des1 = zeros(fs);
cur = 1;
for tt = 1+8:3*8:length(s_tdma)-3*8
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des1(cur) = des1(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% 第三时序解复用   %(同上)
des2 = zeros(fs);
cur = 1;
for tt = 1+8+8:3*8:length(s_tdma)-3*8
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des2(cur) = des2(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% 绘图
figure;
subplot(131);plot(des0);title("TDMA解复用");
subplot(132);plot(des1);title("TDMA解复用");
subplot(133);plot(des2);title("TDMA解复用");