import numpy as np
'''
mmWave MIMO Channel
Input : 
  Nt     : Number of transmit antennas 
  Nr     : Number of receive antennas
  NumCluster    : Number of clusters
  NumRay        : Number of rays per cluster
  AS     : Fixed angular spread at both the transmitter and receiver
Output : 
  MIMO_Chan  : Nr x Nt, MIMO channel matrix
  ArrayResponse_TX  : Nt x (NumCluster x NumRay), transmit steering vectors
  ArrayResponse_RX  : Nr x (NumCluster x NumRay), receive steering vectors
  Alpha      : 1 x (NumCluster x NumRay), complex path gain
'''
def mmWaveMIMOChannel(Nt, Nr, NumCluster, NumRay, angleSpread):

	# cluster angle
	minAOD = -30
	maxAOD = 30
	minEOD = 80
	maxEOD = 100

	Cluster_AOD = np.random.rand(NumCluster,1) * (maxAOD-minAOD) + minAOD
	Cluster_EOD = np.random.rand(NumCluster,1) * (maxEOD-minEOD) + minEOD
	Cluster_AOA =(np.random.rand(NumCluster,1) - 0.5) * 360
	Cluster_EOA = np.random.rand(NumCluster,1) * 180

	# rays angle per cluster
	Ray_AOD = repelem(Cluster_AOD,NumRay,1)-b*sign(Randomness).*log(1-2.*abs(Randomness))
	Ray_EOD = repelem(Cluster_EOD,NumRay,1)-b*sign(Randomness).*log(1-2.*abs(Randomness))
	Ray_AOA = repelem(Cluster_AOA,NumRay,1)-b*sign(Randomness).*log(1-2.*abs(Randomness))
	Ray_EOA = repelem(Cluster_EOA,NumRay,1)-b*sign(Randomness).*log(1-2.*abs(Randomness))

	# array response vectors
	X_Tx = zeros(1, Nt(1) * Nt(2))
	[Y_Tx,Z_Tx] = meshgrid(0 : Nt(1)-1, 0 : Nt(2)-1)
	TxPos = [X_Tx; Y_Tx(:).'; Z_Tx(:).']; % 3 x Nt

	X_Rx = zeros(1, Nr(1) * Nr(2))
	[Y_Rx,Z_Rx] = meshgrid(0 : Nr(1)-1, 0 : Nr(2)-1)
	RxPos = [X_Rx; Y_Rx(:).'; Z_Rx(:).']

	SphericalUnitVecTx = getSphericalUnitVector(Ray_EOD,Ray_AOD); % 3 x NumRay*NumCluster
	SphericalUnitVecRx = getSphericalUnitVector(Ray_EOA,Ray_AOA); % 3 x NumRay*NumCluster
	ArrayResponse_TX = (1/sqrt(Nt(1) * Nt(2)))*exp(1j*pi* TxPos .* SphericalUnitVecTx)
	ArrayResponse_RX = (1/sqrt(Nr(1) * Nr(2)))*exp(1j*pi* RxPos .* SphericalUnitVecRx)
