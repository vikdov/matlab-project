function mandaty = dhondt(glosy, liczba_mandatow)
% DHONDT  Metoda D'Hondta przydziału mandatów
%   glosy           - wektor głosów na partie (wartości surowe lub %)
%   liczba_mandatow - liczba mandatów do podziału
%   mandaty         - wiersz-wektor mandatów przydzielonych każdej partii

n_partii = length(glosy);
ilorazy = zeros(n_partii, liczba_mandatow);

for i = 1:n_partii
    for j = 1:liczba_mandatow
        ilorazy(i, j) = glosy(i) / j;
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
