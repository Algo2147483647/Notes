clear variables;

%% System parameters

Nt = [64 256]; % Number of transmit antennas
Nr = [16 64]; % Number of receive antennas

Ns = [1]; % Number of data streams
NumRF = [4 6]; % Number of RF chains for precoding and combining 

NumCluster = 8; % Number of clusters
NumRay = 10; % Number of rays per cluster

AS = 7.5; % Angular spread of 7.5 degree

SNR_dB = -40:5:0; % Range of SNR in dB

ITER = 100; % Number of channel generations 

%% Fig.3 

[Fig3_SE_Optimal,Fig3_SE_Hybrid,Fig3_SE_BeamSteering] = SpatiallySparsePrecoding(Nt(1),Nr(1),Ns,NumRF(1),NumCluster,NumRay,AS,SNR_dB,ITER);

figure(); 
l1 = plot(SNR_dB,Fig3_SE_Optimal(1,:),'-s','Color',[0 0.5 0],'LineWidth',2.0,'MarkerSize',8.0);hold on;
l2 = plot(SNR_dB,Fig3_SE_Hybrid(1,:),'-o','Color',[0 0.45 0.74],'LineWidth',2.0,'MarkerSize',8.0);hold on;
l3 = plot(SNR_dB,Fig3_SE_BeamSteering(1,:),'-d','Color',[0.85 0.33 0.1],'LineWidth',2.0,'MarkerSize',8.0);hold on;
grid on;
legend([l1 l2 l3],'Optimal unconstrained precoding','Hybrid precoding and combining','Beam steering','Location','northwest');
title('Fig.3. 64 x 16 mmWave system with 4 RF chains for sparse precoding and MMSE combining (Ns = 1)');
xlabel('SNR (dB)'); ylabel('Spectral efficiency (bits/s/Hz)');

%% Fig.4

[Fig4_SE_Optimal,Fig4_SE_Hybrid,Fig4_SE_BeamSteering] = SpatiallySparsePrecoding(Nt(2),Nr(2),Ns,NumRF(2),NumCluster,NumRay,AS,SNR_dB,ITER);

figure(); 
l1 = plot(SNR_dB,Fig4_SE_Optimal(1,:),'-s','Color',[0 0.5 0],'LineWidth',2.0,'MarkerSize',8.0);hold on;
l2 = plot(SNR_dB,Fig4_SE_Hybrid(1,:),'-o','Color',[0 0.45 0.74],'LineWidth',2.0,'MarkerSize',8.0);hold on;
l3 = plot(SNR_dB,Fig4_SE_BeamSteering(1,:),'-d','Color',[0.85 0.33 0.1],'LineWidth',2.0,'MarkerSize',8.0);hold on;
grid on;
legend([l1 l2 l3],'Optimal unconstrained precoding','Hybrid precoding and combining','Beam steering','Location','northwest');
title('Fig.4. 256 x 64 mmWave system with 6 RF chains for sparse precoding and MMSE combining (Ns = 1)');
xlabel('SNR (dB)'); ylabel('Spectral efficiency (bits/s/Hz)');



function [SpectralEfficiency_Optimal,SpectralEfficiency_Hybrid,SpectralEfficiency_BeamSteering] = SpatiallySparsePrecoding(Nt,Nr,Ns,NumRF,NumCluster,NumRay,AS,SNR_dB,ITER)
%% 
% Input:
%       Nt          :   Number of transmit antennas
%       Nr          :   Number of receive antennas
%       Ns          :   Number of transmitted data stream
%       NumRF       :   Number of RF chains at both the transmitter and receiver
%       NumCluster  :   Number of scattering clusters
%       NumRay      :   Number of rays per cluster
%       AS          :   Angular spread in the cluster
%       SNR_dB      :   SNR values in decibel
%       ITER        :   Number of random channel generations
% Output:
%       SpectralEfficiency_Optimal      :    Spectral efficiency in bits/s/Hz, obtained by optimal unconstrained precoding 
%       SpectralEfficiency_Hybrid       :   Spectral efficiency in bits/s/Hz, obtained by hybrid precoding 
%       SpectralEfficiency_BeamSteering :   Spectral efficiency in bits/s/Hz, obtained by beam steering 
%
%% Initialize variables

% Initialize spectral efficiency (bits/s/Hz) obtained by 
% A. optimal unconstrained precoding
% B. hybrid precoding and combining
% C. beam steering

SpectralEfficiency_Optimal = zeros(ITER,length(SNR_dB)); 
SpectralEfficiency_Hybrid = zeros(ITER,length(SNR_dB)); 
SpectralEfficiency_BeamSteering = zeros(ITER,length(SNR_dB)); 

%% Obtain simulation parameters

% SNR in linear scale
SNR = 10.^(SNR_dB./10);

