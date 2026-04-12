function [w,i] = hondt(p,s)
%hondt(p,s) podzial metoda d'Hondta s mandatow pomiedzy uczestnikow o
%   roszczeniach p, gdzie s-liczba naturalna, p nieujemny wektor.
%   hondt([5 3 1],6)-> 4 2 0 rozdziela 6 mandatow trzem podmiotom o
%   roszczeniach odpowiednio 5, 3 oraz 1
%   [a,b]=hondt([8 5 3 1],12) -> podzial a=[6 4 2 0], iteracji b=11
c=.1;c1=2.5;c2=c;
kw=p*s/sum(p);
% parametr c liczony jest metoda kolejnych przyblizen
for i=1:200
    w=floor(c*kw);
    n=sum(w);
    if n<s 
        c2=c; c=(c1+c)/2;
    elseif n>s 
        c1=(c1+c)/2;c=c2;
    else
        return;
    end
end
end

