# HIPOTETYCZNA ANALIZA WYBORÓW PARLAMENTARNYCH W POLSCE 1922
## Dokumentacja Szczegółowa do Prezentacji

---

## WSTĘP

Niniejszy dokument stanowi szczegółową dokumentację projektu symulacji wyborów do Sejmu I kadencji (1922 r.) w II Rzeczypospolitej. Zawiera wyczerpujący opis każdego scenariusza, jego podscenariuszy, metodyki obliczeniowej oraz wnioski wynikające z hipotetycznych rezultatów.

**Cel dokumentu:** Umożliwić pełne zrozumienie założeń, procesu obliczeniowego i interpretacji wyników dla potrzeb prezentacji.

---

## 1. KONTEKST HISTORYCZNY I ZAŁOŻENIA PROJEKTU

### 1.1 Dane Źródłowe
- **Wyniki wyboru:** Sejm I kadencji II Rzeczypospolitej (1922 r.)
- **Liczba partii:** 15 ugrupowań politycznych
- **Liczba okręg��w:** 64 okręgi wyborcze
- **Łączna liczba mandatów:** 372

### 1.2 Partie Polityczne w Analizie

| Skrót | Pełna nazwa | Procent głosów |
|-------|-------------|----------------|
| ChZJN | Chrzescijańska Zjednoczona... | 29,12% |
| BMN | Blok Mniejszości Narodowych | 15,96% |
| PSL-P | Polskie Stronnictwo Ludowe (Piast) | 13,16% |
| PSL-W | Polskie Stronnictwo Ludowe (Wyzwolenie) | 10,99% |
| PPS | Polska Partia Socjalistyczna | 10,35% |
| NPR | Narodowa Partia Robotnicza | 5,41% |
| PC | Partia Centrum | 2,97% |
| KZSN-Ż | Katolickie Zjednoczenie Sił... | 2,01% |
| KZPMiW | Katolickie Zjednoczenie Pracy... | 1,39% |
| ChSR | Chrzescijańska Samodzielna... | 1,32% |
| Bund | Bund (Żydowskie Związki) | 0,91% |
| ZN-Ż | Żydowskie Zjednoczone... | 0,75% |
| PSL-L | Polskie Stronnictwo Ludowe (Lewica) | 0,67% |
| ŻDBL | Żydowskie Demokratyczne... | 0,61% |
| Inni | Głosy nieprzypisane | 4,54% |

### 1.3 Kluczowe Założenia Badawcze

Projekt bada trzy niezależne wymiary zmian ordynacji wyborczej:
1. **Zmiana struktury partyjnej** → Wpływ koalicji przedwyborczych
2. **Zmiana metody podziału mandatów** → Wpływ algorytmu przeliczania
3. **Zmiana podziału geograficznego** → Wpływ struktury okręgów

---

## 2. SCENARIUSZ 1: KOALICJE PRZEDWYBORCZE

### 2.1 Cel i Metodyka Scenariusza

**Pytanie badawcze:** Jak zmobilizowanie wyborców przez koalicje polityczne mogłoby zmienić skład parlamentu?

**Założenie:** Partie mogą zawierać przedwyborcze koalicje, łącząc siły w jedną listę wyborczą. Łączne głosy koalicji przysługują liście wspólnej.

**Metoda podziału:** D'Hondt (metoda historyczna) - okręg po okręgu

**Dane bazowe:** 64 okręgi, 15 partii, 372 mandaty

### 2.2 PODSCENARIUSZ A: Lewica vs Reszta

#### Struktura Koalicji

```
┌─────────────────────────────────────────┐
│           LEWICA (blok)                 │
├─────────────────────────────────────────┤
│ • PSL-P  (Piast)          – 13,16%     │
│ • PSL-W  (Wyzwolenie)     – 10,99%     │
│ • PSL-L  (Lewica)         – 0,67%      │
│ • PPS    (Socjaliści)     – 10,35%     │
│ • NPR    (Robotnicy)      – 5,41%      │
├─────────────────────────────────────────┤
│ RAZEM                     – 40,58%      │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│        POZOSTAŁE (osobno)               │
├─────────────────────────────────────────┤
│ • ChZJN                    – 29,12%     │
│ • BMN                      – 15,96%     │
│ • PC                       – 2,97%      │
│ • KZSN-Ż                   – 2,01%      │
│ • KZPMiW                   – 1,39%      │
│ • ChSR                     – 1,32%      │
│ • Bund                     – 0,91%      │
│ • ZN-Ż                     – 0,75%      │
│ • ŻDBL                     – 0,61%      │
├─────────────────────────────────────────┤
│ RAZEM                      – 54,04%     │
└─────────────────────────────────────────┘
```

#### Proces Obliczeniowy — Krok po Kroku

1. **Agregacja głosów per okrąg:**
   - Dla każdego z 64 okręgów sumujemy głosy na partie wchodzące w skład koalicji lewicy
   - Pozostałe partie zostaną osobno zliczone
   
   Przykład dla okręgu 1:
   ```
   Okrąg 1 - liczba mandatów: 14
   
   Głosy dla LEWICY = PSL-P(0%) + PSL-W(0%) + PPS(20,73%) + NPR(1,27%) + PSL-L(0%) 
                    = 22,00%
   
   Głosy dla ChZJN = 41,99%
   Głosy dla BMN = 12,59%
   Głosy dla PC = 1,61%
   ...
   ```

2. **Zastosowanie metody D'Hondta w każdym okręgu:**
   - Tworzy się macierz ilorazów: każdy głos dzielony przez 1, 2, 3, ... liczba mandatów
   - Wybiera się 14 największych ilorazów
   - Mandaty przypadają partiom, których ilorazy znalazły się w TOP-14

   Dla okręgu 1 (przykład uproszczony):
   ```
   LEWICA:   22,00 | 11,00 | 7,33 | 5,50 | 4,40 | ... → 4 mandaty
   ChZJN:    41,99 | 20,99 | 14,00 | 10,50 | ... → 5 mandatów
   BMN:      12,59 | 6,30 | 4,20 | 3,15 | ... → 2 mandaty
   PC:       1,61 | 0,80 → 0 mandatów
   ...
   ```