%% Precoding and combining algorithms

for s = 1:length(SNR) % Loop over SNR
           
    for i = 1:ITER
                
        % Generate MIMO channel matrix, array response vectors at the transmitter and receiver and complex path gain
        % H     :   Nr x Nt
        % At    :   Nt x (NumRay x NumCluster)
        % Ar    :   Nr x (NumRay x NumCluster)
        % Alpha :   1 x (NumRay x NumCluster)
        
        [H,At,Ar,Alpha] = ChannelGenereationMIMO(Nt,Nr,NumCluster,NumRay,AS);
               
        %%%% A. Optimal unconstrained precoding and combining
        
        [U,S,V] = svd(H);
        F_Opt = V(:,1:Ns); % Nt x Ns, optimal precoder
        W_Opt = ((1/sqrt(SNR(s)))*(F_Opt'*H'*H*F_Opt+Ns/SNR(s)*eye(Ns))\(F_Opt'*H'))'; % Nr x Ns, optimal combiner

        %%%% B. Hybrid sparse precoding and combining via orthogonal matching pursuit (OMP)
        
        % Algorithm 1 - Hybrid precoding        
        F_RF = [];
        F_Res = F_Opt;
        
        for r = 1:NumRF             
            Psi = At'*F_Res; % Step 4, the projection of all paths on the optimal precoder
            [~,k] = max(diag(Psi*Psi')); % Step 5, select the path that has the largest projection
            F_RF = [F_RF At(:,k)]; % Step 6, append the selected vector to the RF precoder
            F_BB = (F_RF'*F_RF)\(F_RF'*F_Opt); % Step7, baseband precoder calculated by least squares solution
            F_Res = (F_Opt-F_RF*F_BB)/norm(F_Opt-F_RF*F_BB,'fro'); % Step 8, remove the contribution of the selected vector from F_res        
        end       
        F_BB = sqrt(Ns)*(F_BB/norm(F_RF*F_BB,'fro')); % Step 10, normalize F_BB to meet total power constraint
        
        % Algorithm 2 - Hybrid combining
        CovRx = (SNR(s)/Ns)*H*F_RF*F_BB*F_BB'*F_RF'*H'+eye(Nr); % Nr x Nr, covariance matrix of received signals at receive antennas
        W_MMSE = ((1/sqrt(SNR(s)))*(F_BB'*F_RF'*H'*H*F_RF*F_BB+(Ns/SNR(s))*eye(Ns))\(F_BB'*F_RF'*H'))';
                
        W_RF = [];
        W_Res = W_MMSE;
        
        for r = 1:NumRF
            Psi = Ar'*CovRx*W_Res; 
            [~,k] = max(diag(Psi*Psi'));
            W_RF = [W_RF Ar(:,k)];
            W_BB = (W_RF'*CovRx*W_RF)\(W_RF'*CovRx*W_MMSE);
            W_Res = (W_MMSE-W_RF*W_BB)/norm(W_MMSE-W_RF*W_BB,'fro');
        end
        
        %%%% C. Beam steering based on the highest effective channel gain
        
        [IndexAt,IndexAr] = findSteeringVector(H,At,Ar,Ns);
        
        F_BS = [];
        W_BS = [];
        
        for n = 1:Ns 
            F_BS = [F_BS At(:,IndexAt)];
            W_BS = [W_BS Ar(:,IndexAr)];
        end

        %%%% Spectial efficiency calculation 
        
        % A. Optimal solution
        Rn_Opt = W_Opt'*W_Opt;
        SpectralEfficiency_Optimal(i,s) = abs(log2(det(eye(Ns)+(SNR(s)/Ns)*(Rn_Opt\(W_Opt'*H*F_Opt*F_Opt'*H'*W_Opt)))));
        
        % B. Hybrid solution       
        Rn_Hybrid = W_BB'*W_RF'*W_RF*W_BB;        
        SpectralEfficiency_Hybrid(i,s) = abs(log2(det(eye(Ns)+(SNR(s)/Ns)*(Rn_Hybrid\(W_BB'*W_RF'*H*F_RF*F_BB*F_BB'*F_RF'*H'*W_RF*W_BB)))));
        
        % C. Beam steering solution
        Rn_BS = W_BS'*W_BS;
        SpectralEfficiency_BeamSteering(i,s) = abs(log2(det(eye(Ns)+(SNR(s)/Ns)*(Rn_BS\(W_BS'*H*F_BS*F_BS'*H'*W_BS)))));

    end
    
end

SpectralEfficiency_Optimal = mean(SpectralEfficiency_Optimal,1); % 1 x length(SNR)
SpectralEfficiency_Hybrid = mean(SpectralEfficiency_Hybrid,1);
SpectralEfficiency_BeamSteering = mean(SpectralEfficiency_BeamSteering,1); 

end
