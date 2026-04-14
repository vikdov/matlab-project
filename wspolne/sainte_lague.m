function mandaty = sainte_lague(glosy, liczba_mandatow, zmodyfikowana)
% SAINTE_LAGUE  Metoda Sainte-LaguĂ« (czysta lub zmodyfikowana)
% glosy           - wektor liczby gĹ‚osĂłw dla kaĹĽdej partii
% liczba_mandatow - ile mandatĂłw rozdzielamy
% zmodyfikowana   - true: uĹĽywa 1.4 jako pierwszego dzielnika
%                   false: uĹĽywa 1,3,5,7,... (klasyczna metoda)

% JeĹ›li nie podano trzeciego argumentu â†’ ustaw domyĹ›lnie na false
if nargin < 3
    zmodyfikowana = false;
end

% Liczba partii (dĹ‚ugoĹ›Ä‡ wektora gĹ‚osĂłw)
n_partii = length(glosy);

% Tworzymy macierz ilorazĂłw:
% wiersze = partie, kolumny = kolejne dzielniki
ilorazy = zeros(n_partii, liczba_mandatow);

% Liczymy wszystkie ilorazy dla kaĹĽdej partii
for i = 1:n_partii                % dla kaĹĽdej partii
    for j = 1:liczba_mandatow     % dla kaĹĽdego potencjalnego mandatu
        
        % WybĂłr dzielnika
        if j == 1 && zmodyfikowana
            dzielnik = 1.4;       % zmodyfikowana metoda (pierwszy dzielnik)
        else
            dzielnik = 2*j - 1;   % 1, 3, 5, 7, ...
        end
        
        % Obliczamy iloraz (gĹ‚osy / dzielnik)
        ilorazy(i, j) = glosy(i) / dzielnik;
    end
end

% Zamieniamy macierz ilorazĂłw na wektor (jedna dĹ‚uga lista)
ilorazy_vec = ilorazy(:);

% Sortujemy malejÄ…co (od najwiÄ™kszego do najmniejszego)
% idx = indeksy posortowanych elementĂłw
[~, idx] = sort(ilorazy_vec, 'descend');

% Tworzymy wektor mandatĂłw (na poczÄ…tku same zera)
mandaty = zeros(1, n_partii);

% Przydzielamy mandaty na podstawie najwiÄ™kszych ilorazĂłw
for k = 1:liczba_mandatow
    
    % Zamieniamy indeks liniowy na (wiersz, kolumna)
    % wiersz = numer partii
    [partia, ~] = ind2sub(size(ilorazy), idx(k));
    
    % Dodajemy mandat tej partii
    mandaty(partia) = mandaty(partia) + 1;
end

end
