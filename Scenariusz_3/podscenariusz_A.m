% =========================================================
% SCENARIUSZ 3 — PODSCENARIUSZ A
% Dwa makrookręgi: Polska "A" vs Polska "B"
% Plik: Scenariusz_3/podscenariusz_A.m
%
% Zamiast 64 okręgów mamy dwa wielomandatowe makrookręgi:
%   POLSKA A (okręgi 1–40): Kongresówka + zabór pruski
%   POLSKA B (okręgi 41–64): Galicja + Kresy wschodnie
%
% Głosy każdej partii w makrookręgu = suma głosów ważonych
% liczbą wyborców, przybliżona przez mandaty okręgowe.
% Mandaty makrookręgu = suma mandatów okręgów składowych.
% Przeliczanie: metoda D'Hondta.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');
run('dane_okregi.m');

n_partii = length(partie_1922);

% ---- Agregacja głosów do makrookręgów ----
% Głosy ważone: dla każdego okręgu waga = liczba mandatów
% Funkcja agreguj_glosy.m musi być w folderze wspolne/
glosy_A = agreguj_glosy(okregi_1922_dane, okregi_1922_mandaty, IDX_POLSKA_A);
glosy_B = agreguj_glosy(okregi_1922_dane, okregi_1922_mandaty, IDX_POLSKA_B);

mandaty_A = sum(okregi_1922_mandaty(IDX_POLSKA_A));
mandaty_B = sum(okregi_1922_mandaty(IDX_POLSKA_B));

% ---- Przeliczenie mandatów D'Hondtem ----
wyniki_A = dhondt(glosy_A, mandaty_A);
wyniki_B = dhondt(glosy_B, mandaty_B);
wyniki_hist = zeros(1, n_partii);
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o,:), okregi_1922_mandaty(o));
end

wyniki_total = wyniki_A + wyniki_B;
total = sum(wyniki_total);

% ---- Wyniki ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3A: Dwa makrookręgi\n');
fprintf('  Polska "A" (%d okręgów, %d mandatów) + ', length(IDX_POLSKA_A), mandaty_A);
fprintf('Polska "B" (%d okręgów, %d mandatów)\n', length(IDX_POLSKA_B), mandaty_B);
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');

fprintf('%-12s %10s %10s %10s %10s %10s\n', ...
    'Partia', 'Polska A', 'Polska B', 'ŁĄCZNIE', 'Hist. (64)', 'Różnica');
fprintf('%s\n', repmat('-', 1, 62));

[~, idx] = sort(wyniki_total, 'descend');
for i = 1:n_partii
    p = idx(i);
    if wyniki_total(p) > 0 || wyniki_hist(p) > 0
        diff = wyniki_total(p) - wyniki_hist(p);
        diff_str = '';
        if diff > 0, diff_str = sprintf('+%d', diff);
        elseif diff < 0, diff_str = num2str(diff);
        end
        fprintf('%-12s %10d %10d %10d %10d %10s\n', ...
            partie_1922{p}, wyniki_A(p), wyniki_B(p), wyniki_total(p), wyniki_hist(p), diff_str);
    end
end
fprintf('%s\n', repmat('-', 1, 62));
fprintf('%-12s %10d %10d %10d %10d\n', 'ŁĄCZNIE', mandaty_A, mandaty_B, total, sum(wyniki_hist));

% ---- Wykres ----
figure('Name', 'Scenariusz 3A: Dwa makrookręgi', 'NumberTitle', 'off', ...
       'Position', [50 50 1200 600]);

partie_aktywne = (wyniki_total > 0) | (wyniki_hist > 0);
naz = partie_1922(partie_aktywne);
vA  = wyniki_A(partie_aktywne);
vB  = wyniki_B(partie_aktywne);
vH  = wyniki_hist(partie_aktywne);

[~, srt] = sort(wyniki_total(partie_aktywne), 'descend');
naz = naz(srt); vA = vA(srt); vB = vB(srt); vH = vH(srt);
x = 1:length(naz);

subplot(2,1,1);
bar(x, [vA' vB'], 'stacked');
xticks(x); xticklabels(naz); xtickangle(40);
legend({'Polska "A"', 'Polska "B"'}, 'Location', 'northeast');
ylabel('Mandaty');
title('Podział mandatów wg makrookręgów', 'FontSize', 11);
grid on;

subplot(2,1,2);
bar(x, [vH' (vA+vB)']);
xticks(x); xticklabels(naz); xtickangle(40);
legend({'Historyczny (64 okręgi)', 'Dwa makrookręgi'}, 'Location', 'northeast');
ylabel('Mandaty');
title('Porównanie: historyczny wynik vs dwa makrookręgi', 'FontSize', 11);
grid on;

sgtitle({'Scenariusz 3A: Dwa makrookręgi — Polska "A" i "B"', ...
         'Wybory parlamentarne 1922'}, 'FontSize', 13);

fprintf('\n--- Efekt geograficzny (różnica A vs B w strukturze głosów) ---\n');
fprintf('%-12s %12s %12s %12s\n', 'Partia', 'Głosy A %', 'Głosy B %', 'Różnica pp');
fprintf('%s\n', repmat('-', 1, 52));
for i = 1:n_partii
    p = idx(i);
    if glosy_A(p) > 0.5 || glosy_B(p) > 0.5
        fprintf('%-12s %11.2f%% %11.2f%% %+11.2f\n', ...
            partie_1922{p}, glosy_A(p), glosy_B(p), glosy_B(p)-glosy_A(p));
    end
end

fprintf('\nPodscenariusz A zakończony.\n');
