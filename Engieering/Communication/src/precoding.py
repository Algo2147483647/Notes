import numpy as np
'''
MIMO Precoding
'''
def MIMOPrecode(H):
	[U,S,V] = np.linalg.svd(H) 

	F = V[:, 1:Ns]
	W = ((1/sqrt(SNR(s)))*(F'*H'*H*F+Ns/SNR(s)*eye(Ns))\(F'*H'))'

	C = abs(log2(det(eye(Ns)+(SNR(s)/Ns)*(Rn_Opt\(W'*H*F*F'*H'*W))))) 

	return [F, W, C]