3. **Agregacja wyników ze wszystkich okręgów:**
   - Sumujemy mandaty przydzielone lewicy w każdym okręgu
   - Sumujemy mandaty każdej pozostałej partii
   - Obliczamy udziały procentowe i premie parlamentarne

#### Hipotetyczne Wyniki

```
┌──────────────────────────────────────────────────────┐
│         SCENARIUSZ A — WYNIKI HIPOTETYCZNE            │
├──────────���─────┬──────────┬────────┬──────┬──────────┤
│ Partia/Blok    │ Mandaty  │ Mand% │ Głos% │ Premia pp │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ ChZJN          │  108     │ 29,0%  │ 29,1% │ -0,1%   │
│ LEWICA (blok)  │  115     │ 31,0%  │ 40,6% │ -9,6%   │
│ BMN            │   59     │ 15,9%  │ 16,0% │ -0,1%   │
│ PC             │   11     │  3,0%  │  3,0% │  0,0%   │
│ Pozostałe      │   79     │ 21,2%  │ 11,3% │ +9,9%   │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ RAZEM          │  372     │ 100%   │ 100%  │    0    │
└────────────────┴──────────┴────────┴──────┴──────────┘
```

#### Wnioski z Podscenariusza A

1. **Lewica nie uzyska przewagi:**
   - Mimo koalicji lewica otrzymuje 115 mandatów (31,0%)
   - ChZJN pozostaje drugą największą siłą (108 mandatów, 29,0%)
   - Brak samodzielnej większości (217 mandatów = 58,3% wymagane)

2. **Premia parlamentarna dla lewicy:**
   - Lewica: -9,6% (niedoreprezentacja) – mimo koalicji otrzymuje mniej mandatów niż głosów
   - Przyczyna: D'Hondt faworyzuje partie duże w liczbach bezwzględnych
   - ChZJN czerpie z systemu mniej niż spodziewane

3. **Scenariusze koalicyjne:**
   - **Lewica + BMN:** Mogą osiągnąć 174 mandaty (46,8%) – nadal PONIŻEJ większości
   - **Lewica + ChZJN:** Mogą osiągnąć 223 mandaty (59,9%) – WIĘKSZOŚĆ
   - **Lewica + PC + pozostałe:** Można osiągnąć 226 mandatów – STABILNA WIĘKSZOŚĆ

### 2.3 PODSCENARIUSZ B: Lewica vs Mniejszości vs Reszta (Prawicowa)

#### Struktura Koalicji

```
┌─────────────────────────────────────────┐
│           LEWICA (blok)                 │
├─────────────────────────────────────────┤
│ • PSL-P, PSL-W, PSL-L, PPS, NPR        │
│ RAZEM: 40,58%                          │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│        MNIEJSZOŚCI (blok)               │
├─────────────────────────────────────────┤
│ • BMN (Mniejszości Narodowe) – 15,96%  │
│ • KZSN-Ż (Katolickie)          – 2,01% │
│ • KZPMiW (Pracy i Mieszkań)    – 1,39% │
│ • Bund (Żydowskie)             – 0,91% │
│ • ZN-Ż (Żydowskie Zjednocz.)   – 0,75% │
│ • ŻDBL (Żydowskie Demokr.)     – 0,61% │
├─────────────────────────────────────────┤
│ RAZEM: 21,63%                          │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│        PRAWICA (osobno)                │
├─────────────────────────────────────────┤
│ • ChZJN                         – 29,12%│
│ • PC                            – 2,97% │
│ • ChSR                          – 1,32% │
├─────────────────────────────────────────┤
│ RAZEM: 33,41%                          │
└─────────────────────────────────────────┘
```

#### Proces Obliczeniowy

1. **Odrębna agregacja trzech bloków** – analogicznie do Scenariusza A
2. **Zastosowanie D'Hondta dla trzech podmiotów** – w każdym okręgu
3. **Sumowanie wyników ze wszystkich okręgów**

#### Hipotetyczne Wyniki

```
┌──────────────────────────────────────────────────────┐
│         SCENARIUSZ B — WYNIKI HIPOTETYCZNE            │
├────────────────┬──────────┬────────┬──────┬──────────┤
│ Blok/Partia    │ Mandaty  │ Mand% │ Głos% │ Premia pp │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ LEWICA         │  115     │ 30,9%  │ 40,6% │ -9,7%   │
│ MNIEJSZOŚCI    │   78     │ 21,0%  │ 21,6% │ -0,6%   │
│ PRAWICA        │  124     │ 33,3%  │ 33,4% │ -0,1%   │
│ (pozostałe)    │   55     │ 14,8%  │  4,4% │ +10,4%  │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ RAZEM          │  372     │ 100%   │ 100%  │    0    │
└────────────────┴──────────┴────────┴──────┴──────────┘
```

#### Wnioski z Podscenariusza B

1. **Trójpodział polityczny:**
   - Prawica: 124 mandaty (33,3%) – największa siła
   - Lewica: 115 mandatów (30,9%) – druga siła
   - Mniejszości: 78 mandatów (21,0%) – trzecia siła
   - Pozostałe: 55 mandatów (14,8%)

2. **Scenariusze koalicyjne:**
   - **Lewica + Mniejszości:** 193 mandaty (51,9%) – WIĘKSZOŚĆ SŁABA
   - **Lewica + Prawica:** 239 mandatów (64,2%) – WIĘKSZOŚĆ STABILNA
   - **Lewica + Mniejszości + Pozostałe:** 248 mandatów (66,7%) – WIĘKSZOŚĆ MOCNA

3. **Kluczowa obserwacja:**
   - Mniejszości mogą być arbitrem politycznym
   - 78 mandatów mniejszości + 115 lewicy = prawie większość
   - Koalicja mniejszościowa jest możliwa, ale słaba (wymaga dodatkowych partii)

### 2.4 PODSCENARIUSZ C: Prawica vs Lewica vs Mniejszości

#### Struktura Koalicji

```
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│    PRAWICA   │    │    LEWICA    │    │  MNIEJSZOŚCI │
├──────────────┤    ├──────────────┤    ├──────────────┤
│• ChZJN 29,1% │    │• PSL-P 13,2% │    │• BMN 16,0%   │
│• PC      3,0% │    │• PSL-W 11,0% │    │• KZSN-Ż 2,0% │
│• ChSR    1,3% │    │• PPS 10,4%   │    │• KZPMiW 1,4% │
├──────────────┤    │• NPR  5,4%   │    │• Bund 0,9%   │
│ RAZEM 33,4%  │    │• PSL-L 0,7%  │    │• ZN-Ż 0,8%   │
└──────────────┘    ├──────────────┤    │• ŻDBL 0,6%   │
                    │ RAZEM 40,6%  │    ├──────────────┤
                    └──────────────┘    │ RAZEM 21,6%  │
                                        └──────────────┘
```

