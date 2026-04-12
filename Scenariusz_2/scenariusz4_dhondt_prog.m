% =========================================================
% SCENARIUSZ 4: Metoda D'Hondta z progiem wyborczym 5%
% W 1922 nie obowiązywał próg — pytanie: co by się stało?
% Partie poniżej 5% krajowego wyniku są wykluczone z podziału
% mandatów w każdym okręgu.
% =========================================================

clear; clc;
s2_dir = fileparts(mfilename('fullpath'));
addpath(s2_dir);
run(fullfile(s2_dir, 'dane_wybory1922.m'));

PROG = 5.0;  % próg wyborczy w %

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

% Ustal które partie przekraczają próg (wg wyników krajowych)
partie_pow_prog = partie_1922_dane >= PROG;

fprintf('\n--- Partie wykluczone przez próg %.0f%% ---\n', PROG);
for i = 1:n_partii
    if ~partie_pow_prog(i)
        fprintf('  %-12s  %.2f%%\n', partie_1922{i}, partie_1922_dane(i));
    end
end
fprintf('\n');

wyniki_prog   = zeros(1, n_partii);
wyniki_bez    = zeros(1, n_partii);  % D'Hondt bez progu (dla porównania)

for o = 1:n_okregow
    glosy_okreg = okregi_1922_dane(o, :);
    
    % Bez progu
    wyniki_bez = wyniki_bez + dhondt(glosy_okreg, okregi_1922_mandaty(o));
    
    % Z progiem — zerujemy głosy wykluczonych partii w okręgu
    glosy_z_prog = glosy_okreg;
    glosy_z_prog(~partie_pow_prog) = 0;
    wyniki_prog = wyniki_prog + dhondt(glosy_z_prog, okregi_1922_mandaty(o));
end

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 4: D''Hondt z progiem wyborczym %.0f%%\n', PROG);
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %12s %12s %10s\n', 'Partia', 'Z progiem', 'Bez progu', 'Różnica');
fprintf('%s\n', repmat('-', 1, 50));

[~, idx] = sort(wyniki_prog, 'descend');
for i = 1:n_partii
    if wyniki_prog(idx(i)) > 0 || wyniki_bez(idx(i)) > 0
        diff = wyniki_prog(idx(i)) - wyniki_bez(idx(i));
        diff_str = '';
        if diff > 0,      diff_str = sprintf('+%d', diff);
        elseif diff < 0,  diff_str = sprintf('%d', diff);
        end
        marker = '';
        if ~partie_pow_prog(idx(i)), marker = ' *'; end
        fprintf('%-12s %12d %12d %10s%s\n', ...
            partie_1922{idx(i)}, wyniki_prog(idx(i)), wyniki_bez(idx(i)), diff_str, marker);
    end
end

fprintf('%s\n', repmat('-', 1, 50));
fprintf('%-12s %12d %12d\n', 'ŁĄCZNIE', sum(wyniki_prog), sum(wyniki_bez));
fprintf('\n* = partia wykluczona przez próg\n');

% ---- Wykres porównawczy ----
figure('Name', sprintf('D''Hondt z progiem %g%% vs bez progu', PROG), ...
       'NumberTitle', 'off', 'Position', [100 100 1000 550]);

partie_aktywne = (wyniki_prog > 0) | (wyniki_bez > 0);
nazwy = partie_1922(partie_aktywne);
val_p = wyniki_prog(partie_aktywne);
val_b = wyniki_bez(partie_aktywne);

[val_p_sort, srt] = sort(val_p + val_b, 'descend');
val_p_s = val_p(srt);
val_b_s = val_b(srt);
nazwy_s = nazwy(srt);

x = 1:length(nazwy_s);
bar(x, [val_b_s' val_p_s']);
xticks(x);
xticklabels(nazwy_s);
xtickangle(45);
legend({'Bez progu (hist.)', sprintf('Z progiem %.0f%%', PROG)}, 'FontSize', 10);
ylabel('Liczba mandatów');
title({sprintf('D''Hondt: efekt progu wyborczego %.0f%%', PROG), ...
       'Wybory parlamentarne 1922'}, 'FontSize', 12);
grid on;

fprintf('\nScenariusz 4 zakończony.\n');
