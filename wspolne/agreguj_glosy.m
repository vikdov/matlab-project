function glosy_makro = agreguj_glosy(dane, mandaty, idx_okregow)
% AGREGUJ_GLOSY  Wazona agregacja wynikow okregowych do makrookregu
%   dane        - macierz wynikow (wiersze=okregi, kolumny=partie)
%   mandaty     - wektor liczby mandatow w okregach (uzyty jako waga)
%   idx_okregow - indeksy okregów wchodzących do makrookregu

n_partii    = size(dane, 2);
glosy_makro = zeros(1, n_partii);
suma_wag    = 0;

for o = idx_okregow
    waga        = mandaty(o);
    glosy_makro = glosy_makro + dane(o, :) * waga;
    suma_wag    = suma_wag + waga;
end

glosy_makro = glosy_makro / suma_wag;
end