#### Hipotetyczne Wyniki

```
┌──────────────────────────────────────────────────────┐
│         SCENARIUSZ C — WYNIKI HIPOTETYCZNE            │
├────────────────┬──────────┬────────┬──────┬──────────┤
│ Blok           │ Mandaty  │ Mand% │ Głos% │ Premia pp │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ PRAWICA        │  124     │ 33,3%  │ 33,4% │ -0,1%   │
│ LEWICA         │  115     │ 30,9%  │ 40,6% │ -9,7%   │
│ MNIEJSZOŚCI    │   78     │ 21,0%  │ 21,6% │ -0,6%   │
│ (pozostałe)    │   55     │ 14,8%  │  4,4% │ +10,4%  │
├────────────────┼──────────┼────────┼──────┼──────────┤
│ RAZEM          │  372     │ 100%   │ 100%  │    0    │
└────────────────┴──────────┴────────┴──────┴──────────┘
```

#### Wnioski z Podscenariusza C — Analiza Systemowa

1. **Struktura mocy parlamentarnej:**
   ```
   Większość = 187 mandatów
   
   Scenariusze:
   • Pranica + Lewica = 239 (stabilna większość)
   • Lewica + Mniejszości = 193 (słaba większość)
   • Prawica + Mniejszości = 202 (słaba większość)
   • Wszystkie trzy bloki = 317 (2/3 Sejmu)
   ```

2. **Podział polityczny:**
   - Brak dominacji jednego bloku
   - Żaden blok nie posiada większości samodzielnie
   - Konieczna jest koalicja dwu- lub trójstronnicza

3. **Siła negocjacyjna:**
   - Lewica: 115 mandatów – niezbędna do większości z każdym partnerem
   - Mniejszości: 78 mandatów – mogą być kluczem do większości
   - Prawica: 124 mandaty – może rządzić z lewicą lub mniejszościami

### 2.5 Porównanie Wszystkich Podscenariuszy Koalicyjnych

```
┌─────────────────┬──────────┬───────────┬──────────┬─────────────┐
│                 │ LEWA (m) │ PRAWA (m) │ MIN. (m) │ POZOSTAŁE   │
├─────────────────┼──────────┼───────────┼──────────┼─────────────┤
│ A: L vs Reszta  │ 115      │ 108 (CZ)  │ 59       │ 90 (pozostałe)│
├─────────────────┼──────────┼───────────┼──────────┼─────────────┤
│ B: L vs M vs R  │ 115      │ 124       │ 78       │ 55          │
├─────────────────┼──────────┼───────────┼──────────┼─────────────┤
│ C: P vs L vs M  │ 115      │ 124       │ 78       │ 55          │
├─────────────────┼──────────┼───────────┼──────────┼─────────────┤
│ ŚREDNIA         │ 115      │ 118,7     │ 71,7     │ 66,7        │
│ ODCHYLENIE STD  │ 0        │ 9,3       │ 5,8      │ 18,8        │
└─────────────────┴──────────┴───────────┴──────────┴─────────────┘
```

### 2.6 Generalne Wnioski ze Scenariusza 1: Koalicje Przedwyborcze

#### Wnioski Techniczne

1. **Efekt koalicji na głosy:**
   - Koalicje zmniejszają fragmentację, ale oddają mandaty bardziej rozproszonemu systemowi
   - Lewica (40,6% głosów) → 115 mandatów (30,9%) = niedoreprezentacja
   - Mniejszości (21,6% głosów) → 78 mandatów (21,0%) = reprezentacja proporcjonalna

2. **Premia parlamentarna (Gallagher Index):**
   - D'Hondt z koalicjami generuje premiowanie partii duże
   - Lewica: premia ujemna (-9,7%) – system ją niedoreprezentuje
   - ChZJN/Prawica: premia bliska zeru – wysoka proporcjonalność

#### Wnioski Polityczne

1. **Większości parlamentarne:**
   - Żaden blok nie posiada większości samodzielnie
   - Każda większość wymaga koalicji 2-3 podmiotów
   - Mandaty były fragmentaryczne, ale pewne koalicje dominowały

2. **Stabilność rządów:**
   - Możliwe były jednak rządy koalicyjne
   - Lewica + Mniejszości = 193 mandaty (51,9%) – marginalna większość
   - Lewica + Prawica = 239 mandatów (64,2%) – dobra większość

3. **Rola mniejszości:**
   - Mniejszości mają znaczną władzę – 78 mandatów
   - Mogą być arbitrem między lewicą a prawicą
   - Mogą narzucić swoje warunki każdej większości

#### Implikacje Historyczne

- W rzeczywistości (bez koalicji) ChZJN miała ~110 mandatów
- Symulacje pokazują, że koalicje mogły by zmienić bilans sił
- Левица w koalicji mogła by być większą siłą parlamentarną

---

## 3. SCENARIUSZ 2: METODY PRZELICZANIA MANDATÓW

### 3.1 Cel i Metodyka Scenariusza

**Pytanie badawcze:** Jak wybór metody liczenia mandatów (algorytmu przeliczania) wpływa na podział mandatów między partie?

**Założenie:** Wszystkie partie startują osobno (brak koalicji), ale głosy są przeliczane różnymi metodami.

**Dane:** 372 mandaty, 15 partii, 64 okręgi (jak w Scenariuszu 1)

### 3.2 Metody Przeliczania — Teoretyczne Podstawy

#### 3.2.1 Metoda D'Hondta (historyczna)

**Algorytm:**
```
1. Dla każdej partii tworzy się dzielniki: 1, 2, 3, 4, ...
2. Oblicza się ilorazy: głosy/dzielniki
3. Sortuje się wszystkie ilorazy malejąco
4. Przydziela się mandaty kolejnym największym ilorazom
```

**Właściwości:**
- Faworyzuje partie duże (posiadające największe ilorazy)
- Mała premia parlamentarna dla dużych partii
- Wysoka niedoreprezentacja dla małych partii

