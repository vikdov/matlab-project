% =========================================================
% SCENARIUSZ 3 — PODSCENARIUSZ A
% Dwa duże okręgi wyborcze: Polska "A" i Polska "B"
%
% Polska A = okręgi centralne i zachodnie  (204 mandaty)
% Polska B = okręgi wschodnie i kresowe   (168 mandatów)
%
% Wyniki porównane z historycznym podziałem na 64 okręgi.
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, '..', 'wspolne', 'dane_1922.m'));
run(fullfile(sciezka, 'dane_okregi.m'));

% ---- Obliczenia — 2 okręgi ----
n_partii = length(partie_1922);

wyniki_AB   = zeros(1, n_partii);
wyniki_hist = zeros(1, n_partii);

% Dwa makrookręgi
for o = 1:2
    wyniki_AB = wyniki_AB + dhondt(okregi_AB_dane(o, :), okregi_AB_mandaty(o));
end

% Historyczne 64 okręgi (dla porównania)
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o, :), okregi_1922_mandaty(o));
end

total = sum(wyniki_AB);

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3 — PODSCENARIUSZ A\n');
fprintf('  Dwa okręgi: Polska "A" (204 m.) + Polska "B" (168 m.)\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %12s %12s %10s\n', 'Partia', '2 okręgi', 'Hist. (64)', 'Różnica');
fprintf('%s\n', repmat('-', 1, 50));

[~, idx] = sort(wyniki_AB, 'descend');
for i = 1:n_partii
    if wyniki_AB(idx(i)) > 0 || wyniki_hist(idx(i)) > 0
        diff = wyniki_AB(idx(i)) - wyniki_hist(idx(i));
        diff_str = '';
        if diff > 0,     diff_str = sprintf('+%d', diff);
        elseif diff < 0, diff_str = sprintf('%d', diff);
        end
        fprintf('%-12s %12d %12d %10s\n', ...
            partie_1922{idx(i)}, wyniki_AB(idx(i)), wyniki_hist(idx(i)), diff_str);
    end
end
fprintf('%s\n', repmat('-', 1, 50));
fprintf('%-12s %12d %12d\n', 'ŁĄCZNIE', sum(wyniki_AB), sum(wyniki_hist));

% ---- Wykres słupkowy porównawczy ----
figure('Name', 'Scenariusz 3A — 2 okręgi vs 64 okręgi', ...
       'NumberTitle', 'off', 'Position', [50 50 1050 580]);

partie_aktywne = (wyniki_AB > 0) | (wyniki_hist > 0);
nazwy = partie_1922(partie_aktywne);
val_2  = wyniki_AB(partie_aktywne);
val_64 = wyniki_hist(partie_aktywne);

[~, srt] = sort(val_2 + val_64, 'descend');
nazwy_s  = nazwy(srt);
val_2_s  = val_2(srt);
val_64_s = val_64(srt);

x = 1:length(nazwy_s);
bar(x, [val_64_s' val_2_s']);
xticks(x);
xticklabels(nazwy_s);
xtickangle(40);
legend({'64 okręgi (historyczne)', 'Polska A + Polska B (2 okręgi)'}, ...
       'Location', 'northeast', 'FontSize', 10);
ylabel('Liczba mandatów');
xlabel('Partia');
title({'Scenariusz 3A: Dwa makrookręgi (Polska A i B) vs podział historyczny (64 okręgi)', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 12);
grid on;

% ---- Wykresy kołowe — porównanie parlamentów ----
figure('Name', 'Scenariusz 3A — Parlamenty (kołowe)', ...
       'NumberTitle', 'off', 'Position', [100 100 1200 520]);

partie_aktywne_2  = wyniki_AB   > 0;
partie_aktywne_64 = wyniki_hist > 0;

subplot(1, 2, 1);
pie(wyniki_hist(partie_aktywne_64));
legend(partie_1922(partie_aktywne_64), 'Location', 'eastoutside', 'FontSize', 7);
title({'Historyczny (64 okręgi)'}, 'FontSize', 11);

subplot(1, 2, 2);
pie(wyniki_AB(partie_aktywne_2));
legend(partie_1922(partie_aktywne_2), 'Location', 'eastoutside', 'FontSize', 7);
title({'Dwa makrookręgi (Polska A + B)'}, 'FontSize', 11);

sgtitle('Scenariusz 3A: Porównanie składu parlamentu — Wybory 1922', 'FontSize', 12);

fprintf('\nPodscenariusz A zakończony.\n');
