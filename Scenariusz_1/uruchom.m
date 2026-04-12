% =========================================================
% SCENARIUSZ 1: Koalicje przedwyborcze — Wybory 1922
%
%   Podscenariusz A — Koalicja lewicy (PZL) vs reszta partii
%   Podscenariusz B — Koalicja lewicy (PZL) vs koalicja mniejszości
%                     narodowych (WMN) vs reszta partii
%   Podscenariusz C — Koalicja prawicy (PJN) vs koalicja lewicy (PZL)
%                     vs koalicja mniejszości narodowych (WMN)
%
% Uruchomienie: run('Scenariusz_1/uruchom.m') lub otwórz plik
% i naciśnij Run w MATLAB.
% =========================================================

clear; clc;

s1_dir      = fileparts(mfilename('fullpath'));
wspolne_dir = fullfile(s1_dir, '..', 'wspolne');
addpath(wspolne_dir);

run(fullfile(s1_dir, 'dane_koalicje.m'));
run(fullfile(wspolne_dir, 'dane_1922.m'));

n_okregow     = length(okregi_1922_mandaty);
total_mandatow = sum(okregi_1922_mandaty);
wiekszosc      = ceil(total_mandatow / 2);

% ---- Obliczenia ----

n_A     = numel(partie_1922_A);
wyniki_A = zeros(1, n_A);

n_B     = numel(partie_1922_B);
wyniki_B = zeros(1, n_B);

n_C     = numel(partie_1922_C);
wyniki_C = zeros(1, n_C);

for o = 1:n_okregow
    wyniki_A = wyniki_A + dhondt(okregi_1922_dane_A(o,:), okregi_1922_mandaty(o));
    wyniki_B = wyniki_B + dhondt(okregi_1922_dane_B(o,:), okregi_1922_mandaty(o));
    wyniki_C = wyniki_C + dhondt(okregi_1922_dane_C(o,:), okregi_1922_mandaty(o));
end

% ---- Wyświetlenie wyników ----

fprintf('\n');
fprintf('=================================================================\n');
fprintf('  SCENARIUSZ 1: Koalicje przedwyborcze — Wybory 1922\n');
fprintf('=================================================================\n');
fprintf('  Łączna liczba mandatów: %d   |   Próg większości: %d\n', ...
        total_mandatow, wiekszosc);
fprintf('\n');

fprintf('--- Podscenariusz A: Koalicja lewicy vs reszta ---\n');
fprintf('%-14s %8s %10s %10s\n', 'Partia / Blok', 'Mandaty', 'Udz. %', 'Gł. %');
fprintf('%s\n', repmat('-', 1, 46));
[~, idx] = sort(wyniki_A, 'descend');
for i = 1:n_A
    if wyniki_A(idx(i)) > 0
        fprintf('%-14s %8d %9.2f%% %9.2f%%\n', partie_1922_A{idx(i)}, ...
            wyniki_A(idx(i)), wyniki_A(idx(i)) / total_mandatow * 100, ...
            partie_1922_dane_A(idx(i)));
    end
end
fprintf('%s\n', repmat('-', 1, 46));
fprintf('%-14s %8d\n\n', 'ŁĄCZNIE', total_mandatow);

fprintf('--- Podscenariusz B: Koalicja lewicy + mniejszości vs reszta ---\n');
fprintf('%-14s %8s %10s %10s\n', 'Partia / Blok', 'Mandaty', 'Udz. %', 'Gł. %');
fprintf('%s\n', repmat('-', 1, 46));
[~, idx] = sort(wyniki_B, 'descend');
for i = 1:n_B
    if wyniki_B(idx(i)) > 0
        fprintf('%-14s %8d %9.2f%% %9.2f%%\n', partie_1922_B{idx(i)}, ...
            wyniki_B(idx(i)), wyniki_B(idx(i)) / total_mandatow * 100, ...
            partie_1922_dane_B(idx(i)));
    end
end
fprintf('%s\n', repmat('-', 1, 46));
fprintf('%-14s %8d\n\n', 'ŁĄCZNIE', total_mandatow);

