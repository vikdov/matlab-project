% =========================================================
% SCENARIUSZ 3 — PORÓWNANIE WSZYSTKICH KONFIGURACJI OKRĘGÓW
% Plik: Scenariusz_3/uruchom_wszystkie.m
%
% Zestawia trzy konfiguracje okręgów:
%   HIST  — historyczna: 64 okręgi, D'Hondt
%   3A    — dwa makrookręgi (Polska A + B), D'Hondt
%   3B    — jeden okrąg ogólnokrajowy (444 mandaty), D'Hondt
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');
run('dane_okregi.m');

MANDATY_KRAJ = 444;
n_partii     = length(partie_1922);

% ---- 1. Wynik historyczny (64 okręgi) ----
W_hist = zeros(1, n_partii);
for o = 1:length(okregi_1922_mandaty)
    W_hist = W_hist + dhondt(okregi_1922_dane(o,:), okregi_1922_mandaty(o));
end

% ---- 2. Dwa makrookręgi (Scenariusz 3A) ----
function glosy_makro = agreguj(dane, mandaty, idx)
    n = size(dane, 2);
    glosy_makro = zeros(1, n);
    wagi = 0;
    for o = idx
        glosy_makro = glosy_makro + dane(o,:) * mandaty(o);
        wagi = wagi + mandaty(o);
    end
    glosy_makro = glosy_makro / wagi;
end

glosy_A  = agreguj(okregi_1922_dane, okregi_1922_mandaty, IDX_POLSKA_A);
glosy_B  = agreguj(okregi_1922_dane, okregi_1922_mandaty, IDX_POLSKA_B);
mand_A   = sum(okregi_1922_mandaty(IDX_POLSKA_A));
mand_B   = sum(okregi_1922_mandaty(IDX_POLSKA_B));
W_3A     = dhondt(glosy_A, mand_A) + dhondt(glosy_B, mand_B);

% ---- 3. Jeden okrąg ogólnokrajowy (Scenariusz 3B) ----
W_3B = dhondt(partie_1922_dane, MANDATY_KRAJ);

% ---- Tabela porównawcza ----
fprintf('\n=================================================================\n');
fprintf('  SCENARIUSZ 3: PORÓWNANIE KONFIGURACJI OKRĘGÓW — Wybory 1922\n');
fprintf('=================================================================\n');
fprintf('%-12s %14s %14s %14s\n', 'Partia', 'HIST (64 okr.)', '3A (2 makro)', '3B (1 kraj.)');
fprintf('%s\n', repmat('-', 1, 58));

[~, idx] = sort(W_hist, 'descend');
for i = 1:n_partii
    p = idx(i);
    if any([W_hist(p), W_3A(p), W_3B(p)] > 0)
        dA = W_3A(p) - W_hist(p);
        dB = W_3B(p) - W_hist(p);
        dA_s = ''; dB_s = '';
        if dA~=0, dA_s = sprintf('(%+d)', dA); end
        if dB~=0, dB_s = sprintf('(%+d)', dB); end
        fprintf('%-12s %8d       %8d %-5s %8d %-5s\n', ...
            partie_1922{p}, W_hist(p), W_3A(p), dA_s, W_3B(p), dB_s);
    end
end

fprintf('%s\n', repmat('-', 1, 58));
fprintf('%-12s %14d %14d %14d\n', 'ŁĄCZNIE', sum(W_hist), sum(W_3A), sum(W_3B));

% ---- Indeks Gallaghera ----
fprintf('\n--- Indeks Gallaghera (proporcjonalność vs głosy krajowe) ---\n');
glosy_n = partie_1922_dane / sum(partie_1922_dane) * 100;
warianty = {W_hist, W_3A, W_3B};
etykiety = {'Historyczny (64 okr.)', 'Dwa makrookręgi (3A)', 'Jeden okrąg (3B)'};
for k = 1:3
    tot = sum(warianty{k});
    G = sqrt(0.5 * sum((glosy_n - warianty{k}/tot*100).^2));
    fprintf('  %-22s  G = %.4f\n', etykiety{k}, G);
end

% ---- Wykres zbiorczy ----
figure('Name', 'Scenariusz 3: Porównanie konfiguracji okręgów', ...
       'NumberTitle', 'off', 'Position', [50 50 1300 700]);

partie_aktywne = (W_hist > 0) | (W_3A > 0) | (W_3B > 0);
naz   = partie_1922(partie_aktywne);
vH    = W_hist(partie_aktywne);
v3A   = W_3A(partie_aktywne);
v3B   = W_3B(partie_aktywne);
glosy_plot = partie_1922_dane(partie_aktywne) / sum(partie_1922_dane) * MANDATY_KRAJ;

[~, srt] = sort(vH, 'descend');
naz=naz(srt); vH=vH(srt); v3A=v3A(srt); v3B=v3B(srt); glosy_plot=glosy_plot(srt);
x = 1:length(naz);

subplot(2,1,1);
bar(x, [vH' v3A' v3B']);
hold on;
plot(x, glosy_plot, 'k--o', 'LineWidth', 1.5, 'MarkerSize', 5);
hold off;
xticks(x); xticklabels(naz); xtickangle(40);
legend({'Hist. 64 okr.', 'Dwa makrookr. (3A)', sprintf('1 okrąg %d m. (3B)', MANDATY_KRAJ), ...
        'Prop. idealna'}, 'Location', 'northeast', 'FontSize', 9);
ylabel('Mandaty');
title('Porównanie wszystkich konfiguracji okręgów', 'FontSize', 11);
grid on;

subplot(2,1,2);
delta_A = v3A - vH;
delta_B = v3B - vH;
bar(x, [delta_A' delta_B']);
xticks(x); xticklabels(naz); xtickangle(40);
yline(0, 'k-', 'LineWidth', 1.2);
legend({'3A − Hist.', '3B − Hist.'}, 'Location', 'northeast');
ylabel('Zmiana mandatów');
title('Odchylenie od wyniku historycznego', 'FontSize', 11);
grid on;

sgtitle({'Scenariusz 3: Efekt konfiguracji okręgów wyborczych', ...
         'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 13);

fprintf('\nPorównanie zakończone.\n');
