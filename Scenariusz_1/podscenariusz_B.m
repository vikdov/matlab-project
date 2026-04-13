% =========================================================
% SCENARIUSZ KOALICJI B
% LEWICA (blok) vs MNIEJSZOSCI (blok) vs pozostale partie osobno
% Plik: Scenariusz_1/scenariuszB_lewica_mniejszosci_reszta.m
%
% LEWICA (blok):      PSL-P(3), PSL-W(4), PPS(5), NPR(6), PSL-L(13)
% MNIEJSZOSCI (blok): BMN(2), KZSN-Z(8), KZPMiW(9), Bund(11), ZN-Z(12), ZDBL(14)
% POZOSTALE (osobno): ChZJN(1), PC(7), ChSR(10)
% Glosy "Inni" (kol.15) pomijane.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

IDX_LEWICA      = [3, 4, 5, 6, 13];
IDX_MNIEJSZOSCI = [2, 8, 9, 11, 12, 14];
IDX_POZOSTALE   = [1, 7, 10];   % ChZJN, PC, ChSR — startuja osobno

% Wektor "graczy": [lewica, mniejszosci, ChZJN, PC, ChSR]
etykiety = [{'LEWICA (blok)'}, {'MNIEJSZOSCI (blok)'}, partie_1922(IDX_POZOSTALE)];
n_graczy = 2 + length(IDX_POZOSTALE);
wyniki   = zeros(1, n_graczy);
n_okregow = length(okregi_1922_mandaty);

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);
    glosy_vec = [sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI)), g(IDX_POZOSTALE)];
    wyniki = wyniki + dhondt(glosy_vec, m);
end

total = sum(wyniki);
glosy_kraj = [sum(partie_1922_dane(IDX_LEWICA)), sum(partie_1922_dane(IDX_MNIEJSZOSCI)), partie_1922_dane(IDX_POZOSTALE)];
suma_glosy = sum(glosy_kraj);

% ---- Konsola ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ B: LEWICA + MNIEJSZOSCI (bloki) vs pozostale\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');
fprintf('  Lewica: PSL-P, PSL-W, PPS, NPR, PSL-L\n');
fprintf('  Mniejszosci: BMN, KZSN-Z, KZPMiW, Bund, ZN-Z, ZDBL\n');
fprintf('  Pozostale (osobno): ChZJN, PC, ChSR\n\n');
fprintf('%-20s %8s %10s %10s %10s\n','Partia/Blok','Mandaty','Mand.%','Glosy%','Premia pp');
fprintf('%s\n', repmat('-',1,62));
[~,srt] = sort(wyniki,'descend');
for i = 1:n_graczy
    k = srt(i);
    m_pct = wyniki(k)/total*100;
    g_pct = glosy_kraj(k)/suma_glosy*100;
    fprintf('%-20s %8d %9.2f%% %9.2f%% %+9.2f\n', etykiety{k}, wyniki(k), m_pct, g_pct, m_pct-g_pct);
end
fprintf('%s\n', repmat('-',1,62));
fprintf('%-20s %8d\n','LACZNIE',total);

% ---- Analiza koalicji powyborczych ----
prog = floor(total/2)+1;
fprintf('\n--- Mozliwe koalicje dajace wiekszoc (%d mandatow) ---\n', prog);
lew = wyniki(1); mn = wyniki(2); p_wyr = wyniki(3:end);
fprintf('  Lewica + Mniejszosci:       %d mand.', lew+mn);
if lew+mn >= prog, fprintf('  WIEKSZOC'); end; fprintf('\n');
fprintf('  Lewica + ChZJN:             %d mand.', lew+p_wyr(1));
if lew+p_wyr(1) >= prog, fprintf('  WIEKSZOC'); end; fprintf('\n');
fprintf('  Mniejszosci + ChZJN:        %d mand.', mn+p_wyr(1));
if mn+p_wyr(1) >= prog, fprintf('  WIEKSZOC'); end; fprintf('\n');
fprintf('  Lewica + Mniejszosci+ChZJN: %d mand.', lew+mn+p_wyr(1));
if lew+mn+p_wyr(1) >= prog, fprintf('  WIEKSZOC'); end; fprintf('\n');

% ---- Wykres ----
figure('Name','Scenariusz B','NumberTitle','off','Position',[50 50 1200 600]);

[wyniki_sort, srt2] = sort(wyniki,'descend');
etyk_sort  = etykiety(srt2);
glosy_sort = glosy_kraj(srt2)/suma_glosy*100;
mand_sort  = wyniki_sort/total*100;
kolory = repmat([0.45 0.55 0.75], n_graczy, 1);
kolory(find(srt2==1),:) = [0.85 0.15 0.15];
kolory(find(srt2==2),:) = [0.20 0.65 0.30];

subplot(2,1,1);
b = bar(1:n_graczy, wyniki_sort);
b.FaceColor='flat'; b.CData=kolory;
xticks(1:n_graczy); xticklabels(etyk_sort); xtickangle(40);
ylabel('Mandaty'); title('Mandaty — bloki vs partie osobno','FontSize',11); grid on;

subplot(2,1,2);
bh = bar(1:n_graczy,[glosy_sort' mand_sort']);
bh(1).FaceColor=[0.65 0.65 0.65]; bh(2).FaceColor=[0.25 0.65 0.25];
xticks(1:n_graczy); xticklabels(etyk_sort); xtickangle(40);
legend({'Glosy %','Mandaty %'},'Location','northeast');
ylabel('%'); title('Glosy vs Mandaty','FontSize',11); grid on;

sgtitle({'Scenariusz B: Lewica + Mniejszosci (bloki) vs pozostale','Wybory 1922'},'FontSize',13);
fprintf('\nScenariusz B zakonczony.\n');
