function mandaty = sainte_lague(glosy, liczba_mandatow, zmodyfikowana)
% SAINTE_LAGUE  Metoda Sainte-Laguë (czysta lub zmodyfikowana)
%   glosy           - wektor głosów na partie
%   liczba_mandatow - liczba mandatów do podziału
%   zmodyfikowana   - true: pierwszy dzielnik = 1.4 (zmod. Sainte-Laguë)
%                     false: dzielniki 1,3,5,7,... (czysta Sainte-Laguë)

if nargin < 3
    zmodyfikowana = false;
end

n_partii = length(glosy);
ilorazy = zeros(n_partii, liczba_mandatow);

for i = 1:n_partii
    for j = 1:liczba_mandatow
        if j == 1 && zmodyfikowana
            dzielnik = 1.4;
        else
            dzielnik = 2*j - 1;  % 1, 3, 5, 7, ...
        end
        ilorazy(i, j) = glosy(i) / dzielnik;
    end
end

ilorazy_vec = ilorazy(:);
[~, idx] = sort(ilorazy_vec, 'descend');

mandaty = zeros(1, n_partii);
for k = 1:liczba_mandatow
    [partia, ~] = ind2sub(size(ilorazy), idx(k));
    mandaty(partia) = mandaty(partia) + 1;
end
end
