# Hipotetyczna analiza wyborów parlamentarnych w Polsce 1922

Projekt symuluje **alternatywne scenariusze** przebiegu wyborów do Sejmu I kadencji (1922 r.) w II Rzeczypospolitej. Celem jest pokazanie, jak stosunkowo niewielkie zmiany w ordynacji wyborczej mogły wpłynąć na rozkład mandatów i – potencjalnie – na dalsze losy II RP.

## Cel projektu

Zbadanie wpływu trzech kluczowych elementów ordynacji wyborczej na wyniki wyborów z 1922 roku:
- Zjednoczenia list wyborczych (koalicje przedwyborcze)
- Metody przeliczania głosów na mandaty
- Struktury okręgów wyborczych

---

## Struktura repozytorium

```
matlab-project/
├── wspolne/                        # Wspólne dane i funkcje obliczeniowe
│   ├── dane_1922.m                 # Dane bazowe wyborów 1922 (15 partii, 64 okręgi)
│   ├── dhondt.m                    # Metoda d'Hondta
│   ├── sainte_lague.m              # Metoda Sainte-Laguë (czysta i zmodyfikowana)
│   ├── adams.m                     # Metoda Adamsa
│   ├── hamilton.m                  # Metoda Hamiltona (największych reszt)
│   └── rozklad_mandatow_dla_okregow.m  # Helper: d'Hondt dla wielu okręgów
│
├── Scenariusz_1/                   # Scenariusz koalicji przedwyborczych
│   ├── dane_koalicje.m             # Dane trzech układów koalicyjnych (A, B, C)
│   ├── podscenariusz_A.m           # Lewica (PZL) vs reszta
│   ├── podscenariusz_B.m           # Lewica vs Mniejszości vs reszta
│   ├── podscenariusz_C.m           # Prawica vs Lewica vs Mniejszości
│   └── uruchom_wszystkie.m         # Porównanie wszystkich podscenariuszy
│
├── Scenariusz_2/                   # Scenariusz metod przeliczania mandatów
│   ├── dane_wybory1922.m           # Dane bazowe dla Scenariusza 2
│   ├── scenariusz1_dhondt.m        # Metoda d'Hondta (historyczna)
│   ├── scenariusz2_sainte_lague.m  # Metoda Sainte-Laguë
│   ├── scenariusz3_adams.m         # Metoda Adamsa
│   ├── scenariusz4_dhondt_prog.m   # D'Hondt z progiem 5%
│   ├── scenariusz5_hamilton.m      # Metoda Hamiltona
│   └── porownanie_wszystkich.m     # Porównanie wszystkich metod
│
├── Scenariusz_3/                   # Scenariusz struktury okręgów
│   ├── dane_okregi.m               # Dane dla dwóch konfiguracji okręgów
│   ├── podscenariusz_A.m           # Dwa makrookręgi (Polska A i B)
│   ├── podscenariusz_B.m           # Jeden okrąg ogólnokrajowy
│   └── uruchom_wszystkie.m         # Porównanie wszystkich konfiguracji
│
├── Wybory.xlsx                     # Źródłowe dane wyborcze 1922
└── README.md
```

---

## Scenariusze

### 1. Scenariusz koalicji (`Scenariusz_1/`)

Bada, jak przedwyborcze zjednoczenie list mogło zmienić wynik wyborów.

- **Podscenariusz A** — Koalicja lewicy (`PZL` = PSL-P + PSL-W + PSL-L + PPS + NPR) vs reszta partii
- **Podscenariusz B** — Lewica (`PZL`) vs Blok Mniejszości Narodowych (`WMN`) vs reszta
- **Podscenariusz C** — Koalicja prawicy (`PJN`) vs lewica (`PZL`) vs mniejszości (`WMN`)

Każdy podscenariusz generuje **wykres słupkowy** (mandaty vs wzorzec proporcjonalny)
oraz **wykres kołowy** (skład parlamentu).

### 2. Scenariusz metod przeliczania mandatów (`Scenariusz_2/`)

Porównuje, ile mandatów zdobyłyby partie przy zastosowaniu różnych metod:

| Skrypt                       | Metoda                             |
|------------------------------|------------------------------------|
| `scenariusz1_dhondt.m`       | D'Hondt (metoda historyczna)       |
| `scenariusz2_sainte_lague.m` | Sainte-Laguë (czysta i zmodyfik.)  |
| `scenariusz3_adams.m`        | Adams                              |
| `scenariusz4_dhondt_prog.m`  | D'Hondt z progiem 5%               |
| `scenariusz5_hamilton.m`     | Hamilton / Hare (największe reszty)|
| `porownanie_wszystkich.m`    | Zestawienie wszystkich metod       |

### 3. Scenariusz struktury okręgów (`Scenariusz_3/`)

Bada wpływ liczby okręgów wyborczych na rozdział mandatów.

- **Podscenariusz A** — Dwa duże okręgi: Polska "A" (204 mandaty) i Polska "B" (168 mandatów)
- **Podscenariusz B** — Jeden okrąg ogólnokrajowy (372 mandaty)

Każdy podscenariusz zawiera **wykres słupkowy** i **dwa wykresy kołowe** (historyczny vs alternatywny).

---

## Jak uruchomić?

1. Sklonuj repozytorium i otwórz MATLAB
2. Ustaw główny folder projektu jako bieżący katalog (`cd matlab-project`)
3. Uruchom wybrany skrypt, np.:

```matlab
% Pojedynczy podscenariusz (wykresy + tabela w konsoli)
run('Scenariusz_1/podscenariusz_A.m')
run('Scenariusz_2/scenariusz1_dhondt.m')
run('Scenariusz_3/podscenariusz_B.m')

% Pełne porównanie w ramach scenariusza
run('Scenariusz_1/uruchom_wszystkie.m')
run('Scenariusz_2/porownanie_wszystkich.m')
run('Scenariusz_3/uruchom_wszystkie.m')
```

> Każdy skrypt samodzielnie dodaje do ścieżki folder `wspolne/` — nie trzeba nic konfigurować ręcznie.
