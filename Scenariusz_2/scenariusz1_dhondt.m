% =========================================================
% SCENARIUSZ 1: Metoda D'Hondta
% Metoda historyczna użyta w wyborach 1922 roku
% Mandaty liczone okręgowo (bez progu wyborczego)
% =========================================================

clear; clc;
s2_dir = fileparts(mfilename('fullpath'));
addpath(s2_dir);
run(fullfile(s2_dir, 'dane_wybory1922.m'));

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

wyniki = zeros(1, n_partii);

for o = 1:n_okregow
    glosy_okreg = okregi_1922_dane(o, :);
    mandaty_okreg = dhondt(glosy_okreg, okregi_1922_mandaty(o));
    wyniki = wyniki + mandaty_okreg;
end

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 1: Metoda D''Hondta (historyczna)\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %8s %10s %10s\n', 'Partia', 'Mandaty', 'Udział %', 'Głosy %');
fprintf('%s\n', repmat('-', 1, 46));

[wyniki_sort, idx] = sort(wyniki, 'descend');
total_mandatow = sum(wyniki);

for i = 1:n_partii
    if wyniki_sort(i) > 0
        fprintf('%-12s %8d %9.2f%% %9.2f%%\n', ...
            partie_1922{idx(i)}, wyniki_sort(i), ...
            wyniki_sort(i)/total_mandatow*100, ...
            partie_1922_dane(idx(i)));
    end
end

fprintf('%s\n', repmat('-', 1, 46));
fprintf('%-12s %8d %9.2f%%\n', 'ŁĄCZNIE', total_mandatow, 100.0);

% ---- Wykres kołowy ----
figure('Name', 'D''Hondt 1922', 'NumberTitle', 'off', 'Position', [100 100 900 600]);

partie_z_wynikami = wyniki > 0;
labels_plot = partie_1922(partie_z_wynikami);
values_plot  = wyniki(partie_z_wynikami);

colors = lines(sum(partie_z_wynikami));
pie(values_plot);
colormap(colors);
legend(labels_plot, 'Location', 'eastoutside', 'FontSize', 9);
title({'Podział mandatów — Metoda D''Hondta', 'Wybory parlamentarne 1922'}, 'FontSize', 13);

fprintf('\nŁącznie mandatów: %d\n', total_mandatow);
fprintf('Scenariusz 1 zakończony.\n');
