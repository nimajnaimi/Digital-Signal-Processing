load handel.mat;

G1 = 12;
G2 = 10;
G3 = 8;
G4 = 5;
G5 = 2;

Y = AudioEqualizer(G1, G2, G3, G4, G5, y);
%sound(Y);