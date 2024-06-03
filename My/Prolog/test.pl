% termy:
%   ja
%   vdova
%   dcera
%   otec
%   syn1
%   syn2


% manzelstvi(Muz, Zena)
manzelstvi(ja, vdova).
manzelstvi(otec, dcera).

% rodic(Kdo, Koho)
vlastni_rodic(vdova, dcera).
vlastni_rodic(otec, ja).
vlastni_rodic(vdova, syn1).
vlastni_rodic(dcera, syn2).

nevlastni_rodic(Kdo, Koho) :- manzelstvi(Otec, Kdo), vlastni_rodic(Otec, Koho).
nevlastni_rodic(Kdo, Koho) :- manzelstvi(Kdo, Matka), vlastni_rodic(Matka, Koho).

rodic(Kdo, Koho) :- vlastni_rodic(Kdo, Koho) ; nevlastni_rodic(Kdo, Koho).

zet(Kdo, Koho) :- manzelstvi(Kdo, Dcera), rodic(Koho, Dcera).

sourozenec(Kdo, Koho) :- rodic(R, Koho), rodic(R, Kdo), Kdo \= Koho.

svagr(Kdo, Koho) :- manzelstvi(Kdo, Sestra), sourozenec(Sestra, Koho).

stryc(Kdo, Koho) :- sourozenec(Kdo, Sourozenec), rodic(Sourozenec, Koho).

vnuk(Kdo, Koho) :- rodic(Koho, Rodic), rodic(Rodic, Kdo).