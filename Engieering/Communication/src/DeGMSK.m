%% GMSK数字非相干解调
function [out] = DeGMSK(in,ThetaGmsk,fc,Rb,SampleNumber)
    %   (1bt延迟差分解调) % 延迟1bt，移相pi/2  
    ThetaDeGmsk = ThetaGmsk;
    for i = 1 : length(ThetaGmsk)             %延迟1bt，移相pi/2 GMSK波形
        if i <= SampleNumber   % 1bt内
            ThetaDeGmsk(i)=0;      % Alpha 前1bt 置0
        else
            ThetaDeGmsk(i)=ThetaGmsk(i-SampleNumber);%右移1bt
        end
    end
    ThetaDeGmsk = ThetaDeGmsk + pi/2;       %移相pi/2
    fs = Rb*SampleNumber;          %采样频率
    t = 1/fs:1/fs:length(in)/SampleNumber*1/Rb;    %时间
    out = cos(2*pi*fc*t).*cos(ThetaDeGmsk) - sin(2*pi*fc*t).*sin(ThetaDeGmsk); %s_GMSK
    out = out .* in;% 相乘
end