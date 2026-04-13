% =========================================================
% SCENARIUSZ 2: POROWNANIE WSZYSTKICH METOD
% Plik: Scenariusz_2/porownanie_wszystkich.m
%
% Metody: D'Hondt (hist.) | Czysta S-L | Zmod. S-L |
%         Adams | D'Hondt+prog5% | Hamilton
%
% Okno 1: wykres slupkowy liczby mandatow (istniejacy)
% Okno 2: pie charty procentowego udzialu dla kazdej metody
% =========================================================

clear; clc;
addpath('../wspolne');
run('../wspolne/dane_1922.m');

n_partii  = length(partie_1922);
n_okregow = length(okregi_1922_mandaty);

W = zeros(n_partii, 6);
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

nazwy_met = {"D'Hondt (hist.)", "Sainte-Lague", "Zmod. S-L", ...
             "Adams", "D'Hondt+5%", "Hamilton"};

% ---- Tabela konsola ----
fprintf('\n=======================================================================\n');
fprintf('  ZESTAWIENIE WSZYSTKICH METOD - Wybory 1922\n');
fprintf('=======================================================================\n');
fmt_h = '%-12s %14s %14s %12s %12s %14s %12s\n';
fmt_r = '%-12s %14d %14d %12d %12d %14d %12d\n';
fprintf(fmt_h,'Partia',nazwy_met{:});
fprintf('%s\n',repmat('-',1,92));
[~,idx] = sort(W(:,1),'descend');
for i=1:n_partii
    p=idx(i);
    if any(W(p,:)>0)
        fprintf(fmt_r,partie_1922{p},W(p,1),W(p,2),W(p,3),W(p,4),W(p,5),W(p,6));
    end
end
fprintf('%s\n',repmat('-',1,92));
fprintf(fmt_r,'LACZNIE',sum(W(:,1)),sum(W(:,2)),sum(W(:,3)),sum(W(:,4)),sum(W(:,5)),sum(W(:,6)));

% ---- Indeks Gallaghera ----
fprintf('\n--- Indeks Gallaghera ---\n');
glosy_n = partie_1922_dane/sum(partie_1922_dane)*100;
for s=1:6
    tot = sum(W(:,s));
    G = sqrt(0.5*sum((glosy_n' - W(:,s)/tot*100).^2));
    fprintf('  %-18s  G = %.4f\n', nazwy_met{s}, G);
end

% ================================================================
% OKNO 1: Wykres slupkowy liczby mandatow (niezmieniony)
% ================================================================
figure('Name','Porownanie metod - mandaty','NumberTitle','off','Position',[30 80 1300 550]);

partie_akt = any(W>0,2);
naz_p = partie_1922(partie_akt);
W_p   = W(partie_akt,:);
[~,srt] = sort(W_p(:,1),'descend');
W_p = W_p(srt,:); naz_p = naz_p(srt);

bar(1:size(W_p,1), W_p);
xticks(1:size(W_p,1)); xticklabels(naz_p); xtickangle(45);
legend(nazwy_met,'Location','northeast','FontSize',9);
ylabel('Liczba mandatow');
title({'Porownanie metod przydzialu mandatow','Wybory parlamentarne w Polsce 1922'},'FontSize',13);
grid on;

% ================================================================
% OKNO 2: Pie charty procentowe dla kazdej metody (6 subplotow)
% ================================================================
figure('Name','Porownanie metod - udzialy %','NumberTitle','off','Position',[30 80 1400 750]);

% Tylko partie z >0 mandatow w przynajmniej jednej metodzie
partie_akt2 = any(W>0,2);
naz2 = partie_1922(partie_akt2);
W2   = W(partie_akt2,:);

% Kolory — staly zestaw dla tych samych partii we wszystkich pie
n_sektorow = sum(partie_akt2);
cmap = lines(n_sektorow);

for s = 1:6
    subplot(2,3,s);
    vals = W2(:,s);
    % Dla pie: połącz sektory ponizej 1% w "inne" zeby nie zasmiecac
    prog_pie = sum(vals)*0.01;
    maska_male = vals < prog_pie & vals > 0;
    vals_plot = vals;
    naz_plot  = naz2;
    if any(maska_male)
        inne_val = sum(vals(maska_male));
        vals_plot = [vals(~maska_male); inne_val];
        naz_plot  = [naz2(~maska_male), {'Inne'}];
    end

    p_h = pie(vals_plot);
    % Ustaw procenty w etykietach
    tot_s = sum(vals_plot);
    etyk_pie = cell(1, length(vals_plot));
    for k = 1:length(vals_plot)
        etyk_pie{k} = sprintf('%s\n%.1f%%', naz_plot{k}, vals_plot(k)/tot_s*100);
    end
    % Aktualizuj teksty w pie
    txt_idx = 2:2:length(p_h);
    for k = 1:length(txt_idx)
        p_h(txt_idx(k)).String = etyk_pie{k};
        p_h(txt_idx(k)).FontSize = 7;
    end

    title(nazwy_met{s},'FontSize',10,'FontWeight','bold');
end

sgtitle({'Udzialy procentowe mandatow - porownanie metod',...
         'Wybory parlamentarne w Polsce 1922'},'FontSize',13);

fprintf('\nPorownanie wszystkich metod zakonczone.\n');
