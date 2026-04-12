% =========================================================
% SCENARIUSZ KOALICJI B
% LEWICA vs MNIEJSZOŚCI NARODOWE vs RESZTA
%
% LEWICA:      PPS(5), NPR(6), PSL-P(3), PSL-W(4), PSL-L(13)
% MNIEJSZOŚCI: BMN(2), KZSN-Ż(8), KZPMiW(9), Bund(11), ZN-Ż(12), ŻDBL(14)
% RESZTA:      ChZJN(1), PC(7), ChSR(10)
%
% Głosy "Inni" (kolumna 15) są pomijane.
% Mandaty liczone metodą D'Hondta okręgowo.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

IDX_LEWICA      = [3, 4, 5, 6, 13];
IDX_MNIEJSZOSCI = [2, 8, 9, 11, 12, 14];
IDX_RESZTA      = [1, 7, 10];

n_okregow = length(okregi_1922_mandaty);

mandaty_bloki = [0, 0, 0];  % [lewica, mniejszosci, reszta]

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);

    glosy_bloki = [sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI)), sum(g(IDX_RESZTA))];
    wynik = dhondt(glosy_bloki, m);
    mandaty_bloki = mandaty_bloki + wynik;
end

total = sum(mandaty_bloki);

% ---- Wyniki ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ B: LEWICA vs MNIEJSZOSCI vs RESZTA\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');

fprintf('  Skład bloków:\n');
fprintf('  LEWICA      : PSL-P, PSL-W, PPS, NPR, PSL-L\n');
fprintf('  MNIEJSZOŚCI : BMN, KZSN-Ż, KZPMiW, Bund, ZN-Ż, ŻDBL\n');
fprintf('  RESZTA      : ChZJN, PC, ChSR\n\n');

nazwy_blokow = {'LEWICA', 'MNIEJSZOŚCI', 'RESZTA'};
idx_blokow   = {IDX_LEWICA, IDX_MNIEJSZOSCI, IDX_RESZTA};

fprintf('%-14s %10s %12s %12s %12s\n', 'Blok', 'Mandaty', 'Mandaty %', 'Głosy %', 'Premia pp');
fprintf('%s\n', repmat('-', 1, 62));

sum_glosy = 0;
for b = 1:3
    sum_glosy = sum_glosy + sum(partie_1922_dane(idx_blokow{b}));
end

for b = 1:3
    g_kraj = sum(partie_1922_dane(idx_blokow{b}));
    g_pct  = g_kraj / sum_glosy * 100;
    m_pct  = mandaty_bloki(b) / total * 100;
    prem   = m_pct - g_pct;
    fprintf('%-14s %10d %11.2f%% %11.2f%% %+11.2f\n', ...
        nazwy_blokow{b}, mandaty_bloki(b), m_pct, g_pct, prem);
end

fprintf('%s\n', repmat('-', 1, 62));
fprintf('%-14s %10d %11.2f%%\n', 'ŁĄCZNIE', total, 100.0);

% ---- Wykres ----
figure('Name', 'Scenariusz B', 'NumberTitle', 'off', 'Position', [100 100 1000 550]);

kolory = [0.85 0.15 0.15;   % lewica - czerwony
          0.20 0.60 0.30;   % mniejszości - zielony
          0.20 0.35 0.70];  % reszta - niebieski

subplot(1,2,1);
pie(mandaty_bloki);
colormap(kolory);
legend(nazwy_blokow, 'Location', 'southoutside', 'FontSize', 9);
title('Podział mandatów');

subplot(1,2,2);
glosy_pct = zeros(1,3);
for b = 1:3
    glosy_pct(b) = sum(partie_1922_dane(idx_blokow{b})) / sum_glosy * 100;
end
mand_pct = mandaty_bloki / total * 100;

x = 1:3;
b_h = bar(x, [glosy_pct' mand_pct']);
b_h(1).FaceColor = [0.6 0.6 0.6];
b_h(2).FaceColor = [0.3 0.7 0.3];
xticks(x); xticklabels(nazwy_blokow); xtickangle(15);
legend({'Głosy %', 'Mandaty %'}, 'Location', 'north');
ylabel('%');
title('Głosy vs Mandaty');
grid on;

sgtitle({'Scenariusz B: Lewica vs Mniejszości vs Reszta', 'Wybory 1922'}, 'FontSize', 13);

fprintf('\nScenariusz B zakończony.\n');
