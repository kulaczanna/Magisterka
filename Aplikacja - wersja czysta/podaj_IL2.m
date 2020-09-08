function V_I = podaj_IL2(t, t1, dawkowanie, przerwa) % dawkowanie - czas podawania IL-2
 % przerwa - czas pomiêdzy kolejnymi dawkami IL-2

    if(t >= t1 && t <= (t1 + dawkowanie) ... % pierwsza dawka IL-2
        || t >= (t1 + dawkowanie + przerwa) && t <= (t1 + (2 * dawkowanie) + przerwa)... % druga dawka
        || t >= (t1 + (2 * dawkowanie) + (2 * przerwa)) && t <= (t1 + (3 * dawkowanie) + (2 * przerwa)) ... % trzecia dawka
        || t >= (t1 + (3 * dawkowanie) + (3 * przerwa)) && t <= (t1 + (4 * dawkowanie) + (3 * przerwa)) ... % czwarta dawka
        || t >= (t1 + (4 * dawkowanie) + (4 * przerwa)) && t <= (t1 + (5 * dawkowanie) + (4 * przerwa)) ... % pi¹ta dawka
        || t >= (t1 + (5 * dawkowanie) + (5 * przerwa)) && t <= (t1 + (6 * dawkowanie) + (5 * przerwa))) % szósta dawka
    
        V_I = 5e6; % dawka IL-2
        
    else
        
        V_I = 0; % dawka IL-2
    
    end
   
 end
