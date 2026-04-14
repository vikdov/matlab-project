% =========================================================
% SCENARIUSZ KOALICJI C
% PRAWICA vs LEWICA vs MNIEJSZOĹšCI NARODOWE
%
% PRAWICA:     ChZJN(1), PC(7)
% LEWICA:      PPS(5), NPR(6), PSL-P(3), PSL-W(4), PSL-L(13), ChSR(10), Bund(11)
% MNIEJSZOĹšCI: BMN(2), KZSN-Ĺ»(8), KZPMiW(9), ZN-Ĺ»(12), Ĺ»DBL(14)
%
% GĹ‚osy "Inni" (kolumna 15) sÄ… pomijane.
% Mandaty liczone metodÄ… D'Hondta okrÄ™gowo.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

IDX_PRAWICA     = [1, 7];
IDX_LEWICA      = [3, 4, 5, 6, 13, 10, 11];
IDX_MNIEJSZOSCI = [2, 8, 9, 12, 14];

n_okregow = length(okregi_1922_mandaty);

% [prawica, lewica, mniejszosci]
mandaty_bloki = [0, 0, 0];

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);

    glosy_bloki = [sum(g(IDX_PRAWICA)), sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI))];
    wynik = dhondt(glosy_bloki, m);
    mandaty_bloki = mandaty_bloki + wynik;
end

total = sum(mandaty_bloki);

% ---- Wyniki ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ C: PRAWICA vs LEWICA vs MNIEJSZOSCI\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');

fprintf('  SkĹ‚ad blokĂłw:\n');
fprintf('  PRAWICA     : ChZJN, PC, ChSR\n');
fprintf('  LEWICA      : PSL-P, PSL-W, PPS, NPR, PSL-L\n');
fprintf('  MNIEJSZOĹšCI : BMN, KZSN-Ĺ», KZPMiW, Bund, ZN-Ĺ», Ĺ»DBL\n\n');

nazwy_blokow = {'PRAWICA', 'LEWICA', 'MNIEJSZOĹšCI'};
idx_blokow   = {IDX_PRAWICA, IDX_LEWICA, IDX_MNIEJSZOSCI};

sum_glosy = 0;
for b = 1:3
    sum_glosy = sum_glosy + sum(partie_1922_dane(idx_blokow{b}));
end

fprintf('%-14s %10s %12s %12s %12s\n', 'Blok', 'Mandaty', 'Mandaty %', 'GĹ‚osy %', 'Premia pp');
fprintf('%s\n', repmat('-', 1, 62));

for b = 1:3
    g_kraj = sum(partie_1922_dane(idx_blokow{b}));
    g_pct  = g_kraj / sum_glosy * 100;
    m_pct  = mandaty_bloki(b) / total * 100;
    prem   = m_pct - g_pct;
    fprintf('%-14s %10d %11.2f%% %11.2f%% %+11.2f\n', ...
        nazwy_blokow{b}, mandaty_bloki(b), m_pct, g_pct, prem);
end

fprintf('%s\n', repmat('-', 1, 62));
fprintf('%-14s %10d %11.2f%%\n', 'ĹÄ„CZNIE', total, 100.0);

% ---- Wykres ----
figure('Name', 'Scenariusz C', 'NumberTitle', 'off', 'Position', [100 100 1100 600]);

kolory = [0.15 0.25 0.70;   % prawica - granatowy
          0.85 0.15 0.15;   % lewica  - czerwony
          0.20 0.60 0.30];  % mniejszoĹ›ci - zielony

subplot(1,3,1);
pie(mandaty_bloki);
colormap(kolory);
legend(nazwy_blokow, 'Location', 'southoutside', 'FontSize', 9);
title('PodziaĹ‚ mandatĂłw');

subplot(1,3,2);
glosy_pct = zeros(1,3);
for b = 1:3
    glosy_pct(b) = sum(partie_1922_dane(idx_blokow{b})) / sum_glosy * 100;
end
mand_pct = mandaty_bloki / total * 100;

x = 1:3;
b_h = bar(x, [glosy_pct' mand_pct']);
b_h(1).FaceColor = [0.6 0.6 0.6];
b_h(2).FaceColor = [0.3 0.3 0.8];
xticks(x); xticklabels(nazwy_blokow); xtickangle(15);
legend({'GĹ‚osy %', 'Mandaty %'}, 'Location', 'north');
ylabel('%');
title('GĹ‚osy vs Mandaty');
grid on;

subplot(1,3,3);
premia = mand_pct - glosy_pct;
b_p = bar(x, premia);
b_p.FaceColor = 'flat';
for b = 1:3
    if premia(b) >= 0
        b_p.CData(b,:) = [0.2 0.7 0.2];
    else
        b_p.CData(b,:) = [0.8 0.2 0.2];
    end
end
xticks(x); xticklabels(nazwy_blokow); xtickangle(15);
yline(0, 'k-', 'LineWidth', 1.2);
ylabel('Premia/strata (pp)');
title('Premia proporcjonalnoĹ›ci');
grid on;

sgtitle({'Scenariusz C: Prawica vs Lewica vs MniejszoĹ›ci Narodowe', 'Wybory 1922'}, 'FontSize', 13);

% ---- Analiza moĹĽliwoĹ›ci koalicyjnych ----
fprintf('\n--- MoĹĽliwoĹ›ci tworzenia wiÄ™kszoĹ›ci (>%d mandatĂłw) ---\n', floor(total/2));
prog_wiekszosci = floor(total/2) + 1;

fprintf('\n  Koalicja Prawica + Lewica     : %d mandatĂłw', mandaty_bloki(1)+mandaty_bloki(2));
if mandaty_bloki(1)+mandaty_bloki(2) >= prog_wiekszosci
    fprintf('  âś“ WIÄKSZOĹšÄ†');
end
fprintf('\n');

fprintf('  Koalicja Prawica + MniejszoĹ›ci: %d mandatĂłw', mandaty_bloki(1)+mandaty_bloki(3));
if mandaty_bloki(1)+mandaty_bloki(3) >= prog_wiekszosci
    fprintf('  âś“ WIÄKSZOĹšÄ†');
end
fprintf('\n');

fprintf('  Koalicja Lewica + MniejszoĹ›ci : %d mandatĂłw', mandaty_bloki(2)+mandaty_bloki(3));
if mandaty_bloki(2)+mandaty_bloki(3) >= prog_wiekszosci
    fprintf('  âś“ WIÄKSZOĹšÄ†');
end
fprintf('\n');

fprintf('\nScenariusz C zakoĹ„czony.\n');
