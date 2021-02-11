function Y =  AudioEqualizer(G1, G2, G3, G4, G5, InputSignal)
    As = 30;
    Rp = 3;
    Fs = 8192;

    Wp1 = 2*195/Fs;
    Wp2 = [2*305/Fs 2*445/Fs];
    Wp3 = [2*555/Fs 2*945/Fs];
    Wp4 = [2*1055/Fs 2*1945/Fs];
    Wp5 = 2*2055/Fs;

    Wc1 = 2*305/Fs;
    Wc2 = [2*195/Fs 2*555/Fs];
    Wc3 = [2*445/Fs 2*1055/Fs];
    Wc4 = [2*945/Fs 2*2055/Fs];
    Wc5 = 2*1945/Fs;

    [N1, Wn1] = buttord(Wp1, Wc1, Rp, As);
    [B1, A1] = butter(N1, Wn1);

    [N2, Wn2] = buttord(Wp2, Wc2, Rp, As);
    [B2, A2] = butter(N2, Wn2);

    [N3, Wn3] = buttord(Wp3, Wc3, Rp, As);
    [B3, A3] = butter(N3, Wn3);

    [N4, Wn4] = buttord(Wp4, Wc4, Rp, As);
    [B4, A4] = butter(N4, Wn4);

    [N5, Wn5] = buttord(Wp5, Wc5, Rp, As);
    [B5, A5] = butter(N5, Wn5);
    
    [H, W] = freqz(B1, A1);
    [H2, W2] = freqz(B2, A2);
    [H3, W3] = freqz(B3, A3);
    [H4, W4] = freqz(B4, A4);
    [H5, W5] = freqz(B5, A5);
    
    hold on;
    xlabel('Frequency (Hz)');
    ylabel('Magnitude (dB)');
    plot(W*Fs/(2*pi), 20*log10(abs(H)));
    plot(W2*Fs/(2*pi), 20*log10(abs(H2)));
    plot(W3*Fs/(2*pi), 20*log10(abs(H3)));
    plot(W4*Fs/(2*pi), 20*log10(abs(H4)));
    plot(W5*Fs/(2*pi), 20*log10(abs(H5)));
    hold off;
    
    G1 = db2mag(G1);
    G2 = db2mag(G2);
    G3 = db2mag(G3);
    G4 = db2mag(G4);
    G5 = db2mag(G5);
    x = max([G1 G2 G3 G4 G5]);

    y1 = G1 * filter(B1, A1, InputSignal);
    y2 = G2 * filter(B2, A2, InputSignal);
    y3 = G3 * filter(B3, A3, InputSignal);
    y4 = G4 * filter(B4, A4, InputSignal);
    y5 = G5 * filter(B5, A5, InputSignal);
    
    Y = (y1 + y2 + y3 + y4 + y5) / (5*x);
end