clear all;close all;clc;
%% �źŷ���
fs0 = 5;fs = 200; t = 0:1/fs:1;            % fs0��ԴƵ�� %fs����Ƶ��
s0 = sin(2*pi*fs0*t);                      % ���Ҳ��źŷ���
s1 = s0;                                   % ���β��źŷ���
for i = 1:length(s1)
    if(s1(i)>0)s1(i) = 1;
    else s1(i)=0;
    end
end
s2=s1;                                      % ���ǲ��źŷ���
for i = 2:length(s1)
    if(s1(i)>0)s2(i) =s2(i-1)+5/fs;
    else s2(i)=s2(i-1)-5/fs;
    end
end
s2 =s2.*2;
s0 = s0./2+0.5;
%% ��ͼ
subplot(131);plot(s0);title("�źŷ���");
subplot(132);plot(s1);title("�źŷ���");
subplot(133);plot(s2);title("�źŷ���");
%% ʱ�ָ���
s_tdma = zeros(1,3*8*fs);
cur = 1;
for tt = 1:fs
    for i = 1:3             % ���˶���������
        temp = 0;
        if(i==1) temp = s0(tt);
        elseif(i==2) temp = s1(tt);
        else temp = s2(tt);
        end
        temp = bitget(int8(temp*128),8:-1:1);   % Ŀ����ֵ��ת�����ƣ���λȡ��
        s_tdma(cur:cur+7) = temp;               % �����ƴ���s_tdmaʱ�ָ����źŲ�����
        cur = cur+8;
    end
end
figure;
stairs(s_tdma(1:100),'Linewidth',2);title("ǰ100��ʱ�ָ����ź���Ԫ")
%% ʱ�ָ��ý⸴��
%% ��һʱ��⸴��
des0 = zeros(fs);
cur = 1;
for tt = 1:3*8:length(s_tdma)-3*8           %���ڵ�һ·�ź�ʱ϶��������תʮ����
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des0(cur) = des0(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% �ڶ�ʱ��⸴��   %(ͬ��)
des1 = zeros(fs);
cur = 1;
for tt = 1+8:3*8:length(s_tdma)-3*8
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des1(cur) = des1(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% ����ʱ��⸴��   %(ͬ��)
des2 = zeros(fs);
cur = 1;
for tt = 1+8+8:3*8:length(s_tdma)-3*8
    temp = s_tdma(tt:tt+7);
    for i = 1:8
        des2(cur) = des2(cur) * 2 + temp(i);
    end
    cur = cur +1;
end
%% ��ͼ
figure;
subplot(131);plot(des0);title("TDMA�⸴��");
subplot(132);plot(des1);title("TDMA�⸴��");
subplot(133);plot(des2);title("TDMA�⸴��");