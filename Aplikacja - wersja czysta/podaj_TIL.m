function V_L = podaj_TIL(t, t1, t2) % t1 / t2 - czas rozpoczêcia / zakoñczenia podawania TIL

    if(t >= t1 && t < t2)
        
        V_L = 1e9; % dawka TIL
    
    else
        
        V_L = 0;
    
    end
   
 end
