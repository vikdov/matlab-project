function mandaty = hamilton(glosy, liczba_mandatow)
% HAMILTON  Metoda Hamiltona (największych reszt / metoda Hare'a)
%   Kwota Hare'a = suma_głosów / liczba_mandatów
%   glosy           - wektor głosów na partie
%   liczba_mandatow - liczba mandatów do podziału

suma = sum(glosy);
kwota = suma / liczba_mandatow;

udzialy = glosy / kwota;
mandaty_bazowe = floor(udzialy);
reszty = udzialy - mandaty_bazowe;

przydzielone = sum(mandaty_bazowe);
pozostale = liczba_mandatow - przydzielone;

% Przydziel pozostałe mandaty partiom z największymi resztami
[~, order] = sort(reszty, 'descend');
mandaty = mandaty_bazowe;
for k = 1:pozostale
    mandaty(order(k)) = mandaty(order(k)) + 1;
end
end