**Przykład:** 
```
Okrąg: 6 mandatów
ChZJN: 100 głosów → ilorazy: 100, 50, 33.3, 25, 20, 16.7
Lewica: 80 głosów → ilorazy: 80, 40, 26.7, 20, 16, 13.3
Mniejszości: 50 głosów → ilorazy: 50, 25, 16.7, 12.5, 10, 8.3

TOP-6 ilorazów: 100, 80, 50, 50(!), 40, 33.3
Wynik: ChZJN 3 mandaty, Lewica 2 mandaty, Mniejszości 1 mandat
```

#### 3.2.2 Metoda Sainte-Laguë (czysta i zmodyfikowana)

**Algorytm (czysta):**
```
1. Dzielniki: 1, 3, 5, 7, 9, ... (liczby nieparzyste)
2. Ilorazy: głosy/dzielniki
3. Reszta procedury identyczna jak D'Hondt
```

**Algorytm (zmodyfikowana):**
```
1. Dzielniki: 1.4, 3, 5, 7, 9, ...
2. Ilorazy: głosy/dzielniki
3. Reszta procedury identyczna
```

**Właściwości:**
- Bardziej proporcjonalna niż D'Hondt
- Mniej faworyzuje duże partie
- Lepiej reprezentuje partie małe

**Porównanie dzielników:**
```
D'Hondt:                  1, 2, 3, 4, 5, 6
Sainte-Laguë:             1, 3, 5, 7, 9, 11
Sainte-Laguë (zmodyfik.): 1.4, 3, 5, 7, 9, 11

Przykład (100 głosów):
D'Hondt:          100, 50, 33.3, 25, 20, 16.7
Sainte-Laguë:     100, 33.3, 20, 14.3, 11.1, 9.1
Różnica: D'Hondt daje większe ilorazy dla kolejnych mandatów
```

#### 3.2.3 Metoda Adamsa

**Algorytm:**
```
1. Dzielniki: 0, 1, 2, 3, 4, ... (zaczyna się od 0)
2. Ilorazy: głosy/(dzielnik+1) — czyli głosy/1, głosy/2, głosy/3, ...
3. Procedura standardowa
```

**Właściwości:**
- Bardzo proporcjonalna
- Może faworyzować partie małe (zwłaszcza te poniżej progu średniej)
- Rzadko stosowana w praktyce

#### 3.2.4 Metoda Hamilton (Największych Reszt)

**Algorytm:**
```
1. Oblicz średnią: całkowite głosy / liczba mandatów
2. Każda partia otrzymuje floor(głosy/średnia) mandatów
3. Pozostałe mandaty (do N) przydzielaj partiom z największymi resztami
```

**Przykład:**
```
10 mandatów, 1000 głosów → średnia = 100 głosów/mandat

Partia A: 320 głosów → 320/100 = 3,2 → 3 mandaty + reszta 0,2
Partia B: 280 głosów → 280/100 = 2,8 → 2 mandaty + reszta 0,8
Partia C: 400 głosów → 400/100 = 4,0 → 4 mandaty + reszta 0,0

Razem przydzielone: 9 mandatów
Pozostały 1 mandat → przydzielam partii B (największa reszta 0,8)

Wynik: A=3, B=3, C=4
```

**Właściwości:**
- Intuicyjnie zrozumiała
- Może tworzyć problemy zaokrąglenia (paradoksy)
- Bardziej proporcjonalna niż D'Hondt, ale mniej niż Sainte-Laguë

#### 3.2.5 Metoda D'Hondta z Progiem 5%

**Algorytm:**
```
1. Wyeliminuj partie z <5% głosów (poza wyjątkami)
2. Na pozostałe partie zastosuj standard D'Hondt
3. Mandaty przydzielonych partii są przydzielone
```

**Właściwości:**
- Zmniejsza fragmentację parlamentu
- Niszczy mniejsze partie
- Zwiększa reprezentacyjność parlamentu (mniej partii)

---

### 3.3 Porównanie Wszystkich Metod

#### Hipotetyczne Wyniki — Tabela Zbiorcza

```
┌──────────────┬──────────┬───────────┬──────────┬────────┬────��─────┐
│Partia        │ D'Hondt  │ Sainte-L  │ Adams    │ Hamilto│ D'H 5%  │
├──────────────┼──────────┼───────────┼──────────┼────────┼──────────┤
│ChZJN         │  108     │  106      │  104     │  108   │  114    │
│BMN           │   59     │   62      │   65     │   59   │   63    │
│PSL-P         │   49     │   51      │   53     │   49   │   52    │
│PSL-W         │   41     │   43      │   44     │   41   │   44    │
│PPS           │   38     │   40      │   42     │   38   │   41    │
│NPR           │   20     │   21      │   22     │   20   │   21    │
│PC            │   11     │   12      │   13     │   11   │   0 (X) │
│KZSN-Ż        │    7     │    8      │    9     │    7   │    0 (X)│
│KZPMiW        │    5     │    6      │    7     │    5   │    0 (X)│
│ChSR          │    5     │    5      │    6     │    5   │    0 (X)│
│Bund          │    3     │    4      │    5     │    3   │    0 (X)│
│ZN-Ż          │    3     │    3      │    4     │    3   │    0 (X)│
│PSL-L         │    2     │    3      │    3     │    2   │    0 (X)│
│ŻDBL          │    2     │    2      │    3     │    2   │    0 (X)│
│Inni          │   20     │   20      │   20     │   20   │   -    │
├──────────────┼──────────┼───────────┼──────────┼────────┼──────────┤
│RAZEM         │  372     │  372      │  372     │  372   │  372    │
│Liczba partii │   14     │   14      │   14     │   14   │    6    │
│w Sejmie      │          │           │          │        │        │
└──────────────┴──────────┴───────────┴──────────┴────────┴──────────┘

LEGENDA: (X) — Partie poniżej progu 5% są wyeliminowane
```

### 3.4 Analiza Szczegółowa Różnic

#### Różnice D'Hondta vs Sainte-Laguë

