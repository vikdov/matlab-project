% =========================================================
% SCENARIUSZ 3 — PODSCENARIUSZ B
% Jeden okrąg ogólnokrajowy (444 mandaty)
% Plik: Scenariusz_3/podscenariusz_B.m
%
% Cały kraj traktowany jako jeden wielomandatowy okrąg.
% Głosy = ogólnopolskie wyniki partii z dane_1922.m
% Mandaty = 444 (historyczna liczba z 1922 r.)
% Przeliczanie: D'Hondt, Sainte-Laguë, Hamilton — porównanie.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

MANDATY_KRAJ = 444;

% ---- Przeliczenie mandatów różnymi metodami ----
glosy_kraj = partie_1922_dane;  % wyniki ogólnopolskie w %

wyniki_dh  = dhondt(glosy_kraj, MANDATY_KRAJ);
wyniki_sl  = sainte_lague(glosy_kraj, MANDATY_KRAJ, false);
wyniki_ham = hamilton(glosy_kraj, MANDATY_KRAJ);

% Wynik historyczny (64 okręgi, D'Hondt) dla porównania
wyniki_hist = zeros(1, length(partie_1922));
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o,:), okregi_1922_mandaty(o));
end

% ---- Wyniki ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3B: Jeden okrąg ogólnokrajowy\n');
fprintf('  %d mandatów, głosy wg wyników krajowych\n', MANDATY_KRAJ);
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');

fprintf('%-12s %12s %12s %12s %12s\n', ...
    'Partia', 'D''Hondt', 'S-Laguë', 'Hamilton', 'Hist.(64okr)');
fprintf('%s\n', repmat('-', 1, 64));

[~, idx] = sort(wyniki_dh, 'descend');
for i = 1:length(partie_1922)
    p = idx(i);
    if any([wyniki_dh(p), wyniki_sl(p), wyniki_ham(p), wyniki_hist(p)] > 0)
        fprintf('%-12s %12d %12d %12d %12d\n', ...
            partie_1922{p}, wyniki_dh(p), wyniki_sl(p), wyniki_ham(p), wyniki_hist(p));
    end
end

fprintf('%s\n', repmat('-', 1, 64));
fprintf('%-12s %12d %12d %12d %12d\n', ...
    'ŁĄCZNIE', sum(wyniki_dh), sum(wyniki_sl), sum(wyniki_ham), sum(wyniki_hist));

% ---- Indeks Gallaghera ----
fprintf('\n--- Indeks proporcjonalności Gallaghera ---\n');
fprintf('  (mniejszy = bardziej proporcjonalny)\n\n');

metody   = {wyniki_dh, wyniki_sl, wyniki_ham, wyniki_hist};
etykiety = {'1 okrąg D''Hondt', '1 okrąg S-Laguë', '1 okrąg Hamilton', 'Hist. 64 okr. D''H'};
glosy_n  = glosy_kraj / sum(glosy_kraj) * 100;

for m = 1:4
    tot_m = sum(metody{m});
    mand_pct = metody{m} / tot_m * 100;
    G = sqrt(0.5 * sum((glosy_n - mand_pct).^2));
    fprintf('  %-22s  G = %.4f\n', etykiety{m}, G);
end

% ---- Wykres ----
figure('Name', 'Scenariusz 3B: Jeden okrąg ogólnokrajowy', ...
       'NumberTitle', 'off', 'Position', [50 50 1200 650]);

partie_aktywne = (wyniki_dh > 0) | (wyniki_hist > 0);
naz  = partie_1922(partie_aktywne);
vDH  = wyniki_dh(partie_aktywne);
vSL  = wyniki_sl(partie_aktywne);
vHAM = wyniki_ham(partie_aktywne);
vHIST= wyniki_hist(partie_aktywne);

[~, srt] = sort(vDH, 'descend');
naz=naz(srt); vDH=vDH(srt); vSL=vSL(srt); vHAM=vHAM(srt); vHIST=vHIST(srt);
x = 1:length(naz);

subplot(2,1,1);
bar(x, [vDH' vSL' vHAM']);
xticks(x); xticklabels(naz); xtickangle(40);
legend({'D''Hondt', 'Sainte-Laguë', 'Hamilton'}, 'Location', 'northeast');
ylabel('Mandaty');
title(sprintf('Jeden okrąg krajowy (%d mandatów) — porównanie metod', MANDATY_KRAJ), 'FontSize', 11);
grid on;

subplot(2,1,2);
bar(x, [vHIST' vDH']);
xticks(x); xticklabels(naz); xtickangle(40);
legend({'Historyczny (64 okręgi, D''H)', sprintf('1 okrąg (%d m., D''H)', MANDATY_KRAJ)}, ...
       'Location', 'northeast');
ylabel('Mandaty');
title('Porównanie: historyczny wynik vs jeden okrąg krajowy', 'FontSize', 11);
grid on;

sgtitle({'Scenariusz 3B: Jeden okrąg ogólnokrajowy (444 mandaty)', ...
         'Wybory parlamentarne 1922'}, 'FontSize', 13);

fprintf('\nPodscenariusz B zakończony.\n');
