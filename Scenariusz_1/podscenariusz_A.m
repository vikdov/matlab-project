% =========================================================
% SCENARIUSZ KOALICJI A
% Koalicja LEWICA vs RESZTA PARTII
%
% LEWICA:  PPS(5), NPR(6), PSL-P(3), PSL-W(4), PSL-L(13)
% PRAWICA: ChZJN(1), PC(7), ChSR(10)
% CENTRUM: pozostałe partie (bez mniejszości i bez "Inni")
%   czyli: BMN(2), KZSN-Ż(8), KZPMiW(9), Bund(11), ZN-Ż(12), ŻDBL(14)
%   traktowane jako "RESZTA" razem z prawicą
%
% Głosy "Inni" (kolumna 15) są pomijane (zerowane).
% Mandaty liczone metodą D'Hondta okręgowo.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

% ---- Definicja bloków (indeksy kolumn w macierzy danych) ----
% partie_1922 = {ChZJN,BMN,PSL-P,PSL-W,PPS,NPR,PC,KZSN-Ż,KZPMiW,ChSR,Bund,ZN-Ż,PSL-L,ŻDBL,Inni}
%                  1    2    3    4    5    6   7    8      9     10   11   12   13    14   15

IDX_LEWICA  = [3, 4, 5, 6, 13];   % PSL-P, PSL-W, PPS, NPR, PSL-L
IDX_RESZTA  = [1, 2, 7, 8, 9, 10, 11, 12, 14];  % ChZJN, BMN, PC, KZSN-Ż, KZPMiW, ChSR, Bund, ZN-Ż, ŻDBL
IDX_INNI    = 15;  % pomijamy

n_okregow = length(okregi_1922_mandaty);

mandaty_lewica = 0;
mandaty_reszta = 0;

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);

    glosy_bloki = [sum(g(IDX_LEWICA)), sum(g(IDX_RESZTA))];
    wynik = dhondt(glosy_bloki, m);

    mandaty_lewica = mandaty_lewica + wynik(1);
    mandaty_reszta = mandaty_reszta + wynik(2);
end

total = mandaty_lewica + mandaty_reszta;

% ---- Wyniki ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ A: LEWICA vs RESZTA\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');

fprintf('  Skład bloków:\n');
fprintf('  LEWICA : PSL-P, PSL-W, PPS, NPR, PSL-L\n');
fprintf('  RESZTA : ChZJN, BMN, PC, KZSN-Ż, KZPMiW, ChSR, Bund, ZN-Ż, ŻDBL\n\n');

fprintf('%-12s %10s %12s %12s\n', 'Blok', 'Mandaty', 'Udział %', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 48));

glosy_lewica_kraj = sum(partie_1922_dane(IDX_LEWICA));
glosy_reszta_kraj = sum(partie_1922_dane(IDX_RESZTA));

fprintf('%-12s %10d %11.2f%% %11.2f%%\n', 'LEWICA',  mandaty_lewica, mandaty_lewica/total*100, glosy_lewica_kraj);
fprintf('%-12s %10d %11.2f%% %11.2f%%\n', 'RESZTA',  mandaty_reszta, mandaty_reszta/total*100, glosy_reszta_kraj);
fprintf('%s\n', repmat('-', 1, 48));
fprintf('%-12s %10d %11.2f%%\n', 'ŁĄCZNIE', total, 100.0);

fprintf('\n  Premia/strata proporcjonalności:\n');
prem_lew = mandaty_lewica/total*100 - glosy_lewica_kraj/(glosy_lewica_kraj+glosy_reszta_kraj)*100;
fprintf('  LEWICA : %+.2f pp\n', prem_lew);
fprintf('  RESZTA : %+.2f pp\n', -prem_lew);

% ---- Wykres ----
figure('Name', 'Scenariusz A: Lewica vs Reszta', 'NumberTitle', 'off', 'Position', [100 100 800 550]);

subplot(1,2,1);
pie([mandaty_lewica, mandaty_reszta]);
legend({'LEWICA', 'RESZTA'}, 'Location', 'southoutside');
title('Podział mandatów');
colormap([0.85 0.15 0.15; 0.20 0.45 0.70]);

subplot(1,2,2);
bloki   = {'LEWICA', 'RESZTA'};
mandaty = [mandaty_lewica, mandaty_reszta];
glosy   = [glosy_lewica_kraj, glosy_reszta_kraj] / (glosy_lewica_kraj+glosy_reszta_kraj) * 100;
mand_pct = mandaty / total * 100;

x = 1:2;
bar_h = bar(x, [glosy' mand_pct']);
bar_h(1).FaceColor = [0.6 0.6 0.6];
bar_h(2).FaceColor = [0.2 0.6 0.2];
xticks(x); xticklabels(bloki);
legend({'Głosy %', 'Mandaty %'}, 'Location', 'north');
ylabel('%');
title('Głosy vs Mandaty');
grid on;

sgtitle({'Scenariusz A: Koalicja Lewicy vs Reszta', 'Wybory 1922'}, 'FontSize', 13);

fprintf('\nScenariusz A zakończony.\n');
