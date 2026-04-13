% =========================================================
% SCENARIUSZ 1: POROWNANIE KOALICJI A, B, C
% Plik: Scenariusz_1/porownanie_koalicji_ABC.m
%
% Scenariusz A: LEWICA (blok) vs pozostale partie osobno
% Scenariusz B: LEWICA (blok) + MNIEJSZOSCI (blok) vs pozostale osobno
% Scenariusz C: PRAWICA (blok) + LEWICA (blok) + MNIEJSZOSCI (blok)
%
% UWAGA: "pozostale" startuja jako osobne partie (nie jako jeden blok),
% dlatego ich laczna suma mandatow rozni sie od scenariusza C gdzie
% te same partie ida jako jeden blok PRAWICA.
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

% partie_1922:
% 1=ChZJN 2=BMN 3=PSL-P 4=PSL-W 5=PPS 6=NPR 7=PC
% 8=KZSN-Z 9=KZPMiW 10=ChSR 11=Bund 12=ZN-Z 13=PSL-L 14=ZDBL 15=Inni

IDX_LEWICA      = [3, 4, 5, 6, 13];
IDX_MNIEJSZOSCI = [2, 8, 9, 11, 12, 14];
IDX_PRAWICA     = [1, 7, 10];
IDX_POZOSTALE_A = [1, 2, 7, 8, 9, 10, 11, 12, 14]; % prawica+mniejszosci osobno
IDX_POZOSTALE_B = [1, 7, 10];                        % tylko prawica osobno

n_okregow = length(okregi_1922_mandaty);

% ============================================================
% Obliczenia
% ============================================================

% --- SCENARIUSZ A ---
n_A = 1 + length(IDX_POZOSTALE_A);
wA  = zeros(1, n_A);
for o = 1:n_okregow
    g = okregi_1922_dane(o,:);
    m = okregi_1922_mandaty(o);
    wA = wA + dhondt([sum(g(IDX_LEWICA)), g(IDX_POZOSTALE_A)], m);
end
etyk_A  = [{'LEWICA'}, partie_1922(IDX_POZOSTALE_A)];
total_A = sum(wA);

% --- SCENARIUSZ B ---
n_B = 2 + length(IDX_POZOSTALE_B);
wB  = zeros(1, n_B);
for o = 1:n_okregow
    g = okregi_1922_dane(o,:);
    m = okregi_1922_mandaty(o);
    wB = wB + dhondt([sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI)), g(IDX_POZOSTALE_B)], m);
end
etyk_B  = [{'LEWICA'}, {'MNIEJSZOSCI'}, partie_1922(IDX_POZOSTALE_B)];
total_B = sum(wB);

% --- SCENARIUSZ C ---
wC = zeros(1,3);
for o = 1:n_okregow
    g = okregi_1922_dane(o,:);
    m = okregi_1922_mandaty(o);
    wC = wC + dhondt([sum(g(IDX_PRAWICA)), sum(g(IDX_LEWICA)), sum(g(IDX_MNIEJSZOSCI))], m);
end
etyk_C  = {'PRAWICA', 'LEWICA', 'MNIEJSZOSCI'};
total_C = sum(wC);

% ============================================================
% Konsola
% ============================================================
fprintf('\n=============================================================\n');
fprintf('  POROWNANIE SCENARIUSZY KOALICYJNYCH - Wybory 1922\n');
fprintf('=============================================================\n\n');

fprintf('SCENARIUSZ A: Lewica (blok) vs pozostale partie osobno\n');
fprintf('%s\n', repmat('-',1,48));
[~,sA] = sort(wA,'descend');
for i = 1:n_A
    k = sA(i);
    fprintf('  %-18s  %3d mand. (%.1f%%)\n', etyk_A{k}, wA(k), wA(k)/total_A*100);
end
fprintf('  Lacznie: %d\n\n', total_A);

fprintf('SCENARIUSZ B: Lewica + Mniejszosci (bloki) vs pozostale osobno\n');
fprintf('%s\n', repmat('-',1,48));
[~,sB] = sort(wB,'descend');
for i = 1:n_B
    k = sB(i);
    fprintf('  %-18s  %3d mand. (%.1f%%)\n', etyk_B{k}, wB(k), wB(k)/total_B*100);
end
prog_B = floor(total_B/2)+1;
fprintf('  Lacznie: %d | Prog wiekszosci: %d\n', total_B, prog_B);
fprintf('  Lewica+Mniejszosci: %d mand.', wB(1)+wB(2));
if wB(1)+wB(2) >= prog_B, fprintf('  -- WIEKSZOC'); end; fprintf('\n\n');

fprintf('SCENARIUSZ C: Prawica vs Lewica vs Mniejszosci (wszystkie bloki)\n');
fprintf('%s\n', repmat('-',1,48));
for i = 1:3
    fprintf('  %-18s  %3d mand. (%.1f%%)\n', etyk_C{i}, wC(i), wC(i)/total_C*100);
end
prog_C = floor(total_C/2)+1;
fprintf('  Lacznie: %d | Prog wiekszosci: %d\n', total_C, prog_C);
for ia = 1:3
    for ib = ia+1:3
        s = wC(ia)+wC(ib);
        fprintf('  %s + %s: %d mand.', etyk_C{ia}, etyk_C{ib}, s);
        if s >= prog_C, fprintf('  -- WIEKSZOC'); end; fprintf('\n');
    end
