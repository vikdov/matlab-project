% =========================================================
% PORÓWNANIE WSZYSTKICH SCENARIUSZY KOALICYJNYCH A, B, C
% Wybory parlamentarne w Polsce 1922
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

IDX_PRAWICA     = [1, 7, 10];
IDX_LEWICA      = [3, 4, 5, 6, 13];
IDX_MNIEJSZOSCI = [2, 8, 9, 11, 12, 14];
IDX_RESZTA_A    = [1, 2, 7, 8, 9, 10, 11, 12, 14];

n_okregow = length(okregi_1922_mandaty);

% Zbieramy mandaty dla każdego scenariusza
mA = [0,0];        % [lewica, reszta]
mB = [0,0,0];      % [lewica, mniejszosci, reszta(prawe)]
mC = [0,0,0];      % [prawica, lewica, mniejszosci]

for o = 1:n_okregow
    g = okregi_1922_dane(o, :);
    m = okregi_1922_mandaty(o);

    wA = dhondt([sum(g(IDX_LEWICA)), sum(g(IDX_RESZTA_A))], m);
    mA = mA + wA;

    wB = dhondt([sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI)), sum(g(IDX_PRAWICA))], m);
    mB = mB + wB;

    wC = dhondt([sum(g(IDX_PRAWICA)), sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI))], m);
    mC = mC + wC;
end

total_A = sum(mA);
total_B = sum(mB);
total_C = sum(mC);

% ---- Tabela zbiorcza ----
fprintf('\n=============================================================\n');
fprintf('  PORÓWNANIE SCENARIUSZY KOALICYJNYCH — Wybory 1922\n');
fprintf('=============================================================\n\n');

fprintf('  SCENARIUSZ A: Lewica vs Reszta\n');
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'LEWICA',  mA(1), mA(1)/total_A*100);
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'RESZTA',  mA(2), mA(2)/total_A*100);
fprintf('  Większość: %d | Próg: %d\n\n', floor(total_A/2)+1, floor(total_A/2)+1);

fprintf('  SCENARIUSZ B: Lewica vs Mniejszości vs Reszta (prawicowa)\n');
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'LEWICA',       mB(1), mB(1)/total_B*100);
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'MNIEJSZOŚCI',  mB(2), mB(2)/total_B*100);
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'PRAWICA',      mB(3), mB(3)/total_B*100);
fprintf('  Potencjalna koalicja Lewica+Mniejszości: %d mandatów', mB(1)+mB(2));
if mB(1)+mB(2) >= floor(total_B/2)+1, fprintf(' ✓ WIĘKSZOŚĆ'); end
fprintf('\n\n');

fprintf('  SCENARIUSZ C: Prawica vs Lewica vs Mniejszości\n');
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'PRAWICA',      mC(1), mC(1)/total_C*100);
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'LEWICA',       mC(2), mC(2)/total_C*100);
fprintf('  %-14s  %d mandatów (%.1f%%)\n', 'MNIEJSZOŚCI',  mC(3), mC(3)/total_C*100);
fprintf('  Potencjalna koalicja Prawica+Mniejszości: %d mandatów', mC(1)+mC(3));
if mC(1)+mC(3) >= floor(total_C/2)+1, fprintf(' ✓ WIĘKSZOŚĆ'); end
fprintf('\n');
fprintf('  Potencjalna koalicja Lewica+Mniejszości:  %d mandatów', mC(2)+mC(3));
if mC(2)+mC(3) >= floor(total_C/2)+1, fprintf(' ✓ WIĘKSZOŚĆ'); end
fprintf('\n\n');

% ---- Wykres zbiorczy ----
figure('Name', 'Porównanie scenariuszy koalicyjnych A B C', ...
       'NumberTitle', 'off', 'Position', [50 50 1300 500]);

kolory_blokow = struct();
kolory_blokow.lewica     = [0.85 0.15 0.15];
kolory_blokow.prawica    = [0.15 0.25 0.75];
kolory_blokow.mniejszosci= [0.20 0.65 0.30];
kolory_blokow.reszta     = [0.55 0.55 0.55];

% Scenariusz A
subplot(1,3,1);
pie_h = pie([mA(1), mA(2)]);
pie_h(1).FaceColor = kolory_blokow.lewica;
pie_h(3).FaceColor = kolory_blokow.reszta;
legend({'Lewica', 'Reszta'}, 'Location', 'southoutside', 'FontSize', 9);
title({'Scenariusz A', sprintf('Lewica: %d | Reszta: %d', mA(1), mA(2))}, 'FontSize', 11);

% Scenariusz B
subplot(1,3,2);
pie_h = pie([mB(1), mB(2), mB(3)]);
pie_h(1).FaceColor = kolory_blokow.lewica;
pie_h(3).FaceColor = kolory_blokow.mniejszosci;
pie_h(5).FaceColor = kolory_blokow.prawica;
legend({'Lewica', 'Mniejszości', 'Prawica'}, 'Location', 'southoutside', 'FontSize', 9);
title({'Scenariusz B', sprintf('L:%d | M:%d | P:%d', mB(1), mB(2), mB(3))}, 'FontSize', 11);

% Scenariusz C
subplot(1,3,3);
pie_h = pie([mC(1), mC(2), mC(3)]);
pie_h(1).FaceColor = kolory_blokow.prawica;
pie_h(3).FaceColor = kolory_blokow.lewica;
pie_h(5).FaceColor = kolory_blokow.mniejszosci;
legend({'Prawica', 'Lewica', 'Mniejszości'}, 'Location', 'southoutside', 'FontSize', 9);
title({'Scenariusz C', sprintf('P:%d | L:%d | M:%d', mC(1), mC(2), mC(3))}, 'FontSize', 11);

sgtitle({'Porównanie scenariuszy koalicyjnych A, B, C', ...
         'Wybory parlamentarne w Polsce 1922'}, 'FontSize', 13);

fprintf('Porównanie zakończone.\n');
