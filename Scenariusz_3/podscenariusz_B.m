% =========================================================
% SCENARIUSZ 3 — PODSCENARIUSZ B
% Jeden okrag ogolnokrajowy (444 mandaty)
% Plik: Scenariusz_3/podscenariusz_B.m
%
% Pokazuje, ze przy jednym okragu metoda obliczen ma
% niewielkie znaczenie — chyba ze zastosujemy prog wyborczy.
%
% Warianty:
%   1. D'Hondt           (bez progu)
%   2. Sainte-Lague      (bez progu)
%   3. Hamilton          (bez progu)
%   4. D'Hondt + prog 5% (naturalny efekt wykluczajacy)
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

MANDATY_KRAJ = 444;
PROG         = 5.0;

glosy_kraj      = partie_1922_dane;
partie_pow_prog = glosy_kraj >= PROG;
glosy_z_prog    = glosy_kraj;
glosy_z_prog(~partie_pow_prog) = 0;

wyniki_dh   = dhondt(glosy_kraj,      MANDATY_KRAJ);
wyniki_sl   = sainte_lague(glosy_kraj, MANDATY_KRAJ, false);
wyniki_ham  = hamilton(glosy_kraj,     MANDATY_KRAJ);
wyniki_prog = dhondt(glosy_z_prog,    MANDATY_KRAJ);

% Wynik historyczny (64 okregi, D'Hondt)
wyniki_hist = zeros(1, length(partie_1922));
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o,:), okregi_1922_mandaty(o));
end

% ---- Konsola ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 3B: Jeden okrag ogolnokrajowy (%d mand.)\n', MANDATY_KRAJ);
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n\n');
fprintf('  Partie wykluczone przez prog %.0f%%:\n', PROG);
for i=1:length(partie_1922)
    if ~partie_pow_prog(i)
        fprintf('    %-10s  %.2f%%\n', partie_1922{i}, glosy_kraj(i));
    end
end
fprintf('\n');

etyk_met = {"D'Hondt", "Sainte-Lague", "Hamilton", "D'Hondt+5%", "Hist.(64okr)"};
W_all = [wyniki_dh; wyniki_sl; wyniki_ham; wyniki_prog; wyniki_hist];

fprintf('%-12s %12s %14s %12s %14s %14s\n','Partia',etyk_met{:});
fprintf('%s\n', repmat('-',1,80));
[~,idx] = sort(wyniki_dh,'descend');
for i=1:length(partie_1922)
    p = idx(i);
    if any(W_all(:,p)>0)
        fprintf('%-12s %12d %14d %12d %14d %14d\n', ...
            partie_1922{p}, wyniki_dh(p), wyniki_sl(p), wyniki_ham(p), ...
            wyniki_prog(p), wyniki_hist(p));
    end
end
fprintf('%s\n', repmat('-',1,80));
fprintf('%-12s %12d %14d %12d %14d %14d\n','LACZNIE',...
    sum(wyniki_dh),sum(wyniki_sl),sum(wyniki_ham),sum(wyniki_prog),sum(wyniki_hist));

% ---- Indeks Gallaghera ----
fprintf('\n--- Indeks Gallaghera (proporcjonalnosc) ---\n');
glosy_n = glosy_kraj/sum(glosy_kraj)*100;
metody_G = {wyniki_dh, wyniki_sl, wyniki_ham, wyniki_prog, wyniki_hist};
for k=1:5
    tot = sum(metody_G{k});
    G = sqrt(0.5*sum((glosy_n - metody_G{k}/tot*100).^2));
    fprintf('  %-20s  G = %.4f\n', etyk_met{k}, G);
end
fprintf('\n  Interpretacja: metody bez progu maja podobny G\n');
fprintf('  D''Hondt+5%% jest znacznie mniej proporcjonalny.\n');

% ---- Wykres ----
figure('Name','Scenariusz 3B: Jeden okrag ogolnokrajowy',...
       'NumberTitle','off','Position',[50 50 1300 700]);

partie_akt = any(W_all>0,1);
naz = partie_1922(partie_akt);
Wp  = W_all(:,partie_akt);

[~,srt] = sort(Wp(1,:),'descend');
naz=naz(srt); Wp=Wp(:,srt);
x = 1:length(naz);

subplot(2,1,1);
bar(x, Wp(1:3,:)');
xticks(x); xticklabels(naz); xtickangle(40);
legend(etyk_met(1:3),'Location','northeast');
ylabel('Mandaty');
title(sprintf('1 okrag %d mand. — D''Hondt vs S-Lague vs Hamilton (bez progu)', MANDATY_KRAJ),'FontSize',11);
grid on;
annotation_txt = 'Metody bez progu daja bardzo podobne wyniki';
text(0.5, 0.92, annotation_txt,'Units','normalized','HorizontalAlignment','center',...
     'FontSize',9,'Color',[0.4 0.4 0.4]);

subplot(2,1,2);
bar(x, [Wp(5,:)' Wp(1,:)' Wp(4,:)']);
xticks(x); xticklabels(naz); xtickangle(40);
legend({'Hist. 64 okr.', sprintf('1 okrag D''H (bez progu)'), sprintf('1 okrag D''H + %.0f%% prog',PROG)},...
       'Location','northeast');
ylabel('Mandaty');
title(sprintf('Efekt progu %.0f%% vs brak progu vs historyczny wynik',PROG),'FontSize',11);
grid on;

sgtitle({'Scenariusz 3B: Jeden okrag ogolnokrajowy',...
         'Metoda ma male znaczenie — prog wyborczy ma duze'},'FontSize',13);

fprintf('\nPodscenariusz B zakonczony.\n');
