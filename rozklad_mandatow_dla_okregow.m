function rozklad_mandatow = rozklad_mandatow_dla_okregow(okregi_dane, okregi_mandaty)
    % okregi_dane - macierz, gdzie każdy wiersz to dane wyników wyborczych
    % dla danego okręgu
    % okregi_mandaty - wektor liczb mandatów przypisanych do poszczególnych
    % okręgów

    liczba_okregow = size(okregi_dane, 1);  % Liczba okręgów
    liczba_partii = size(okregi_dane, 2);   % Liczba partii

    % Macierz do przechowywania wyników - rozkład mandatów dla wszystkich
    % okręgów
    rozklad_mandatow = zeros(liczba_okregow, liczba_partii);

    % Iteracja po wszystkich okręgach
    for okreg = 1:liczba_okregow
        % Pobieramy dane dla danego okręgu
        dane_okregu = okregi_dane(okreg, :);

        % Pobieramy liczbę mandatów dla danego okręgu
        mandaty_okr = okregi_mandaty(okreg);

        % Obliczamy rozkład mandatów przy pomocy funkcji hondt
        mandaty = hondt(dane_okregu, mandaty_okr);

        % Zapisujemy wynik dla danego okręgu w odpowiednim wierszu
        rozklad_mandatow(okreg, :) = mandaty;
    end
end