function mandaty = hamilton(glosy, liczba_mandatow)
% HAMILTON  Metoda Hamiltona (największych reszt / metoda Hare'a)
% glosy           - wektor liczby głosów dla każdej partii
% liczba_mandatow - liczba mandatów do podziału

% Suma wszystkich głosów
suma = sum(glosy);

% Obliczamy kwotę Hare’a (ile głosów przypada na 1 mandat)
kwota = suma / liczba_mandatow;

% Obliczamy "udziały mandatowe" (ile mandatów powinna mieć partia idealnie)
udzialy = glosy / kwota;

% Bierzemy część całkowitą (to są mandaty przydzielone na pewno)
mandaty_bazowe = floor(udzialy);

% Reszty (czyli "niedobór" do kolejnego mandatu)
reszty = udzialy - mandaty_bazowe;

% Liczba mandatów już przydzielonych
przydzielone = sum(mandaty_bazowe);

% Ile mandatów jeszcze zostało do rozdania
pozostale = liczba_mandatow - przydzielone;

% Sortujemy partie według reszt (malejąco)
% order = indeksy partii od największej reszty
[~, order] = sort(reszty, 'descend');

% Na start mandaty = mandaty bazowe
mandaty = mandaty_bazowe;

% Przydzielamy pozostałe mandaty partiom z największymi resztami
for k = 1:pozostale
    mandaty(order(k)) = mandaty(order(k)) + 1;
end

end
