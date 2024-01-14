function G = ChannelGain_VLC(vlc, useX, uesY, useH  ...
	, Ap, Phi_helf, Psi, gf, n ...
)
	m = -log10(2)/log10(cos(Phi_helf));
	% angle
    h = abs(useH - vlc(3));
    dis = sqrt((useX-vlc(1)).^2 + (uesY-vlc(2)).^2 + h.^2);
	phi = acos(h ./ dis);
	psi = acos(h ./ dis);
	%gc
	gc = zeros(size(dis));
    gc(find(psi <= Psi)) = (n^2)/(sin(Psi)^2);
	% channel gain
	G = ((m+1) * Ap./(2*pi.*dis.^2)) .* cos(phi).^m .* gf .* gc .* cos(psi);
end
