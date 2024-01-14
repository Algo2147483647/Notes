% Rayleigh channel model
% Input : L = Number of channel realizations
% Output: H = Channel vector
function H = Ray_model(L)
    H = (randn(1,L)+j*randn(1,L))/sqrt(2);
end


% Rician channel model
% Input : K_dB = K factor[dB]
% Output: H = Channel vector
function H=Ric_model(K_dB,L)
    K = 10^(K_dB/10);
    H = sqrt(K/(K+1)) + sqrt(1/(K+1))*Ray_model(L);
end