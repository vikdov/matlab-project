% =========================================================
% SCENARIUSZ 3: Struktury okręgów wyborczych — Wybory 1922
%
%   Podscenariusz A — Dwa duże okręgi: Polska „A" i Polska „B"
%   Podscenariusz B — Jeden ogólnokrajowy okręg wyborczy
%
% Wyniki porównywane z historycznym podziałem (64 okręgi)
% z Scenariusza bazowego (wspolne/dane_1922.m).
%
% Uruchomienie: run('Scenariusz_3/uruchom.m') lub otwórz plik
% i naciśnij Run w MATLAB.
% =========================================================

clear; clc;

s3_dir      = fileparts(mfilename('fullpath'));
wspolne_dir = fullfile(s3_dir, '..', 'wspolne');
addpath(wspolne_dir);

run(fullfile(s3_dir, 'dane_okregi.m'));
run(fullfile(wspolne_dir, 'dane_1922.m'));

n_partii = length(partie_1922);

% ---- Obliczenia: wynik historyczny (64 okręgi, D'Hondt) ----
wyniki_hist = zeros(1, n_partii);
for o = 1:length(okregi_1922_mandaty)
    wyniki_hist = wyniki_hist + dhondt(okregi_1922_dane(o,:), okregi_1922_mandaty(o));
end

% ---- Obliczenia: Podscenariusz A (2 okręgi) ----
wyniki_A = zeros(1, n_partii);
for o = 1:2
    wyniki_A = wyniki_A + dhondt(okregi_1922_dane_AB(o,:), okregi_1922_mandaty_AB(o));
end

% ---- Obliczenia: Podscenariusz B (1 okręg krajowy) ----
wyniki_B = dhondt(okregi_1922_dane_Polska, okregi_1922_mandaty_Polska(1));

total_mandatow = sum(wyniki_hist);
wiekszosc      = ceil(total_mandatow / 2);

% ---- Wyświetlenie wyników ----

fprintf('\n');
fprintf('=================================================================\n');
fprintf('  SCENARIUSZ 3: Struktury okręgów wyborczych — Wybory 1922\n');
fprintf('=================================================================\n');
fprintf('  Łączna liczba mandatów: %d   |   Próg większości: %d\n', ...
        total_mandatow, wiekszosc);
fprintf('\n');

fprintf('%-12s %12s %12s %12s\n', 'Partia', 'Hist.(64 okr)', '2 okręgi', '1 okręg');
fprintf('%s\n', repmat('-', 1, 54));

[~, idx] = sort(wyniki_hist, 'descend');
for i = 1:n_partii
    p = idx(i);
    if any([wyniki_hist(p), wyniki_A(p), wyniki_B(p)] > 0)
        dA = wyniki_A(p) - wyniki_hist(p);
        dB = wyniki_B(p) - wyniki_hist(p);
        dA_str = '';
        dB_str = '';
        if dA > 0, dA_str = sprintf('(+%d)', dA);
        elseif dA < 0, dA_str = sprintf('(%d)', dA); end
        if dB > 0, dB_str = sprintf('(+%d)', dB);
        elseif dB < 0, dB_str = sprintf('(%d)', dB); end
        fprintf('%-12s %12d %8d %-6s %8d %-6s\n', partie_1922{p}, ...
            wyniki_hist(p), wyniki_A(p), dA_str, wyniki_B(p), dB_str);
    end
end

fprintf('%s\n', repmat('-', 1, 54));
fprintf('%-12s %12d %12d %12d\n', 'ŁĄCZNIE', ...
        sum(wyniki_hist), sum(wyniki_A), sum(wyniki_B));
fprintf('\n(+/-) = różnica względem historycznego podziału na 64 okręgi\n\n');

% =========================================================
% WYKRESY
% =========================================================

partie_aktywne = any([wyniki_hist; wyniki_A; wyniki_B] > 0, 1);
nazwy  = partie_1922(partie_aktywne);
wH = wyniki_hist(partie_aktywne);
wA = wyniki_A(partie_aktywne);
wB = wyniki_B(partie_aktywne);

[~, srt] = sort(wH, 'descend');
nazwy = nazwy(srt);
wH = wH(srt);  wA = wA(srt);  wB = wB(srt);

x = 1:length(nazwy);

figure('Name', 'Sc. 3 – Porównanie struktur okręgów', ...
       'NumberTitle', 'off', 'Position', [50 100 1200 580]);

bar(x, [wH', wA', wB']);
xticks(x);
xticklabels(nazwy);
xtickangle(45);
legend({'Historyczny (64 okręgi)', 'Podsc. A (2 okręgi)', 'Podsc. B (1 okrąg)'}, ...
       'Location', 'northeast', 'FontSize', 9);
ylabel('Liczba mandatów');
xlabel('Partia');
title({'Scenariusz 3: Wpływ struktury okręgów na podział mandatów', ...
       'Wybory parlamentarne 1922 — Metoda D''Hondta'}, 'FontSize', 12);
grid on;
hold on;
plot([0.5, length(nazwy) + 0.5], [wiekszosc wiekszosc], 'r--', 'LineWidth', 1.5);
hold off;

% ---- Wykres kołowy: Podscenariusz B (1 okrąg) ----
figure('Name', 'Sc. 3B – Jeden okrąg krajowy', ...
       'NumberTitle', 'off', 'Position', [100 100 900 560]);

mask_B = wyniki_B > 0;
pie(wyniki_B(mask_B));
colormap(lines(sum(mask_B)));
legend(partie_1922(mask_B), 'Location', 'eastoutside', 'FontSize', 9);
title({'Podscenariusz B: Jeden okrąg ogólnokrajowy', ...
       'Wybory parlamentarne 1922 — Metoda D''Hondta'}, 'FontSize', 12);

fprintf('Scenariusz 3 zakończony.\n');
