% =========================================================
% SCENARIUSZ 2: Metoda Sainte-Laguë
% Porównanie czystej i zmodyfikowanej wersji
% Dzielniki czyste:      1, 3, 5, 7, ...
% Dzielniki zmod.:    1.4, 3, 5, 7, ...
% =========================================================

clear; clc;
s2_dir = fileparts(mfilename('fullpath'));
addpath(s2_dir);
run(fullfile(s2_dir, 'dane_wybory1922.m'));

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

wyniki_czysty = zeros(1, n_partii);
wyniki_zmod   = zeros(1, n_partii);

for o = 1:n_okregow
    glosy_okreg = okregi_1922_dane(o, :);
    m_czysty = sainte_lague(glosy_okreg, okregi_1922_mandaty(o), false);
    m_zmod   = sainte_lague(glosy_okreg, okregi_1922_mandaty(o), true);
    wyniki_czysty = wyniki_czysty + m_czysty;
    wyniki_zmod   = wyniki_zmod   + m_zmod;
end

total = sum(wyniki_czysty);  % powinno być to samo dla obu

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 2: Metoda Sainte-Lague\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %12s %12s\n', 'Partia', 'Czysta SL', 'Zmod. SL');
fprintf('%s\n', repmat('-', 1, 40));

[~, idx] = sort(wyniki_czysty, 'descend');
for i = 1:n_partii
    if wyniki_czysty(idx(i)) > 0 || wyniki_zmod(idx(i)) > 0
        diff_str = '';
        d = wyniki_zmod(idx(i)) - wyniki_czysty(idx(i));
        if d > 0
            diff_str = sprintf('(+%d)', d);
        elseif d < 0
            diff_str = sprintf('(%d)', d);
        end
        fprintf('%-12s %12d %12d  %s\n', ...
            partie_1922{idx(i)}, wyniki_czysty(idx(i)), wyniki_zmod(idx(i)), diff_str);
    end
end

fprintf('%s\n', repmat('-', 1, 40));
fprintf('%-12s %12d %12d\n', 'ŁĄCZNIE', sum(wyniki_czysty), sum(wyniki_zmod));

% ---- Wykres słupkowy porównawczy ----
figure('Name', 'Sainte-Lague 1922', 'NumberTitle', 'off', 'Position', [100 100 1000 550]);

partie_aktywne = (wyniki_czysty > 0) | (wyniki_zmod > 0);
nazwy = partie_1922(partie_aktywne);
val_c = wyniki_czysty(partie_aktywne);
val_z = wyniki_zmod(partie_aktywne);

[val_c_sort, srt] = sort(val_c, 'descend');
val_z_sort = val_z(srt);
nazwy_sort = nazwy(srt);

x = 1:length(nazwy_sort);
bar(x, [val_c_sort' val_z_sort']);
xticks(x);
xticklabels(nazwy_sort);
xtickangle(45);
legend({'Czysta Sainte-Lagu\''e', 'Zmodyfikowana Sainte-Lagu\''e'}, 'FontSize', 10);
ylabel('Liczba mandatów');
title({'Porównanie: Czysta vs Zmodyfikowana Sainte-Lagu\''e', 'Wybory parlamentarne 1922'}, 'FontSize', 12);
grid on;

fprintf('\nScenariusz 2 zakończony.\n');
