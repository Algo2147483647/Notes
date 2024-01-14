import numpy as np

def ChannelGain_VLC(vlc, use, 
	Ap, Phi_helf, Psi, gf, n
):
	m = -1 / np.log2(np.cos(Phi_helf))
	dis = np.sqrt((vlc[0] - use[0]) ** 2 + (vlc[1] - use[1]) ** 2 + (vlc[2] - use[2]) ** 2)
	psi = np.arccos(abs(vlc[2] - use[2]) / dis)
	phi = np.arccos(abs(vlc[2] - use[2]) / dis)
	# gc
	gc = 0
	if(psi <= Psi):
		gc = n**2 / np.sin(Psi)**2
	# ChannelGain
	return ((m+1) * Ap) / (2 * np.pi * dis ** 2) * np.cos(phi)**m * gf * gc * np.cos(psi)
