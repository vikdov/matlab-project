% =========================================================
% SCENARIUSZ 3: Metoda Adamsa
% Dzielniki: 0, 1, 2, 3, ... (każda partia z głosami >0
% gwarantuje sobie co najmniej 1 mandat — faworyzuje małe partie)
% =========================================================

clear; clc;
s2_dir = fileparts(mfilename('fullpath'));
addpath(s2_dir);
run(fullfile(s2_dir, 'dane_wybory1922.m'));

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

wyniki_adams  = zeros(1, n_partii);
wyniki_dhondt = zeros(1, n_partii);  % dla porównania

for o = 1:n_okregow
    glosy_okreg = okregi_1922_dane(o, :);
    wyniki_adams  = wyniki_adams  + adams(glosy_okreg, okregi_1922_mandaty(o));
    wyniki_dhondt = wyniki_dhondt + dhondt(glosy_okreg, okregi_1922_mandaty(o));
end

total = sum(wyniki_adams);

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3: Metoda Adamsa\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('  (porownanie z D''Hondtem)\n');
fprintf('========================================================\n');
fprintf('%-12s %10s %10s %10s\n', 'Partia', 'Adams', 'D''Hondt', 'Różnica');
fprintf('%s\n', repmat('-', 1, 48));

[~, idx] = sort(wyniki_adams, 'descend');
for i = 1:n_partii
    if wyniki_adams(idx(i)) > 0 || wyniki_dhondt(idx(i)) > 0
        diff = wyniki_adams(idx(i)) - wyniki_dhondt(idx(i));
        diff_str = '';
        if diff > 0,      diff_str = sprintf('+%d', diff);
        elseif diff < 0,  diff_str = sprintf('%d', diff);
        end
        fprintf('%-12s %10d %10d %10s\n', ...
            partie_1922{idx(i)}, wyniki_adams(idx(i)), wyniki_dhondt(idx(i)), diff_str);
    end
end

fprintf('%s\n', repmat('-', 1, 48));
fprintf('%-12s %10d %10d\n', 'ŁĄCZNIE', sum(wyniki_adams), sum(wyniki_dhondt));

% ---- Wykres słupkowy Adams vs D'Hondt ----
figure('Name', 'Adams vs D''Hondt 1922', 'NumberTitle', 'off', 'Position', [100 100 1000 550]);

partie_aktywne = (wyniki_adams > 0) | (wyniki_dhondt > 0);
nazwy = partie_1922(partie_aktywne);
val_a = wyniki_adams(partie_aktywne);
val_d = wyniki_dhondt(partie_aktywne);

[val_a_sort, srt] = sort(val_a, 'descend');
val_d_sort = val_d(srt);
nazwy_sort = nazwy(srt);

x = 1:length(nazwy_sort);
bar(x, [val_a_sort' val_d_sort']);
xticks(x);
xticklabels(nazwy_sort);
xtickangle(45);
legend({'Adams', 'D''Hondt'}, 'FontSize', 10);
ylabel('Liczba mandatów');
title({'Porównanie: Metoda Adamsa vs D''Hondta', 'Wybory parlamentarne 1922'}, 'FontSize', 12);
grid on;

fprintf('\nScenariusz 3 zakończony.\n');
