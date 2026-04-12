# Hipotetyczna analiza wyborów parlamentarnych w Polsce 1922

Projekt symuluje **alternatywne scenariusze** przebiegu wyborów do Sejmu I kadencji (1922 r.) w II Rzeczypospolitej. Celem jest pokazanie, jak stosunkowo niewielkie zmiany w ordynacji wyborczej mogły wpłynąć na rozkład mandatów i – potencjalnie – na dalsze losy II RP.

## Cel projektu

Zbadanie wpływu trzech kluczowych elementów ordynacji wyborczej na wyniki wyborów z 1922 roku:
- Zjednoczenia list wyborczych (koalicje przedwyborcze)
- Metody przeliczania głosów na mandaty
- Struktury okręgów wyborczych

## Struktura repozytorium

```
matlab-project/
├── wspolne/                       # Wspólne dane i funkcje
│   ├── dane_1922.m                # Dane wyborcze 1922 (15 partii, 64 okręgi)
│   └── dhondt.m                   # Funkcja metody D'Hondta
│
├── Scenariusz_1/                  # Scenariusz koalicji przedwyborczych
│   ├── dane_koalicje.m            # Dane dla 3 podscenariuszy koalicji
│   └── uruchom.m                  # ← URUCHOM TEN PLIK
│
├── Scenariusz_2/                  # Scenariusz metod przeliczania mandatów
│   ├── dane_wybory1922.m          # Dane wyborcze (używane wewnętrznie)
│   ├── dhondt.m / sainte_lague.m / adams.m / hamilton.m
│   ├── scenariusz1_dhondt.m ... scenariusz5_hamilton.m
│   ├── porownanie_wszystkich.m    # Porównanie wszystkich metod (z wykresem)
│   └── uruchom.m                  # ← URUCHOM TEN PLIK
│
├── Scenariusz_3/                  # Scenariusz struktury okręgów
│   ├── dane_okregi.m              # Dane dla 2 podscenariuszy okręgów
│   └── uruchom.m                  # ← URUCHOM TEN PLIK
│
├── Wybory.xlsx                    # Źródłowe dane wyborcze (Excel)
└── README.md
```

## Scenariusze

### 1. Scenariusz koalicji (przedwyborcze zjednoczenie list)
- **Podscenariusz A** — Koalicja lewicy (PZL) vs reszta partii
- **Podscenariusz B** — Koalicja lewicy (PZL) vs koalicja mniejszości narodowych (WMN) vs reszta
- **Podscenariusz C** — Koalicja prawicy (PJN) vs koalicja lewicy (PZL) vs koalicja mniejszości (WMN)

### 2. Scenariusz metod przeliczania mandatów
- Metoda **D'Hondta** (historyczna – punkt odniesienia)
- Metoda **Sainte-Laguë** (czysta i zmodyfikowana)
- Metoda **Adamsa**
- Metoda **D'Hondt z progiem 5%**
- Metoda **Hamiltona/Hare'a** (największych reszt)

### 3. Scenariusz struktury okręgów
- **Podscenariusz A** — Dwa duże okręgi (Polska „A" i Polska „B")
- **Podscenariusz B** — Jeden okręg krajowy (cała Polska jako jeden okręg)


## Jak uruchomić projekt?

1. Sklonuj repozytorium
2. Otwórz MATLAB i ustaw folder projektu jako bieżący katalog
3. Uruchom wybrany scenariusz (każdy skrypt działa z dowolnego katalogu):

```matlab
% Scenariusz 1 — koalicje (3 wykresy słupkowe)
run('Scenariusz_1/uruchom.m')

% Scenariusz 2 — metody obliczania mandatów (wykres porównawczy + indeks Gallaghera)
run('Scenariusz_2/uruchom.m')

% Scenariusz 3 — struktury okręgów (wykres słupkowy + kołowy)
run('Scenariusz_3/uruchom.m')
```
