function rozklad_mandatow = rozklad_mandatow_dla_okregow(okregi_dane, okregi_mandaty)
% ROZKLAD_MANDATOW_DLA_OKREGOW  Rozkład mandatów metodą d'Hondta dla wszystkich okręgów
%   okregi_dane    - macierz, gdzie każdy wiersz to wyniki wyborcze danego okręgu (%)
%   okregi_mandaty - wektor liczb mandatów przypisanych poszczególnym okręgom
%   rozklad_mandatow - macierz wynikowa: wiersze = okręgi, kolumny = partie

    liczba_okregow = size(okregi_dane, 1);
    liczba_partii  = size(okregi_dane, 2);

    rozklad_mandatow = zeros(liczba_okregow, liczba_partii);

    for okreg = 1:liczba_okregow
        dane_okregu   = okregi_dane(okreg, :);
        mandaty_okr   = okregi_mandaty(okreg);
        rozklad_mandatow(okreg, :) = dhondt(dane_okregu, mandaty_okr);
    end
end