fprintf('--- Podscenariusz C: Koalicja prawicy vs lewicy vs mniejszości ---\n');
fprintf('%-14s %8s %10s %10s\n', 'Partia / Blok', 'Mandaty', 'Udz. %', 'Gł. %');
fprintf('%s\n', repmat('-', 1, 46));
[~, idx] = sort(wyniki_C, 'descend');
for i = 1:n_C
    if wyniki_C(idx(i)) > 0
        fprintf('%-14s %8d %9.2f%% %9.2f%%\n', partie_1922_C{idx(i)}, ...
            wyniki_C(idx(i)), wyniki_C(idx(i)) / total_mandatow * 100, ...
            partie_1922_dane_C(idx(i)));
    end
end
fprintf('%s\n', repmat('-', 1, 46));
fprintf('%-14s %8d\n\n', 'ŁĄCZNIE', total_mandatow);

% =========================================================
% WYKRESY
% =========================================================

% --- Podscenariusz A ---
figure('Name', 'Sc. 1A – Koalicja lewicy vs reszta', ...
       'NumberTitle', 'off', 'Position', [50 430 920 490]);

hb_A = bar(wyniki_A, 'FaceColor', 'flat');
xticks(1:n_A);
xticklabels(partie_1922_A);
xtickangle(25);
ylabel('Liczba mandatów');
xlabel('Partia / Blok');
title({'Podscenariusz A: Koalicja lewicy (PZL) vs reszta partii', ...
       'Wybory parlamentarne 1922 — Metoda D''Hondta'}, 'FontSize', 12);
grid on;
hold on;
hl_A = plot([0.5, n_A + 0.5], [wiekszosc wiekszosc], 'r--', 'LineWidth', 1.5);
for k = 1:n_A
    if wyniki_A(k) > 0
        text(k, wyniki_A(k) + 1.5, num2str(wyniki_A(k)), ...
             'HorizontalAlignment', 'center', 'FontSize', 8);
    end
end
legend([hb_A, hl_A], {'Mandaty', sprintf('Większość (%d)', wiekszosc)}, ...
       'Location', 'northeast');
hold off;

% --- Podscenariusz B ---
figure('Name', 'Sc. 1B – Koalicja lewicy + mniejszości vs reszta', ...
       'NumberTitle', 'off', 'Position', [100 380 800 490]);

hb_B = bar(wyniki_B, 'FaceColor', 'flat');
xticks(1:n_B);
xticklabels(partie_1922_B);
ylabel('Liczba mandatów');
xlabel('Partia / Blok');
title({'Podscenariusz B: Koalicja lewicy (PZL) + mniejszości (WMN) vs reszta', ...
       'Wybory parlamentarne 1922 — Metoda D''Hondta'}, 'FontSize', 12);
grid on;
hold on;
hl_B = plot([0.5, n_B + 0.5], [wiekszosc wiekszosc], 'r--', 'LineWidth', 1.5);
for k = 1:n_B
    if wyniki_B(k) > 0
        text(k, wyniki_B(k) + 1.5, num2str(wyniki_B(k)), ...
             'HorizontalAlignment', 'center', 'FontSize', 9);
    end
end
legend([hb_B, hl_B], {'Mandaty', sprintf('Większość (%d)', wiekszosc)}, ...
       'Location', 'northeast');
hold off;

% --- Podscenariusz C ---
figure('Name', 'Sc. 1C – Trzy koalicje', ...
       'NumberTitle', 'off', 'Position', [150 330 700 490]);

hb_C = bar(wyniki_C, 'FaceColor', 'flat');
xticks(1:n_C);
xticklabels(partie_1922_C);
ylabel('Liczba mandatów');
xlabel('Koalicja');
title({'Podscenariusz C: Koalicja prawicy (PJN) vs lewicy (PZL) vs mniejszości (WMN)', ...
       'Wybory parlamentarne 1922 — Metoda D''Hondta'}, 'FontSize', 12);
grid on;
hold on;
hl_C = plot([0.5, n_C + 0.5], [wiekszosc wiekszosc], 'r--', 'LineWidth', 1.5);
for k = 1:n_C
    if wyniki_C(k) > 0
        text(k, wyniki_C(k) + 1.5, num2str(wyniki_C(k)), ...
             'HorizontalAlignment', 'center', 'FontSize', 10);
    end
end
legend([hb_C, hl_C], {'Mandaty', sprintf('Większość (%d)', wiekszosc)}, ...
       'Location', 'northeast');
hold off;

fprintf('Scenariusz 1 zakończony.\n');
