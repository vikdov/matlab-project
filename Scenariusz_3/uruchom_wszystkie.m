% =========================================================
% SCENARIUSZ 3 — PORÓWNANIE WSZYSTKICH PODSCENARIUSZY
% Struktury okręgów wyborczych — Wybory parlamentarne 1922
%
% Porównuje trzy konfiguracje okręgów:
%   - 64 okręgi historyczne
%   - Dwa makrookręgi (Polska A + B)
%   - Jeden okrąg ogólnokrajowy
% =========================================================

clear; clc;
[sciezka, ~, ~] = fileparts(mfilename('fullpath'));
addpath(fullfile(sciezka, '..', 'wspolne'));

run(fullfile(sciezka, '..', 'wspolne', 'dane_1922.m'));
run(fullfile(sciezka, 'dane_okregi.m'));

n_partii = length(partie_1922);

% ---- Obliczenia ----
wyniki_hist = zeros(1, n_partii);
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o, :), okregi_1922_mandaty(o));
end

wyniki_AB = zeros(1, n_partii);
for o = 1:2
    wyniki_AB = wyniki_AB + dhondt(okregi_AB_dane(o, :), okregi_AB_mandaty(o));
end

wyniki_PL = dhondt(okrag_PL_dane, okrag_PL_mandaty(1));

total = sum(wyniki_hist);

% ---- Tabela zbiorcza ----
fprintf('\n');
fprintf('=========================================================================\n');
fprintf('  SCENARIUSZ 3: PORÓWNANIE KONFIGURACJI OKRĘGÓW\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('=========================================================================\n');
fprintf('%-12s %14s %14s %14s\n', 'Partia', '64 okręgi (hist.)', 'Polska A+B', '1 okrąg (PL)');
fprintf('%s\n', repmat('-', 1, 58));

[~, idx] = sort(wyniki_hist, 'descend');
for i = 1:n_partii
    if any([wyniki_hist(idx(i)) wyniki_AB(idx(i)) wyniki_PL(idx(i))] > 0)
        fprintf('%-12s %14d %14d %14d\n', ...
            partie_1922{idx(i)}, wyniki_hist(idx(i)), wyniki_AB(idx(i)), wyniki_PL(idx(i)));
    end
end
fprintf('%s\n', repmat('-', 1, 58));
fprintf('%-12s %14d %14d %14d\n', 'ŁĄCZNIE', ...
    sum(wyniki_hist), sum(wyniki_AB), sum(wyniki_PL));

% ---- Wykres zbiorczy ----
figure('Name', 'Scenariusz 3 — Porównanie konfiguracji okręgów', ...
       'NumberTitle', 'off', 'Position', [50 50 1200 620]);

partie_aktywne = any([wyniki_hist; wyniki_AB; wyniki_PL] > 0, 1);
nazwy  = partie_1922(partie_aktywne);
wh = wyniki_hist(partie_aktywne);
wAB = wyniki_AB(partie_aktywne);
wPL = wyniki_PL(partie_aktywne);

[~, srt] = sort(wh, 'descend');
bar(1:sum(partie_aktywne), [wh(srt)' wAB(srt)' wPL(srt)']);
xticks(1:sum(partie_aktywne));
xticklabels(nazwy(srt));
xtickangle(40);
legend({'64 okręgi (historyczne)', 'Polska A + B (2 okręgi)', '1 okrąg ogólnokrajowy'}, ...
       'Location', 'northeast', 'FontSize', 10);
ylabel('Liczba mandatów');
xlabel('Partia');
title({'Scenariusz 3: Wpływ struktury okręgów na podział mandatów', ...
       'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 13);
grid on;

fprintf('\nPorównanie wszystkich podscenariuszy zakończone.\n');
