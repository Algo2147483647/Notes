%% Gauss滤波器
function [out] = GaussFliter(in, xb, Rb, fs)
	a = sqrt(2/log(2))*xb*Rb;
	f = 1:length(in);
	f = f*fs/2/length(in);
	H = exp(-(f.^2/a.^2));
	out = ifft( fft(in) .* H );
	out = real(out);
end