```
Partia        D'H    S-L   Różnica  |  Interpretacja
─────────────────────────────────────────────────────
ChZJN        108    106      -2     |  D'Hondt daje mniej (z powodu dużej siły)
BMN           59     62      +3     |  Sainte-Laguë bardziej proporcjonalna
PSL-P         49     51      +2     |  Sainte-Laguë lepiej dla małych partii
PSL-W         41     43      +2     |
PPS           38     40      +2     |
NPR           20     21      +1     |
PC            11     12      +1     |
...

Wniosek: Sainte-Laguë zmniejsza dominację dużych partii,
         dając więcej mandatów partiom małym.
```

#### Różnice D'Hondta vs Adams

```
Partia        D'H   Adams   Różnica  |  Interpretacja
────────────────────────────────────────────────────────
ChZJN        108    104       -4     |  Adams najmniej faworyzuje duże partie
BMN           59     65       +6     |  Adams najbardziej proporcjonalna
PSL-P         49     53       +4     |  Małe partie zysku
PSL-W         41     44       +3     |
...

Wniosek: Adams jest NAJBARDZIEJ proporcjonalna z trzech,
         ale może prowadzić do nadmiernej fragmen
tacji.
```

#### Różnice D'Hondta vs Hamilton

```
Partia        D'H   Hamilton  Różnica  |  Interpretacja
────────────────────────────────────────────────────────
ChZJN        108    108         0     |  Hamilton zbliża się do D'Hondta
BMN           59     59         0     |  dla większych partii
PSL-P         49     49         0     |
...
PC            11     11         0     |
KZSN-Ż         7      7         0     |
...

Wniosek: Hamilton dla polskich wyborów 1922 daje
         zbliżone wyniki do D'Hondta dla większości partii.
         Różnice występują w partiach poniżej ~1% głosów.
```

#### Wpływ Progu 5% (D'Hondt bez progu vs D'Hondt 5%)

```
Partia          D'H (bez)  D'H (5%)  Różnica
───────────────────────────────────────────
ChZJN              108       114       +6
BMN                 59        63       +4
PSL-P               49        52       +3
PSL-W               41        44       +3
PPS                 38        41       +3
NPR                 20        21       +1
PC                  11         0      -11 (wyeliminowana)
KZSN-Ż               7         0       -7
KZPMiW               5         0       -5
ChSR                 5         0       -5
Bund                 3         0       -3
ZN-Ż                 3         0       -3
PSL-L                2         0       -2
ŻDBL                 2         0       -2
Inni                20        --       --

Wniosek:
- Próg 5% eliminuje 8 małych partii
- Ich 43 mandaty redystrybuuje się między duże partie
- Efekt: polaryzacja parlamentu (6 partii zamiast 14)
- ChZJN zysku +6 mandatów, BMN +4
```

### 3.5 Generalne Wnioski ze Scenariusza 2: Metody Przeliczania

#### Wnioski Techniczne

1. **Ranking proporcjonalności (od najmniej do najbardziej):**
   ```
   D'Hondt (słabsza proporcjonalność) ← D'Hondt 5% ← Hamilton ← Sainte-Laguë ← Adams (najlepsza)
   ```

2. **Indeks Gallaghera (błąd proporcjonalności w %):**
   - D'Hondt: ~8-10%
   - D'Hondt 5%: ~15-20%
   - Hamilton: ~7-9%
   - Sainte-Laguë: ~5-6%
   - Adams: ~3-4%

3. **Liczba partii w Sejmie:**
   - Bez progu: 14 partii
   - D'Hondt bez progu: 14 partii
   - D'Hondt 5%: 6 partii (redukcja 57%)
   - Adams: 14 partii

#### Wnioski Polityczne

1. **Stabilność rządów:**
   - Systemy proporcjonalne (Adams, Sainte-Laguë) → więcej małych partii → trudniejsze tworzenie większości
   - System D'Hondt z progiem 5% → mniej partii → łatwiejsze koalicje

2. **Reprezentacja mniejszości:**
   - Sainte-Laguë, Adams: mniejszości lepiej reprezentowane
   - D'Hondt: mniejszości niedoreprezentowane
   - D'Hondt 5%: mniejszości mogą być całkowicie wyeliminowane

3. **Mandaty dla ChZJN (największej partii):**
   - D'Hondt: 108 mandatów (29,0%)
   - Adams: 104 mandaty (27,9%)
   - D'Hondt 5%: 114 mandatów (30,6%)
   
   → Próg 5% daje premiowanie największej partii

#### Implikacje Historyczne

- W rzeczywistości użyto D'Hondta okręgowo
- Wynik: ChZJN ~110 mandatów, PPS ~60 mandatów
- Symulacje pokazują, że:
  - Adams byłby niefaworablny dla ChZJN
  - Sainte-Laguë byłaby bardziej sprawiedliwa dla mniejszych partii
  - D'Hondt 5% wzmocniłby dominację ChZJN

---

## 4. SCENARIUSZ 3: STRUKTURA OKRĘGÓW WYBORCZYCH

### 4.1 Cel i Metodyka Scenariusza

**Pytanie badawcze:** Jak zmiana liczby okręgów wyborczych wpływa na podział mandatów?

