%% GMSK数字调制
function [out,ThetaGmsk] = GMSK(in, SampleNumber, fc, Rb)
	fs = Rb*SampleNumber;           %采样频率
	SignalDiff = (in);              %差分编码
	SignalDiff(SignalDiff==0)=-1;   %转双极性码
	%转模拟信号
	SignalAnalog = zeros(1,length(SignalDiff)*SampleNumber);
	for i=1:SampleNumber
		SignalAnalog(i:SampleNumber:length(SignalDiff)*SampleNumber)=SignalDiff;
	end
	%Gauss滤波
	xb = 0.6;
	[SignalGauss] = GaussFliter(SignalAnalog,xb,Rb,fs);
	%GMSK相位路径: θ(t) = θ(k·Tb) + Δθ(t)		 % θ(t)可通过对Δθ(t)的累加得到
	%正交调制 s_GMSK = cos[θ(t)]·cos(Ωct) - sin[θ(t)]·sin(Ωct)
	ThetaGmsk = cumsum(SignalGauss);
	t = 1/fs:1/fs:length(in)*1/Rb;	%时间
	out = cos(2*pi*fc*t).*cos(ThetaGmsk) - sin(2*pi*fc*t).*sin(ThetaGmsk); %s_GMSK
end