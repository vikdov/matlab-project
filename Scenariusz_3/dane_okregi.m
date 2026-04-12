% =========================================================
% DANE OKRĘGÓW — Scenariusz 3
% Plik: Scenariusz_3/dane_okregi.m
%
% Definiuje podział 64 okręgów wyborczych z 1922 roku
% na dwa makrookręgi według kryterium zaborowego:
%
%   POLSKA "A" — okręgi 1–40
%     Kongresówka (zabór rosyjski, centralna Polska)
%     + zabór pruski (Wielkopolska, Pomorze)
%     + Kresy północno-zachodnie (Wilno, Grodno, Nowogródek)
%
%   POLSKA "B" — okręgi 41–64
%     Galicja (zabór austriacki: Lwów, Kraków, Rzeszów)
%     + Kresy wschodnie (Wołyń, Polesie)
%
% Podział oparty na historycznym układzie okręgów
% wyborczych Sejmu Ustawodawczego z 1922 r.
% =========================================================

% Indeksy okręgów należących do każdego makrookręgu
IDX_POLSKA_A = 1:40;   % Kongresówka + zabór pruski + Kresy północno-zachodnie
IDX_POLSKA_B = 41:64;  % Galicja + Kresy wschodnie + Wołyń

% Nazwy okręgów (dla etykiet na wykresach)
nazwy_okregow = {
    'Warszawa m.',  'Warszawa okr.', 'Łódź',         'Kalisz',       ...  % 1-4
    'Kielce',       'Lublin',        'Piotrków',      'Płock',        ...  % 5-8
    'Radom',        'Siedlce',       'Suwałki',       'Białystok',    ...  % 9-12
    'Wilno',        'Grodno',        'Brześć n/B',    'Łomża',        ...  % 13-16
    'Nowogródek',   'Poznań',        'Bydgoszcz',     'Gniezno',      ...  % 17-20
    'Inowrocław',   'Leszno',        'Ostrów Wlkp',   'Szamotuły',    ...  % 21-24
    'Śrem',         'Wągrowiec',     'Toruń',         'Chełmno',      ...  % 25-28
    'Gdańsk okr',   'Grudziądz',     'Starogard',     'Tczew',        ...  % 29-32
    'Wąbrzeźno',    'Świecie',       'Chojnice',      'Działdowo',    ...  % 33-36
    'Sierpc',       'Brodnica',      'Rypin',         'Nieszawa',     ...  % 37-40
    'Lwów m.',      'Lwów okr.',     'Bóbrka',        'Brody',        ...  % 41-44
    'Drohobycz',    'Gródek Jag.',   'Jaworów',       'Kołomyja',     ...  % 45-48
    'Przemyśl',     'Rzeszów',       'Sambor',        'Sanok',        ...  % 49-52
    'Stryj',        'Tarnopol',      'Złoczów',       'Kraków',       ...  % 53-56
    'Bochnia',      'Chrzanów',      'Nowy Sącz',     'Tarnów',       ...  % 57-60
    'Stanisławów',  'Równe',         'Łuck',          'Poleskie'      ...  % 61-64
};

fprintf('  Dane okręgów załadowane.\n');
fprintf('  Polska A: okręgi %d–%d (%d okręgów)\n', ...
    IDX_POLSKA_A(1), IDX_POLSKA_A(end), length(IDX_POLSKA_A));
fprintf('  Polska B: okręgi %d–%d (%d okręgów)\n', ...
    IDX_POLSKA_B(1), IDX_POLSKA_B(end), length(IDX_POLSKA_B));
