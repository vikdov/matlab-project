% =========================================================
% SCENARIUSZ 3 — PODSCENARIUSZ B
% Jeden ogólnokrajowy okrąg wyborczy (372 mandaty)
%
% Cała Polska głosuje jako jeden okrąg.
% Wyniki porównane z historycznym podziałem na 64 okręgi.
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, '..', 'wspolne', 'dane_1922.m'));
run(fullfile(sciezka, 'dane_okregi.m'));

% ---- Obliczenia ----
n_partii = length(partie_1922);

% Jeden okrąg ogólnokrajowy
wyniki_PL   = dhondt(okrag_PL_dane, okrag_PL_mandaty(1));

% Historyczne 64 okręgi (dla porównania)
wyniki_hist = zeros(1, n_partii);
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o, :), okregi_1922_mandaty(o));
end

total = sum(wyniki_PL);

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3 — PODSCENARIUSZ B\n');
fprintf('  Jeden okrąg ogólnokrajowy (372 mandaty)\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %14s %14s %10s\n', 'Partia', '1 okrąg (PL)', 'Hist. (64)', 'Różnica');
fprintf('%s\n', repmat('-', 1, 54));

[~, idx] = sort(wyniki_PL, 'descend');
for i = 1:n_partii
    if wyniki_PL(idx(i)) > 0 || wyniki_hist(idx(i)) > 0
        diff = wyniki_PL(idx(i)) - wyniki_hist(idx(i));
        diff_str = '';
        if diff > 0,     diff_str = sprintf('+%d', diff);
        elseif diff < 0, diff_str = sprintf('%d', diff);
        end
        fprintf('%-12s %14d %14d %10s\n', ...
            partie_1922{idx(i)}, wyniki_PL(idx(i)), wyniki_hist(idx(i)), diff_str);
    end
end
fprintf('%s\n', repmat('-', 1, 54));
fprintf('%-12s %14d %14d\n', 'ŁĄCZNIE', sum(wyniki_PL), sum(wyniki_hist));

% ---- Wykres słupkowy porównawczy ----
figure('Name', 'Scenariusz 3B — 1 okrąg vs 64 okręgi', ...
       'NumberTitle', 'off', 'Position', [50 50 1050 580]);

partie_aktywne = (wyniki_PL > 0) | (wyniki_hist > 0);
nazwy = partie_1922(partie_aktywne);
val_1  = wyniki_PL(partie_aktywne);
val_64 = wyniki_hist(partie_aktywne);

[~, srt] = sort(val_1 + val_64, 'descend');
nazwy_s  = nazwy(srt);
val_1_s  = val_1(srt);
val_64_s = val_64(srt);

x = 1:length(nazwy_s);
bar(x, [val_64_s' val_1_s']);
xticks(x);
xticklabels(nazwy_s);
xtickangle(40);
legend({'64 okręgi (historyczne)', '1 okrąg ogólnokrajowy'}, ...
       'Location', 'northeast', 'FontSize', 10);
ylabel('Liczba mandatów');
xlabel('Partia');
title({'Scenariusz 3B: Jeden okrąg ogólnokrajowy vs podział historyczny (64 okręgi)', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 12);
grid on;

% ---- Wykresy kołowe — porównanie parlamentów ----
figure('Name', 'Scenariusz 3B — Parlamenty (kołowe)', ...
       'NumberTitle', 'off', 'Position', [100 100 1200 520]);

partie_aktywne_1  = wyniki_PL   > 0;
partie_aktywne_64 = wyniki_hist > 0;

subplot(1, 2, 1);
pie(wyniki_hist(partie_aktywne_64));
legend(partie_1922(partie_aktywne_64), 'Location', 'eastoutside', 'FontSize', 7);
title({'Historyczny (64 okręgi)'}, 'FontSize', 11);

subplot(1, 2, 2);
pie(wyniki_PL(partie_aktywne_1));
legend(partie_1922(partie_aktywne_1), 'Location', 'eastoutside', 'FontSize', 7);
title({'Jeden okrąg ogólnokrajowy'}, 'FontSize', 11);

sgtitle('Scenariusz 3B: Porównanie składu parlamentu — Wybory 1922', 'FontSize', 12);

fprintf('\nPodscenariusz B zakończony.\n');
