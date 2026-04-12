% =========================================================
% PORÓWNANIE WSZYSTKICH SCENARIUSZY
% Wybory parlamentarne w Polsce 1922
%
% Uruchamia wszystkie metody i zestawia wyniki w jednej tabeli
% oraz na jednym wykresie zbiorczym.
% =========================================================

clear; clc;
s2_dir = fileparts(mfilename('fullpath'));
addpath(s2_dir);
run(fullfile(s2_dir, 'dane_wybory1922.m'));

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

% Macierz wyników: wiersze = partie, kolumny = scenariusze
W = zeros(n_partii, 6);
%  1: D'Hondt (hist.)
%  2: Czysta Sainte-Laguë
%  3: Zmod. Sainte-Laguë (d.=1.4)
%  4: Adams
%  5: D'Hondt + próg 5%
%  6: Hamilton

PROG = 5.0;
partie_pow_prog = partie_1922_dane >= PROG;

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);

    W(:,1) = W(:,1) + dhondt(g, m)';
    W(:,2) = W(:,2) + sainte_lague(g, m, false)';
    W(:,3) = W(:,3) + sainte_lague(g, m, true)';
    W(:,4) = W(:,4) + adams(g, m)';
    g_prog = g; g_prog(~partie_pow_prog) = 0;
    W(:,5) = W(:,5) + dhondt(g_prog, m)';
    W(:,6) = W(:,6) + hamilton(g, m)';
end

nazwy_scenariuszy = {"D'Hondt (hist.)", "Sainte-Lague", "Zmod. S-L", ...
                     "Adams", "D'Hondt+5%", "Hamilton"};

% ---- Tabela zbiorcza ----
fprintf('\n');
fprintf('=============================================================================\n');
fprintf('  ZESTAWIENIE WSZYSTKICH SCENARIUSZY — Wybory 1922\n');
fprintf('=============================================================================\n');
fmt_header = '%-12s %12s %12s %12s %12s %12s %12s\n';
fmt_row    = '%-12s %12d %12d %12d %12d %12d %12d\n';

fprintf(fmt_header, 'Partia', nazwy_scenariuszy{:});
fprintf('%s\n', repmat('-', 1, 90));

[~, idx] = sort(W(:,1), 'descend');
for i = 1:n_partii
    p = idx(i);
    if any(W(p,:) > 0)
        fprintf(fmt_row, partie_1922{p}, W(p,1), W(p,2), W(p,3), W(p,4), W(p,5), W(p,6));
    end
end

fprintf('%s\n', repmat('-', 1, 90));
fprintf(fmt_row, 'ŁĄCZNIE', sum(W(:,1)), sum(W(:,2)), sum(W(:,3)), sum(W(:,4)), sum(W(:,5)), sum(W(:,6)));

% ---- Wykres zbiorczy ----
figure('Name', 'Porównanie wszystkich scenariuszy 1922', ...
       'NumberTitle', 'off', 'Position', [50 50 1300 650]);

partie_aktywne = any(W > 0, 2);
nazwy_plot = partie_1922(partie_aktywne);
W_plot = W(partie_aktywne, :);

[~, srt] = sort(W_plot(:,1), 'descend');
W_plot = W_plot(srt, :);
nazwy_plot = nazwy_plot(srt);

x = 1:size(W_plot,1);
bar(x, W_plot);
xticks(x);
xticklabels(nazwy_plot);
xtickangle(45);
legend(nazwy_scenariuszy, 'Location', 'northeast', 'FontSize', 9);
ylabel('Liczba mandatów');
xlabel('Partia');
title({'Porównanie metod przydziału mandatów', 'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 13);
grid on;

% ---- Indeks proporcjonalności Gallaghera ----
fprintf('\n--- Indeks proporcjonalności Gallaghera (mniejszy = bardziej proporcjonalny) ---\n');
fprintf('%-20s  %s\n', 'Metoda', 'Indeks Gallaghera');
fprintf('%s\n', repmat('-', 1, 42));

total_m = sum(W(:,1));  % łączna liczba mandatów (taka sama dla wszystkich)
glosy_kraj = partie_1922_dane / sum(partie_1922_dane) * 100;

for s = 1:6
    mandaty_proc = W(:,s) / total_m * 100;
    diff2 = (glosy_kraj' - mandaty_proc).^2;
    G = sqrt(0.5 * sum(diff2));
    fprintf('  %-18s  %.4f\n', nazwy_scenariuszy{s}, G);
end

fprintf('\nPorównanie wszystkich scenariuszy zakończone.\n');
