% =========================================================
% SCENARIUSZ 5: Metoda Hamiltona (największych reszt / Hare'a)
% Kwota Hare'a = suma_głosów_w_okręgu / liczba_mandatów_w_okręgu
% Najpierw mandaty z pełnych kwot, potem wg największych reszt
% =========================================================

clear; clc;
run('dane_wybory1922.m');

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

wyniki_hamilton = zeros(1, n_partii);
wyniki_dhondt   = zeros(1, n_partii);

for o = 1:n_okregow
    glosy_okreg = okregi_1922_dane(o, :);
    wyniki_hamilton = wyniki_hamilton + hamilton(glosy_okreg, okregi_1922_mandaty(o));
    wyniki_dhondt   = wyniki_dhondt   + dhondt(glosy_okreg,  okregi_1922_mandaty(o));
end

% ---- Wyświetlenie wyników ----
fprintf('\n========================================================\n');
fprintf('  SCENARIUSZ 5: Metoda Hamiltona (najwiekszych reszt)\n');
fprintf('  Wybory parlamentarne w Polsce 1922\n');
fprintf('========================================================\n');
fprintf('%-12s %12s %12s %10s\n', 'Partia', 'Hamilton', 'D''Hondt', 'Różnica');
fprintf('%s\n', repmat('-', 1, 50));

[~, idx] = sort(wyniki_hamilton, 'descend');
for i = 1:n_partii
    if wyniki_hamilton(idx(i)) > 0 || wyniki_dhondt(idx(i)) > 0
        diff = wyniki_hamilton(idx(i)) - wyniki_dhondt(idx(i));
        diff_str = '';
        if diff > 0,      diff_str = sprintf('+%d', diff);
        elseif diff < 0,  diff_str = sprintf('%d', diff);
        end
        fprintf('%-12s %12d %12d %10s\n', ...
            partie_1922{idx(i)}, wyniki_hamilton(idx(i)), wyniki_dhondt(idx(i)), diff_str);
    end
end

fprintf('%s\n', repmat('-', 1, 50));
fprintf('%-12s %12d %12d\n', 'ŁĄCZNIE', sum(wyniki_hamilton), sum(wyniki_dhondt));

% ---- Wykres ----
figure('Name', 'Hamilton vs D''Hondt 1922', 'NumberTitle', 'off', 'Position', [100 100 1000 550]);

partie_aktywne = (wyniki_hamilton > 0) | (wyniki_dhondt > 0);
nazwy = partie_1922(partie_aktywne);
val_h = wyniki_hamilton(partie_aktywne);
val_d = wyniki_dhondt(partie_aktywne);

[~, srt] = sort(val_h + val_d, 'descend');
val_h_s = val_h(srt);
val_d_s = val_d(srt);
nazwy_s = nazwy(srt);

x = 1:length(nazwy_s);
bar(x, [val_h_s' val_d_s']);
xticks(x);
xticklabels(nazwy_s);
xtickangle(45);
legend({'Hamilton (największe reszty)', 'D''Hondt (historyczny)'}, 'FontSize', 10);
ylabel('Liczba mandatów');
title({'Porównanie: Hamilton vs D''Hondt', 'Wybory parlamentarne 1922'}, 'FontSize', 12);
grid on;

fprintf('\nScenariusz 5 zakończony.\n');
