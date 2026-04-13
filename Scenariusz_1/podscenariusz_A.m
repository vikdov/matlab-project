% =========================================================
% SCENARIUSZ KOALICJI A
% Koalicja LEWICA vs pozostałe partie osobno
% Plik: Scenariusz_1/scenariuszA_lewica_vs_reszta.m
%
% LEWICA (wspólna lista): PPS(5), NPR(6), PSL-P(3), PSL-W(4), PSL-L(13)
% POZOSTAŁE partie startują każda osobno:
%   ChZJN(1), BMN(2), PC(7), KZSN-Ż(8), KZPMiW(9), ChSR(10),
%   Bund(11), ZN-Ż(12), ŻDBL(14)
% Głosy "Inni" (kol. 15) pomijane.
% Mandaty: D'Hondt okręgowo.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

IDX_LEWICA    = [3, 4, 5, 6, 13];
IDX_POZOSTALE = [1, 2, 7, 8, 9, 10, 11, 12, 14];

n_partii_plot = 1 + length(IDX_POZOSTALE);
n_okregow     = length(okregi_1922_mandaty);
etykiety      = [{'LEWICA (blok)'}, partie_1922(IDX_POZOSTALE)];
wyniki        = zeros(1, n_partii_plot);

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);
    glosy_bloki = [sum(g(IDX_LEWICA)), g(IDX_POZOSTALE)];
    wyniki = wyniki + dhondt(glosy_bloki, m);
end

total = sum(wyniki);
glosy_kraj_bloki = [sum(partie_1922_dane(IDX_LEWICA)), partie_1922_dane(IDX_POZOSTALE)];
suma_glosy       = sum(glosy_kraj_bloki);

% ---- Konsola ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ A: LEWICA (blok) vs pozostale partie\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');
fprintf('  Sklad koalicji lewicowej: PSL-P, PSL-W, PPS, NPR, PSL-L\n\n');
fprintf('%-16s %8s %10s %10s %10s\n', 'Partia/Blok', 'Mandaty', 'Mand.%', 'Glosy%', 'Premia pp');
fprintf('%s\n', repmat('-', 1, 58));
[~, srt] = sort(wyniki, 'descend');
for i = 1:n_partii_plot
    k     = srt(i);
    m_pct = wyniki(k)/total*100;
    g_pct = glosy_kraj_bloki(k)/suma_glosy*100;
    marker = ''; if k==1, marker=' << koalicja'; end
    fprintf('%-16s %8d %9.2f%% %9.2f%% %+9.2f%s\n', ...
        etykiety{k}, wyniki(k), m_pct, g_pct, m_pct-g_pct, marker);
end
fprintf('%s\n', repmat('-', 1, 58));
fprintf('%-16s %8d\n', 'LACZNIE', total);

% ---- Wykres ----
figure('Name','Scenariusz A','NumberTitle','off','Position',[50 50 1200 600]);

[wyniki_sort, srt2] = sort(wyniki, 'descend');
etyk_sort  = etykiety(srt2);
glosy_sort = glosy_kraj_bloki(srt2)/suma_glosy*100;
mand_sort  = wyniki_sort/total*100;
kolory = repmat([0.45 0.55 0.75], n_partii_plot, 1);
kolory(find(srt2==1), :) = [0.85 0.15 0.15];

subplot(2,1,1);
b = bar(1:n_partii_plot, wyniki_sort);
b.FaceColor = 'flat'; b.CData = kolory;
xticks(1:n_partii_plot); xticklabels(etyk_sort); xtickangle(40);
ylabel('Mandaty'); title('Mandaty — Lewica (blok) vs pozostale partie','FontSize',11); grid on;

subplot(2,1,2);
bh = bar(1:n_partii_plot, [glosy_sort' mand_sort']);
bh(1).FaceColor=[0.65 0.65 0.65]; bh(2).FaceColor=[0.25 0.65 0.25];
xticks(1:n_partii_plot); xticklabels(etyk_sort); xtickangle(40);
legend({'Glosy %','Mandaty %'},'Location','northeast');
ylabel('%'); title('Glosy vs Mandaty','FontSize',11); grid on;

sgtitle({'Scenariusz A: Koalicja Lewicy vs pozostale partie','Wybory 1922'},'FontSize',13);
fprintf('\nScenariusz A zakonczony.\n');