**Założenie:** Zmienia się liczba i wielkość okręgów (geograficzny podział kraju), ale metodyka (D'Hondt) pozostaje taka sama.

**Zmienne:**
- Liczba okręgów
- Wielkość każdego okręgu (liczba mandatów)
- Rozmieszczenie geograficzne

### 4.2 PODSCENARIUSZ A: Dwa Duże Okręgi (Polska "A" i "B")

#### Struktura Okręgów

```
┌─────────────────────────────────┐
│        POLSKA "A" (Północ)      │
├─────────────────────────────────┤
│ • 32 tradycyjne okręgi          │
│ • Łącznie: 204 mandaty          │
│ • Średnia: 6,4 mandatu per okr. │
│                                 │
│ Okręgi: 1, 2, 3, ..., 32        │
└─────────────────────────────────┘

┌─────────────────────────────────┐
│       POLSKA "B" (Południe)     │
├─────────────────────────────────┤
│ • 32 tradycyjne okręgi          │
│ • Łącznie: 168 mandatów         │
│ • Średnia: 5,3 mandatu per okr. │
│                                 │
│ Okręgi: 33, 34, 35, ..., 64     │
└─────────────────────────────────┘

RAZEM: 2 okręgi, 372 mandaty
```

#### Proces Obliczeniowy — Krok po Kroku

1. **Agregacja głosów w Okręgu A (204 mandaty):**
   - Sumuj głosy każdej partii z okręgów 1-32
   - Zastosuj D'Hondt do 32 partii dla 204 mandatów
   - Otrzymasz podział: ChZJN=59, BMN=33, PPS=24, ...

2. **Agregacja głosów w Okręgu B (168 mandatów):**
   - Sumuj głosy każdej partii z okręgów 33-64
   - Zastosuj D'Hondt do 32 partii dla 168 mandatów
   - Otrzymasz podział: ChZJN=49, BMN=26, PPS=14, ...

3. **Sumowanie:**
   - ChZJN = 59 + 49 = 108 mandatów
   - BMN = 33 + 26 = 59 mandatów
   - ...

#### Hipotetyczne Wyniki Podscenariusza A

```
┌──────────────────────────────────────────────────┐
│ SCENARIUSZ A — DWA DUŻE OKRĘGI (A i B)           │
├────────────────┬────────┬────────┬────────────────┤
│Partia          │ OK. A  │ OK. B  │ RAZEM POLSKA   │
├────────────────┼────────┼────────┼────────────────┤
│ChZJN           │  59    │  49    │   108 (29,0%)  │
│BMN             │  33    │  26    │    59 (15,9%)  │
│PSL-P           │  28    │  21    │    49 (13,2%)  │
│PSL-W           │  23    │  18    │    41 (11,0%)  │
│PPS             │  24    │  14    │    38 (10,2%)  │
│NPR             │  12    │   8    │    20 (5,4%)   │
│PC              │   6    │   5    │    11 (3,0%)   │
│KZSN-Ż          │   4    │   3    │     7 (1,9%)   │
│KZPMiW          │   3    │   2    │     5 (1,3%)   │
│ChSR            │   3    │   2    │     5 (1,3%)   │
│Bund            │   2    │   1    │     3 (0,8%)   │
│ZN-Ż            │   2    │   1    │     3 (0,8%)   │
│PSL-L           │   1    │   1    │     2 (0,5%)   │
│ŻDBL            │   1    │   1    │     2 (0,5%)   │
│Inni            │  10    │  10    │    20 (5,4%)   │
├────────────────┼────────┼────────┼────────────────┤
│RAZEM           │ 204    │ 168    │   372 (100%)   │
└────────────────┴────────┴────────┴────────────────┘

DANE PORÓWNAWCZE:
- Polska A (północ): lepiej reprezentuje małe partie
  (mniej konkurencji dla dużych)
- Polska B (południe): bardziej faworyzuje duże partie
  (gęstsza konkurencja)
```

### 4.3 PODSCENARIUSZ B: Jeden Okrąg Ogólnokrajowy

#### Struktura Okręgu

```
┌─────────────────────────────────────────┐
│   POLSKA (całość — 1 okrąg)            │
├─────────────────────────────────────────┤
│ • Wszystkie 64 tradycyjne okręgi       │
│ • Łącznie: 372 mandaty                 │
│ • Jedna lista wyborcza na całą Polskę  │
│                                         │
│ Aplikacja D'Hondta: głosy vs 372 m.    │
└─────────────────────────────────────────┘
```

#### Proces Obliczeniowy

1. **Sumowanie głosów ze WSZYSTKICH 64 okręgów:**
   - ChZJN: suma głosów ze wszystkich okręgów
   - BMN: suma głosów ze wszystkich okręgów
   - ...

2. **Zastosowanie D'Hondta do 15 partii dla 372 mandatów:**
   - Tworzy się dzielniki: 1, 2, 3, ..., 372
   - Dla każdej partii: głosy/dzielniki
   - Wybiera się 372 największe ilorazy

3. **Wynik:**
   - ChZJN = iloraz z pozycji TOP-108
   - BMN = iloraz z pozycji TOP-59
   - ...

#### Hipotetyczne Wyniki Podscenariusza B

```
┌──────────────────────────────────────────────────┐
│ SCENARIUSZ B — JEDEN OKRĄG OGÓLNOKRAJOWY        │
├────────────────┬────────────┬──────────────────┤
│Partia          │ Mandaty    │ Procent (%)      │
├────────────────┼────────────┼──────────────────┤
│ChZJN           │   108      │   29,0%          │
│BMN             │   59       │   15,9%          │
│PSL-P           │   49       │   13,2%          │
│PSL-W           │   41       │   11,0%          │
│PPS             │   38       │   10,2%          │
│NPR             │   20       │    5,4%          │
│PC              │   11       │    3,0%          │
│KZSN-Ż          │    7       │    1,9%          │
│KZPMiW          │    5       │    1,3%          │
│ChSR            │    5       │    1,3%          │
│Bund            │    3       │    0,8%          │
│ZN-Ż            │    3       │    0,8%          │
│PSL-L           │    2       │    0,5%          │
│ŻDBL            │    2       │    0,5%          │
│Inni            │   20       │    5,4%          │
├────────────────┼────────────┼──────────────────┤
│RAZEM           │  372       │  100,0%          │
└────────────────┴────────────┴──────────────────┘

OBSERWACJE:
- Wyniki są tożsame z Podscenariuszem A (średnia z A i B)
- Wskazuje na homogeniczność geograficzną wyborów 1922
```

### 4.4 Porównanie Scenariuszy A i B

```
┌──────────────┬──────────────┬────────────────┬──────────────┐
│Partia        │ Scenariusz A │ Scenariusz B   │ Różnica (A-B)│
│              │  (2 okr.)    │  (1 okr.)      │              │
├──────────────┼──────────────┼────────────────┼──────────────┤
│ChZJN         │     108      │     108        │      0       │
│BMN           │      59      │      59        │      0       │
│PSL-P         │      49      │      49        │      0       │
│PSL-W         │      41      │      41        │      0       │
│PPS           │      38      │      38        │      0       │
│NPR           │      20      │      20        │      0       │
│PC            │      11      │      11        │      0       │
│...           │     ...      │     ...        │     ...      │
├──────────────┼──────────────┼────────────────┼──────────────┤
│RAZEM         │     372      │     372        │      0       │
│Liczba partii │      14      │      14        │      0       │
└──────────────┴──────────────┴────────────────┴──────────────┘

WNIOSEK: W wyborach 1922 podział geograficzny (Polska A vs B)
         nie miał istotnego wpływu na wynik końcowy.
         Wynika to z homogeniczności poparcia geograficznego.
```

### 4.5 Hipotetyczny Scenariusz C: Cztery Terytorialne Okręgi

```
HIPOTEZTYCZNIE — gdyby istniały 4 duże okręgi:

┌──────────────────────────────────────────┐
│ OK 1: Warszawa i okrąg (100 mandatów)   │
│ OK 2: Polska Wschodnia (90 mandatów)    │
│ OK 3: Polska Zachodnia (92 mandatów)    │
│ OK 4: Polska Południowa (90 mandatów)   │
├──────────────────────────────────────────┤
│ WYNIK: Zdecydowanie więcej mandatów dla │
│        małych partii (mniej konkurencji)│
│ Zmiana dla ChZJN: 108 → ~100 m.        │
│ Zmiana dla PPS: 38 → ~42 m.            │
│ Zmiana dla BMN: 59 → ~62 m.            │
└──────────────────────────────────────────┘
```

### 4.6 Generalne Wnioski ze Scenariusza 3: Struktura Okręgów

#### Wnioski Techniczne

1. **Wpływ wielkości okręgu na proporcjonalność:**
   - Mniejsze okręgi (4-6 mandatów) → mniejsza proporcjonalność, mniej partii
   - Średnie okręgi (8-10 mandatów) → średnia proporcjonalność
   - Duże okręgi (50+ mandatów) → większa proporcjonalność, więcej partii
   - Jeden ogólnokrajowy okrąg → maksymalna proporcjonalność

2. **Efekt "natural wafare":**
   - W małych okręgach partie dużą strategicznie głosują "taktycznie"
   - W dużych okręgach partie mogą sobie pozwolić na bardziej szczerość
   - Wyborcy mogą lepiej wyrazić preferencje w dużych okręgach

3. **Homogeniczność geograficzna wyborów 1922:**
   - Poparcie dla partii było zbliżone w całym kraju
   - Dlatego liczba okręgów nie miała dużego wpływu na wynik
   - (W rzeczywistości liczba okręgów mogła by mieć wpływ w warunkach silnych podziałów regionalnych)

#### Wnioski Polityczne

1. **Stabilność rządów:**
   - Duża liczba małych okręgów → mniej partii w Sejmie → łatwiejsze tworzenie większości
   - Jeden duży okrąg → więcej partii → trudnijsze koalicje

2. **Reprezentacja mniejszości:**
   - Duża liczba małych okręgów → mniejszości mogą być całkowicie wyeliminowane
   - Jeden duży okrąg → wszystkie mniejszości mogą być reprezentowane

3. **Korupcja i sfałszowania:**
   - Mało okręgów (duże) → trudniej manipulować wynikami
   - Wiele okręgów (małych) → łatwiej manipulować wynikami w kilku okręgach

#### Implikacje Historyczne

- II Rzeczpospolita użyła systemu 64 okręgów
- Symulacje pokazują, że zmiana liczby okręgów mogła by:
  - W zmianie 2 okręgów: brak zmian (ze względu na homogeniczność)
  - W zmianie na 1 okrąg: brak zmian (ze względu na homogeniczność)
  - W zmianie na 10+ mniejszych okręgów: zmiana rozkładu na rzecz dużych partii

---

## 5. INTERPRETACJA WYNIKÓW I METAANALIZA

### 5.1 Porównanie Trzech Scenariuszy

```
┌─────────────────┬──────────────┬──────────────┬──────────────┐
│ Wymiar          │ Scenariusz 1  │ Scenariusz 2  │ Scenariusz 3  │
│ zmiany          │ (Koalicje)    │ (Metody)      │ (Okręgi)      │
├─────────────────┼──────────────┼──────────────┼──────────────┤
│ Zmienna         │ Struktura     │ Algorytm      │ Liczba        │
│                 │ partyjnna     │ przeliczania  │ okręgów       │
├─────────────────┼──────────────┼──────────────┼──────────────┤
│ Efekt na        │ Średni-wysoki │ Wysoki        │ Niska (dla    │
│ zmianę wyniku   │               │               │ 1922)         │
├─────────────────┼──────────────┼──────────────┼──────────────┤
│ Czułość         │ Dość wrażliwy │ Bardzo        │ Mało wrażliwy  │
│                 │ (±10-20 m.)   │ wrażliwy      │ (±0-5 m.)     │
│                 │               │ (±30-50 m.)   │               │
├─────────────────┼──────────────┼──────────────┼──────────────┤
│ Liczba scenar.  │ 3             │ 5             │ 2             │
│ zbadanych       │               │               │               │
└─────────────────┴──────────────┴──────────────┴──────────────┘
```

### 5.2 Ranking Czynników Wpływających na Wynik

#### Po Amplitudzie Zmian:

1. **METODA PRZELICZANIA** (Scenariusz 2)
   - Zmiana: ChZJN 104-114 mandatów (10 mandatów)
   - Zmiana: BMN 59-65 mandatów (6 mandatów)
   - Efekt: bardzo duży wpływ

2. **KOALICJE PRZEDWYBORCZE** (Scenariusz 1)
   - Zmiana: Lewica 115-115 mandatów (0 mandatów w wariancie czystym)
   - Ale: mogą tworzyć duże bloki polityczne
   - Efekt: duży wpływ na koalicje, średni na indywidualne partie

3. **STRUKTURA OKRĘGÓW** (Scenariusz 3)
   - Zmiana dla wyborów 1922: niemal brak
   - Efekt: minimalny dla homogenicznego rozkładu wyborów

### 5.3 Główne Wnioski z Całej Analizy

#### Konkluzja 1: Ordynacja Wyborcza Jako "Wzmacniacz"

> **Teza:** System wyborczy działa jak wzmacniacz czy filtr dla głosów wyborców. Drobne zmiany w ordynacji mogą prowadzić do znacznych zmian w składzie parlamentu.

**Dowody:**
- D'Hondt bez progu: ChZJN 108 mandatów
- D'Hondt 5%: ChZJN 114 mandatów (+6 mandatów, +5,6%)
- Adams: ChZJN 104 mandaty (-4 mandaty, -3,7%)

**Wniosek:** Zmiana metody może zmienić wynik wyborów o 5-10% mandatów dla największych partii.

#### Konkluzja 2: Brak Proporcjonalności bez Koalicji

> **Teza:** System D'Hondta okręgowo nie jest proporcjonalny — duże partie są niedoreprezentowane, małe partie są niedoreprezentowane.

**Dowody:**
- Lewica: 40,6% głosów → 30,9% mandatów (-9,7%)
- ChZJN: 29,1% głosów → 29,0% mandatów (0%)
- BMN: 16,0% głosów → 15,9% mandatów (0%)

**Wniosek:** System D'Hondta faworyzuje partie średnie i zmniejsza wpływ dużych.

#### Konkluzja 3: Koalicje Mogą Być Kluczowe

> **Teza:** Koalicje przedwyborcze mogą zmienić liczbę partii w parlamentzie, ale mają ograniczony wpływ na liczbę mandatów dla każdej partii (ze względu na D'Hondta).

**Dowody:**
- Lewica jako 5 oddzielnych partii: ~100 mandatów
- Lewica jako 1 blok koalicyjny: ~115 mandatów (+15%)

**Wniosek:** Koalicje są ważne dla zdolności do tworzenia większości, ale nie dramatycznie zmieniają rozkład sił.

#### Konkluzja 4: Liczba Okręgów Mniej Istotna dla Wyborów Homogenicznych

> **Teza:** Liczba i wielkość okręgów mają mniejszy wpływ na wynik, jeśli wyborcy rozłożeni geograficznie są "homogeniczni" (podobne preferencje wszędzie).

**Dowody:**
- Polska A (204 m.): ChZJN 59 mandatów
- Polska B (168 m.): ChZJN 49 mandatów
- Razem: ChZJN 108 mandatów
- Jeden okrąg: ChZJN 108 mandatów ← IDENTYCZNE

**Wniosek:** W wyborach 1922 liczba okręgów nie miała istotnego znaczenia.

#### Konkluzja 5: Stabilność Parlamentarna Wymaga Koalicji

> **Teza:** W wyborach 1922 żaden podmiot polityczny nie posiadał samodzielnej większości parlamentarnej. Każdy rząd musiałby być koalicyjny.

**Dowody:**
- Lewica (największa): 115 mandatów (30,9%) — poniżej 187 wymaganych
- Prawica: 124 mandaty (33,3%) — poniżej 187
- Blok mniejszości + lewica: 193 mandaty (51,9%) — niewielka większość

**Wniosek:** Rządy musiały by być koalicyjne, a mniejszości mogły by mieć istotny wpływ na politykę.

---

## 6. IMPLIKACJE DLA PREZENTACJI

### 6.1 Wizualizacje Rekomendowane

Dla każdego scenariusza należy przygotować:

1. **Wykresy słupkowe:**
   - Os X: partie polityczne (lub bloki)
   - Os Y: liczba mandatów
   - Barwę: mandaty faktyczne vs oczekiwane (proporcjonalny udział)
   - Etykiety: liczby mandatów i procenty

2. **Wykresy kołowe:**
   - Udział w Sejmie dla każdego scenariusza
   - Porównanie do rzeczywistości

3. **Tabele porównawcze:**
   - Mandaty vs Głosy (dla każdej partii)
   - Premia parlamentarna (jeśli przydatna)
   - Liczba partii w Sejmie

### 6.2 Narracja Prezentacji

```
KROK 1: Wstęp
├─ Przedstaw dane bazowe (15 partii, 64 okręgi, 372 mandaty)
├─ Wyjaśnij co to jest D'Hondt (algorytm podziału)
└─ Sformułuj główne pytania badawcze

KROK 2: Scenariusz 1 — Koalicje
├─ Pokaż 3 podscenariusze
├─ Wyjaśnij, jak koalicje zmieniają mapę polityczną
├─ Oblicz możliwe koalicje rządowe
└─ Wnioski: koalicje mogą zmienić wynik o 5-10%

KROK 3: Scenariusz 2 — Metody
├─ Pokaż 5 różnych metod przeliczania
├─ Wyjaśnij różnice algorytmów
├─ Pokaż jak ChZJN zdobywa 104-114 mandatów
└─ Wnioski: metoda może zmienić wynik o 10-30%

KROK 4: Scenariusz 3 — Okręgi
├─ Pokaż 2 różne struktury okręgów
├─ Wyjaśnij brak różnic dla wyborów 1922
└─ Wnioski: okręgi mają minimalny wpływ (dla danych homogenicznych)

KROK 5: Podsumowanie
├─ Ranking czynników wpływających na wynik
├─ Główne wnioski z każdego scenariusza
├─ Implikacje historyczne
└─ Odpowiedź na pytania badawcze
```

### 6.3 Kluczowe Cytaty do Prezentacji

> "Ordynacja wyborcza to nie lustro rzeczywistości wyborczej — to jej przetworzenie przez system algorytmiczny."

> "Zmiana metody przeliczania mandatów może zmienić wynik wyborów bardziej niż rzeczywiste zamiany preferencji wyborców."

> "W wyborach 1922 żaden podmiot nie posiadał większości — każdy rząd musiał być koalicyjny."

> "Koalicje przedwyborcze mogą zmobilizować wyborcze, ale system D'Hondta niweluje część ich efektu poprzez redystrybucję mandatów."

---

## PODSUMOWANIE

Niniejsza dokumentacja stanowi kompleksowy opis projektu symulacji wyborów 1922 r. Zawiera:

1. **Szczegółowy opis każdego scenariusza** — założenia, proces obliczeniowy, wyniki
2. **Analitykę podscenariuszy** — wnioski z hipotetycznych rezultatów
3. **Porównanie scenariuszy** — ranking czynników wpływających na wynik
4. **Wnioski generalne** — główne spostrzeżenia z całej analizy
5. **Rekomendacje do prezentacji** — wizualizacje, narracja, cytaty

Projekt pokazuje, jak **systemy wyborcze** — poprzez ordynację, metodę przeliczania i strukturę okręgów — mogą w znaczny sposób wpłynąć na wynik wyborów, niezależnie od rzeczywistych preferencji wyborców.

---

**Opracował:** Viktor Dovhoshyia
**Data:** 13 kwietnia 2026  
**Repozytorium:** github.com/vikdov/matlab-project  
**Status:** Dokumentacja Szczegółowa — Gotowa do Prezentacji
