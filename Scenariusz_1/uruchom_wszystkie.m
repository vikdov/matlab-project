% =========================================================
% SCENARIUSZ 1 — PORÓWNANIE WSZYSTKICH PODSCENARIUSZY
% Koalicje przedwyborcze — Wybory parlamentarne 1922
%
% Uruchamia podscenariusze A, B, C i zestawia mandaty
% trzech głównych bloków na wspólnym wykresie porównawczym.
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, 'dane_koalicje.m'));

n_okregow = length(okregi_1922_mandaty);

% ---- Obliczenia dla każdego podscenariusza ----
wyniki_A = zeros(1, length(partie_A));
wyniki_B = zeros(1, length(partie_B));
wyniki_C = zeros(1, length(partie_C));

for o = 1:n_okregow
    wyniki_A = wyniki_A + dhondt(okregi_A_dane(o, :), okregi_1922_mandaty(o));
    wyniki_B = wyniki_B + dhondt(okregi_B_dane(o, :), okregi_1922_mandaty(o));
    wyniki_C = wyniki_C + dhondt(okregi_C_dane(o, :), okregi_1922_mandaty(o));
end

total = sum(wyniki_A);

% ---- Tabela zbiorcza ----
fprintf('\n');
fprintf('=======================================================================\n');
fprintf('  SCENARIUSZ 1: PORÓWNANIE PODSCENARIUSZY KOALICYJNYCH\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('=======================================================================\n');

fprintf('\n--- Podscenariusz A: Koalicja lewicy (PZL) vs reszta ---\n');
fprintf('%-14s %8s %10s\n', 'Koalicja/Partia', 'Mandaty', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 36));
[ws, id] = sort(wyniki_A, 'descend');
for i = 1:length(partie_A)
    if ws(i) > 0
        fprintf('%-14s %8d %9.2f%%\n', partie_A{id(i)}, ws(i), partie_A_dane(id(i)));
    end
end

fprintf('\n--- Podscenariusz B: PZL vs Mniejszości (WMN) vs reszta ---\n');
fprintf('%-14s %8s %10s\n', 'Koalicja/Partia', 'Mandaty', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 36));
[ws, id] = sort(wyniki_B, 'descend');
for i = 1:length(partie_B)
    if ws(i) > 0
        fprintf('%-14s %8d %9.2f%%\n', partie_B{id(i)}, ws(i), partie_B_dane(id(i)));
    end
end

fprintf('\n--- Podscenariusz C: Prawica (PJN) vs Lewica (PZL) vs Mniejszości (WMN) ---\n');
fprintf('%-14s %8s %10s\n', 'Koalicja', 'Mandaty', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 36));
[ws, id] = sort(wyniki_C, 'descend');
for i = 1:length(partie_C)
    fprintf('%-14s %8d %9.2f%%\n', partie_C{id(i)}, ws(i), partie_C_dane(id(i)));
end

fprintf('\nŁącznie mandatów: %d\n', total);

% ---- Wykres porównawczy: udział % lewicy, prawicy i mniejszości ----
% Mandaty lewicowych ugrupowań (PZL) w każdym scenariuszu
pzl_A = wyniki_A(strcmp(partie_A, 'PZL'));
pzl_B = wyniki_B(strcmp(partie_B, 'PZL'));
pzl_C = wyniki_C(strcmp(partie_C, 'PZL'));

wmn_A = 0;  % WMN nie istnieje jako blok w A
wmn_B = wyniki_B(strcmp(partie_B, 'WMN'));
wmn_C = wyniki_C(strcmp(partie_C, 'WMN'));

pjn_A = 0;  % PJN nie istnieje jako blok w A
pjn_B = 0;
pjn_C = wyniki_C(strcmp(partie_C, 'PJN'));

% Prawica/centrum w podscenariuszach A i B (ChZJN + PC)
chzjn_A = wyniki_A(strcmp(partie_A, 'ChZJN'));
chzjn_B = wyniki_B(strcmp(partie_B, 'ChZJN'));

figure('Name', 'Scenariusz 1 — Porównanie podscenariuszy', ...
       'NumberTitle', 'off', 'Position', [50 50 1100 620]);

dane_plot = [
    pzl_A,   wmn_A,   chzjn_A, total - pzl_A - wmn_A - chzjn_A;
    pzl_B,   wmn_B,   chzjn_B, total - pzl_B - wmn_B - chzjn_B;
    pzl_C,   wmn_C,   pjn_C,   total - pzl_C - wmn_C - pjn_C;
];

b = bar(dane_plot, 'stacked');
bar_colors = [0.20 0.45 0.75;   % lewica — niebieski
              0.20 0.70 0.30;   % mniejszości — zielony
              0.85 0.20 0.20;   % prawica/centrum — czerwony
              0.80 0.80 0.80];  % pozostałe — szary
for i = 1:min(numel(b), size(bar_colors, 1))
    set(b(i), 'FaceColor', bar_colors(i, :));
end

xticklabels({'Podscenariusz A', 'Podscenariusz B', 'Podscenariusz C'});
legend({'Lewica (PZL)', 'Mniejszości (WMN)', 'Prawica/centrum', 'Pozostałe'}, ...
       'Location', 'northeast', 'FontSize', 10);
ylabel('Liczba mandatów');
title({'Scenariusz 1: Porównanie układów koalicyjnych', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 13);
grid on;
ylim([0 total * 1.05]);

fprintf('\nPorównanie wszystkich podscenariuszy zakończone.\n');
