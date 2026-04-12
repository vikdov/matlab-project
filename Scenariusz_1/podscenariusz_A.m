% =========================================================
% SCENARIUSZ 1 — PODSCENARIUSZ A
% Koalicja lewicy (PZL) vs reszta partii
%
% PZL = PSL-P + PSL-W + PSL-L + PPS + NPR (zjednoczona lewica)
% Pozostałe partie startują osobno
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, 'dane_koalicje.m'));

n_partii  = length(partie_A);
n_okregow = length(okregi_1922_mandaty);

wyniki = zeros(1, n_partii);
for o = 1:n_okregow
    wyniki = wyniki + dhondt(okregi_A_dane(o, :), okregi_1922_mandaty(o));
end

total = sum(wyniki);

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 1 — PODSCENARIUSZ A\n');
fprintf('  Koalicja lewicy (PZL) vs reszta partii\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-14s %8s %10s %10s\n', 'Koalicja/Partia', 'Mandaty', 'Udział %', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 48));

[wyniki_sort, idx] = sort(wyniki, 'descend');
for i = 1:n_partii
    if wyniki_sort(i) > 0
        fprintf('%-14s %8d %9.2f%% %9.2f%%\n', ...
            partie_A{idx(i)}, wyniki_sort(i), ...
            wyniki_sort(i) / total * 100, partie_A_dane(idx(i)));
    end
end
fprintf('%s\n', repmat('-', 1, 48));
fprintf('%-14s %8d %9.2f%%\n', 'ŁĄCZNIE', total, 100.0);

% ---- Wykres słupkowy ----
figure('Name', 'Scenariusz 1A — Koalicja lewicy vs reszta', ...
       'NumberTitle', 'off', 'Position', [50 50 900 580]);

partie_z_wynikami = wyniki > 0;
nazwy_plot = partie_A(partie_z_wynikami);
val_plot   = wyniki(partie_z_wynikami);
glosy_plot = partie_A_dane(partie_z_wynikami);

[~, srt] = sort(val_plot, 'descend');
nazwy_s  = nazwy_plot(srt);
val_s    = val_plot(srt);
glosy_s  = glosy_plot(srt);

x = 1:length(nazwy_s);
b = bar(x, [val_s' glosy_s' / sum(glosy_s) * total]);
b(1).FaceColor = [0.20 0.45 0.75];
b(2).FaceColor = [0.85 0.55 0.20];
xticks(x);
xticklabels(nazwy_s);
xtickangle(30);
legend({'Mandaty (d''Hondt)', 'Proporcjonalny wzorzec'}, 'Location', 'northeast', 'FontSize', 10);
ylabel('Liczba mandatów');
xlabel('Koalicja / Partia');
title({'Scenariusz 1A: Koalicja lewicy (PZL) vs reszta', ...
       'Wybory parlamentarne w Polsce 1922 — rozkład mandatów'}, 'FontSize', 12);
grid on;

% ---- Wykres kołowy ----
figure('Name', 'Scenariusz 1A — Podział mandatów (kołowy)', ...
       'NumberTitle', 'off', 'Position', [100 100 900 600]);

pie(val_s);
legend(nazwy_s, 'Location', 'eastoutside', 'FontSize', 10);
title({'Scenariusz 1A: Podział mandatów w parlamencie', ...
       'Koalicja lewicy (PZL) vs reszta partii', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 12);

fprintf('\nPodscenariusz A zakończony.\n');
