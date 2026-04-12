% =========================================================
% DANE OKRĘGÓW — Wybory parlamentarne w Polsce 1922
% Używane przez podscenariusze A i B (Scenariusz 3)
%
% Podscenariusz A: dwa duże okręgi — Polska "A" (centrum/zachód)
%                  i Polska "B" (wschód/kresy)
% Podscenariusz B: jeden ogólnokrajowy okrąg wyborczy
%
% Kolumny odpowiadają partiom z dane_1922.m:
% ChZJN, BMN, PSL-P, PSL-W, PPS, NPR, PC, KZSN-Ż, KZPMiW,
% ChSR, Bund, ZN-Ż, PSL-L, ŻDBL, Inni
% =========================================================

%-------------------------------------------------------
% PODSCENARIUSZ A — dwa okręgi (Polska A i Polska B)
%-------------------------------------------------------
% Okrąg 1 (Polska A): okręgi centralne i zachodnie — 204 mandaty
% Okrąg 2 (Polska B): okręgi wschodnie i kresowe — 168 mandatów

okregi_AB_mandaty = [204, 168];

% Wyniki uśrednione ważone głosami dla każdego z dwóch makrookręgów
okregi_AB_dane = [
    37.51, 12.61, 10.74,  9.42, 11.46,  9.61, 2.71, 0.00, 1.32, 0.33, 0.62, 1.32, 0.26, 0.34, 1.75;
    19.45, 20.59, 15.95, 12.36,  8.18,  0.25, 3.00, 5.62, 0.83, 2.55, 1.03, 0.27, 1.10, 0.57, 6.04;
];

%-------------------------------------------------------
% PODSCENARIUSZ B — jeden okrąg ogólnokrajowy
%-------------------------------------------------------
% Cała Polska jako jeden okrąg wyborczy — 372 mandaty

okrag_PL_mandaty = [372];

okrag_PL_dane = [29.32, 16.22, 13.10, 10.75, 9.98, 5.37, 2.84, 2.55, 1.10, 1.34, 0.80, 0.85, 0.64, 0.44, 3.50];