end

% ============================================================
% Kolory — spójne dla duzych graczy we wszystkich 3 pie chartach
% Kolory malych partii (< ~5% mandatow) maja mniejsze znaczenie
% ============================================================
kol = struct(...
    'LEWICA',      [0.85 0.15 0.15], ...  % czerwony
    'MNIEJSZOSCI', [0.20 0.65 0.30], ...  % zielony
    'PRAWICA',     [0.15 0.25 0.75], ...  % granatowy
    'ChZJN',       [0.15 0.25 0.75], ...  % granatowy (= PRAWICA, dominuje blok)
    'BMN',         [0.20 0.65 0.30], ...  % zielony (= MNIEJSZOSCI, dominuje blok)
    'PC',          [0.40 0.55 0.90], ...  % jasnoniebieski
    'ChSR',        [0.55 0.65 0.95], ...  % bardzo jasnoniebieski
    'KZSN_Z',      [0.35 0.75 0.45], ...  % jasno zielony
    'KZPMiW',      [0.50 0.80 0.55], ...
    'Bund',        [0.60 0.85 0.60], ...
    'ZN_Z',        [0.25 0.60 0.35], ...
    'ZDBL',        [0.15 0.50 0.25]  ...
);

% ============================================================
% WYKRES: 3 pie charty obok siebie
% Scenariusz A: grupujemy male sektory (<3%) w "Inne" dla czytelnosci,
%               ale pokazujemy ChZJN i BMN indywidualnie (sa duze)
% ============================================================
figure('Name','Porownanie scenariuszy koalicyjnych A B C',...
       'NumberTitle','off','Position',[50 50 1500 560]);

% ---- Pomocnicza: rysuj pie z kolorami ze slownika ----
% (inline, bez osobnego pliku)

% ---- PIE A ----
subplot(1,3,1);
[wA_sort, sA2] = sort(wA, 'descend');
etyk_A_sort    = etyk_A(sA2);

% Grupuj sektory < 2% w "Inne" zeby etykiety sie nie nakrywaly
prog_grupuj = total_A * 0.02;
maska_male  = wA_sort < prog_grupuj;
% Zawsze zachowaj LEWICA, ChZJN, BMN nawet jesli male (nie sa)
for i = 1:length(etyk_A_sort)
    if strcmp(etyk_A_sort{i},'LEWICA') || strcmp(etyk_A_sort{i},'ChZJN') || strcmp(etyk_A_sort{i},'BMN')
        maska_male(i) = false;
    end
end
if any(maska_male)
    inne_val   = sum(wA_sort(maska_male));
    wA_pie     = [wA_sort(~maska_male), inne_val];
    etyk_A_pie = [etyk_A_sort(~maska_male), {'Inne'}];
else
    wA_pie     = wA_sort;
    etyk_A_pie = etyk_A_sort;
end

ph = pie(wA_pie);
for i = 1:length(wA_pie)
    key = strrep(etyk_A_pie{i}, '-', '_');
    if isfield(kol, key)
        ph(2*i-1).FaceColor = kol.(key);
    elseif strcmp(etyk_A_pie{i}, 'Inne')
        ph(2*i-1).FaceColor = [0.80 0.80 0.80];
    end
    ph(2*i).String   = sprintf('%s\n%d (%.0f%%)', etyk_A_pie{i}, wA_pie(i), wA_pie(i)/total_A*100);
    ph(2*i).FontSize = 8;
end
title({'Scenariusz A', 'Lewica (blok) vs pozostale osobno'},'FontSize',10,'FontWeight','bold');

% ---- PIE B ----
subplot(1,3,2);
[wB_sort, sB2] = sort(wB, 'descend');
etyk_B_sort    = etyk_B(sB2);
ph = pie(wB_sort);
for i = 1:length(wB_sort)
    key = strrep(etyk_B_sort{i}, '-', '_');
    if isfield(kol, key), ph(2*i-1).FaceColor = kol.(key); end
    ph(2*i).String   = sprintf('%s\n%d (%.0f%%)', etyk_B_sort{i}, wB_sort(i), wB_sort(i)/total_B*100);
    ph(2*i).FontSize = 9;
end
title({'Scenariusz B', 'Lewica + Mniejszosci (bloki) vs pozostale'},'FontSize',10,'FontWeight','bold');

% ---- PIE C ----
subplot(1,3,3);
[wC_sort, sC2] = sort(wC, 'descend');
etyk_C_sort    = etyk_C(sC2);
ph = pie(wC_sort);
for i = 1:length(wC_sort)
    key = strrep(etyk_C_sort{i}, '-', '_');
    if isfield(kol, key), ph(2*i-1).FaceColor = kol.(key); end
    ph(2*i).String   = sprintf('%s\n%d (%.0f%%)', etyk_C_sort{i}, wC_sort(i), wC_sort(i)/total_C*100);
    ph(2*i).FontSize = 10;
end
title({'Scenariusz C', 'Prawica vs Lewica vs Mniejszosci (bloki)'},'FontSize',10,'FontWeight','bold');

sgtitle({'Porownanie scenariuszy koalicyjnych A, B, C',...
         'Wybory parlamentarne w Polsce 1922'},'FontSize',13);

fprintf('\nPorownanie zakonczone.\n');
