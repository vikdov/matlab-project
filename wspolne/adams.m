function mandaty = adams(glosy, liczba_mandatow)
% ADAMS  Metoda Adamsa (metoda najmniejszych dzielników)
%   Dzielniki: 0, 1, 2, 3, ... (faworyzuje małe partie)
%   glosy           - wektor głosów na partie
%   liczba_mandatow - liczba mandatów do podziału

n_partii = length(glosy);
ilorazy = zeros(n_partii, liczba_mandatow);

for i = 1:n_partii
    for j = 1:liczba_mandatow
        ilorazy(i, j) = glosy(i) / (j - 1);  % dzielniki 0,1,2,3,...
    end
end

% Ustaw ilorazy dla dzielnika 0 jako Inf (każda partia dostaje min. 1 mandat)
ilorazy(:, 1) = Inf;

ilorazy_vec = ilorazy(:);
[~, idx] = sort(ilorazy_vec, 'descend');

mandaty = zeros(1, n_partii);
% Najpierw zapewnij każdej partii z niezerowymi głosami 1 mandat
partie_z_glosami = find(glosy > 0);
mandaty(partie_z_glosami) = 1;
przydzielone = length(partie_z_glosami);

if przydzielone >= liczba_mandatow
    % Jeśli partii jest więcej niż mandatów — przytnij wg kolejności głosów
    [~, order] = sort(glosy(partie_z_glosami), 'descend');
    mandaty_temp = zeros(1, n_partii);
    mandaty_temp(partie_z_glosami(order(1:liczba_mandatow))) = 1;
    mandaty = mandaty_temp;
    return;
end

% Teraz przydziel pozostałe mandaty metodą ilorazową (dzielniki 1,2,3,...)
ilorazy2 = zeros(n_partii, liczba_mandatow);
for i = 1:n_partii
    for j = 1:liczba_mandatow
        ilorazy2(i, j) = glosy(i) / j;
    end
end

% Zeruj już przydzielone (każda partia ma 1)
for i = partie_z_glosami
    ilorazy2(i, 1) = 0;
end

ilorazy2_vec = ilorazy2(:);
[~, idx2] = sort(ilorazy2_vec, 'descend');

pozostale = liczba_mandatow - przydzielone;
for k = 1:pozostale
    [partia, ~] = ind2sub(size(ilorazy2), idx2(k));
    mandaty(partia) = mandaty(partia) + 1;
end
end
