% =========================================================
% SCENARIUSZ 2: Metoda Sainte-Lague
% Porownanie: D'Hondt (hist.) vs czysta SL vs zmodyfikowana SL
% Plik: Scenariusz_2/scenariusz2_sainte_lague.m
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

wyniki_dh   = zeros(1, n_partii);
wyniki_sl   = zeros(1, n_partii);
wyniki_slz  = zeros(1, n_partii);

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);
    wyniki_dh  = wyniki_dh  + dhondt(g, m);
    wyniki_sl  = wyniki_sl  + sainte_lague(g, m, false);
    wyniki_slz = wyniki_slz + sainte_lague(g, m, true);
end

total = sum(wyniki_dh);

% ---- Konsola ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 2: Metoda Sainte-Lague\n');
fprintf('  Porownanie z D''Hondtem (historycznym)\n');
fprintf('========================================================\n');
fprintf('%-12s %12s %12s %12s\n','Partia','D''Hondt(hist)','Czysta SL','Zmod. SL');
fprintf('%s\n', repmat('-',1,52));
[~,idx] = sort(wyniki_dh,'descend');
for i = 1:n_partii
    p = idx(i);
    if any([wyniki_dh(p), wyniki_sl(p), wyniki_slz(p)] > 0)
        d1 = wyniki_sl(p)  - wyniki_dh(p);
        d2 = wyniki_slz(p) - wyniki_dh(p);
        s1=''; s2='';
        if d1~=0, s1=sprintf('(%+d)',d1); end
        if d2~=0, s2=sprintf('(%+d)',d2); end
        fprintf('%-12s %12d %10d %-5s %10d %-5s\n', ...
            partie_1922{p}, wyniki_dh(p), wyniki_sl(p), s1, wyniki_slz(p), s2);
    end
end
fprintf('%s\n', repmat('-',1,52));
fprintf('%-12s %12d %12d %12d\n','LACZNIE',sum(wyniki_dh),sum(wyniki_sl),sum(wyniki_slz));

% ---- Indeks Gallaghera ----
glosy_n = partie_1922_dane/sum(partie_1922_dane)*100;
fprintf('\n--- Indeks Gallaghera ---\n');
for [w, lbl] = [wyniki_dh; wyniki_sl; wyniki_slz], end  % dummy — robimy recznie:
metody = {wyniki_dh, wyniki_sl, wyniki_slz};
etyk_g = {'D''Hondt (hist.)', 'Czysta S-L', 'Zmod. S-L'};
for k=1:3
    G = sqrt(0.5*sum((glosy_n - metody{k}/sum(metody{k})*100).^2));
    fprintf('  %-18s  G = %.4f\n', etyk_g{k}, G);
end

% ---- Wykres ----
figure('Name','Sainte-Lague vs D''Hondt','NumberTitle','off','Position',[50 50 1100 600]);

partie_akt = (wyniki_dh>0)|(wyniki_sl>0)|(wyniki_slz>0);
naz  = partie_1922(partie_akt);
vDH  = wyniki_dh(partie_akt);
vSL  = wyniki_sl(partie_akt);
vSLZ = wyniki_slz(partie_akt);

[~,srt] = sort(vDH,'descend');
naz=naz(srt); vDH=vDH(srt); vSL=vSL(srt); vSLZ=vSLZ(srt);
x = 1:length(naz);

subplot(2,1,1);
bar(x, [vDH' vSL' vSLZ']);
xticks(x); xticklabels(naz); xtickangle(40);
legend({'D''Hondt (hist.)','Czysta Sainte-Lague','Zmod. Sainte-Lague'},'Location','northeast');
ylabel('Mandaty');
title('Liczba mandatow: D''Hondt vs Sainte-Lague (czysta i zmodyfikowana)','FontSize',11);
grid on;

subplot(2,1,2);
delta_sl  = vSL  - vDH;
delta_slz = vSLZ - vDH;
bar(x, [delta_sl' delta_slz']);
xticks(x); xticklabels(naz); xtickangle(40);
yline(0,'k-','LineWidth',1.2);
legend({'Czysta SL - D''Hondt','Zmod. SL - D''Hondt'},'Location','northeast');
ylabel('Zmiana mandatow');
title('Odchylenie od D''Hondta (+ = wiecej niz historycznie)','FontSize',11);
grid on;

sgtitle({'Scenariusz 2: Sainte-Lague vs D''Hondt','Wybory parlamentarne 1922'},'FontSize',13);
fprintf('\nScenariusz 2 (Sainte-Lague) zakonczony.\n');
