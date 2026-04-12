# Hipotetyczna analiza wyborów parlamentarnych w Polsce 1922

Projekt symuluje **alternatywne scenariusze** przebiegu wyborów do Sejmu I kadencji (1922 r.) w II Rzeczypospolitej. Celem jest pokazanie, jak stosunkowo niewielkie zmiany w ordynacji wyborczej mogły wpłynąć na rozkład mandatów i – potencjalnie – na dalsze losy II RP.

## Cel projektu

Zbadanie wpływu trzech kluczowych elementów ordynacji wyborczej na wyniki wyborów z 1922 roku:
- Zjednoczenia list wyborczych (koalicje przedwyborcze)
- Metody przeliczania głosów na mandaty
- Struktury okręgów wyborczych

## Scenariusze

### 1. Scenariusz koalicji (przedwyborcze zjednoczenie list)
- **Podscenariusz A** — Koalicja lewicy (PPS + PSL „Wyzwolenie” + ewentualnie inni) vs reszta partii
- **Podscenariusz B** — Koalicja lewicy vs Blok Mniejszości Narodowych vs reszta partii
- **Podscenariusz C** — Koalicja prawicy vs koalicja lewicy vs koalicja mniejszości narodowych

### 2. Scenariusz metod przeliczania mandatów
- Metoda **d’Hondta** (historyczna – punkt odniesienia)
- Metoda **Sainte-Laguë** (czysta)
- Metoda **Adamsa**
- Metoda **Jefferson** (= D'Hondt, ale z progiem 5%)
- Metoda **Hamilton/Hare** (metoda największych reszt)

### 3. Scenariusz struktury okręgów
- **Podscenariusz A** — Dwa duże okręgi (Polska „A” i Polska „B”)
- **Podscenariusz B** — Jeden okręg krajowy (cała Polska jako jeden okręg)


## Jak uruchomić projekt?

1. Sklonuj repozytorium
2. Otwórz MATLAB i ustaw folder projektu jako bieżący
3. Uruchom główny skrypt:

```matlab
run('porownanie_wszystkich.m')
