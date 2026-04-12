% =========================================================
% SCENARIUSZ 1 — PODSCENARIUSZ C
% Koalicja prawicy vs Koalicja lewicy vs Koalicja mniejszości
%
% PJN = koalicja prawicowo-centrowa (ChZJN + PC + NPR + inne)
% PZL = zjednoczona lewica (PSL-P + PSL-W + PSL-L + PPS)
% WMN = zjednoczone mniejszości narodowe
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, 'dane_koalicje.m'));

n_partii  = length(partie_C);
n_okregow = length(okregi_1922_mandaty);

wyniki = zeros(1, n_partii);
for o = 1:n_okregow
    wyniki = wyniki + dhondt(okregi_C_dane(o, :), okregi_1922_mandaty(o));
end

total = sum(wyniki);

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 1 — PODSCENARIUSZ C\n');
fprintf('  Koalicja prawicy (PJN) vs lewicy (PZL) vs mniejszości (WMN)\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-14s %8s %10s %10s\n', 'Koalicja', 'Mandaty', 'Udział %', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 48));

[wyniki_sort, idx] = sort(wyniki, 'descend');
for i = 1:n_partii
    fprintf('%-14s %8d %9.2f%% %9.2f%%\n', ...
        partie_C{idx(i)}, wyniki_sort(i), ...
        wyniki_sort(i) / total * 100, partie_C_dane(idx(i)));
end
fprintf('%s\n', repmat('-', 1, 48));
fprintf('%-14s %8d %9.2f%%\n', 'ŁĄCZNIE', total, 100.0);

% ---- Wykres słupkowy ----
figure('Name', 'Scenariusz 1C — Trzy koalicje', ...
       'NumberTitle', 'off', 'Position', [50 50 800 560]);

[~, srt] = sort(wyniki, 'descend');
nazwy_s = partie_C(srt);
val_s   = wyniki(srt);
glosy_s = partie_C_dane(srt);

x = 1:length(nazwy_s);
b = bar(x, [val_s' glosy_s' / sum(glosy_s) * total]);
b(1).FaceColor = [0.20 0.45 0.75];
b(2).FaceColor = [0.85 0.55 0.20];
xticks(x);
xticklabels(nazwy_s);
ylabel('Liczba mandatów');
xlabel('Koalicja');
legend({'Mandaty (d''Hondt)', 'Proporcjonalny wzorzec'}, 'Location', 'northeast', 'FontSize', 10);
title({'Scenariusz 1C: Prawica (PJN) vs Lewica (PZL) vs Mniejszości (WMN)', ...
       'Wybory parlamentarne w Polsce 1922 — rozkład mandatów'}, 'FontSize', 12);
grid on;

% ---- Wykres kołowy ----
figure('Name', 'Scenariusz 1C — Podział mandatów (kołowy)', ...
       'NumberTitle', 'off', 'Position', [100 100 800 580]);

colors_C = [0.85 0.20 0.20; 0.20 0.55 0.85; 0.20 0.70 0.30];
pie(val_s);
colormap(colors_C);
legend(nazwy_s, 'Location', 'eastoutside', 'FontSize', 11);
title({'Scenariusz 1C: Podział mandatów — trzy koalicje', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 12);

fprintf('\nPodscenariusz C zakończony.\n');
