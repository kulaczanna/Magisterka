function rownania = model_de_Pillis(t, x)

%% warto�ci pocz�tkowe
T = x(1); % kom�rki nowotworowe
N = x(2); % kom�rki NK
L = x(3); % limfocyty CD8+
C = x(4); % limfocyty kr���ce
M = x(5); % cytostatyk
I = x(6); % IL-2

liczba_dni_w_cyklu = x(7); % liczba dni cyklu chemioterapii
metoda_leczenia = x(8);
pacjent = x(9);
dni_dawkowania = x(10); % czas dozowania cytostatyka

%% warto�ci parametr�w 
% parametry reprezentuj�ce kondycj� uk�adu immunologicznego pacjent�w
a = 4.31e-1;
b = 1.02e-9;
c = 6.41e-11;
e = 2.08e-7;
f = 4.12e-2;
g = 1.25e-2;
h = 2.02e7;
jj = 2.49e-2;
r1 = 1.1e-7;
r2 = 6.5e-11;
u = 3e-10;

gamma = 9e-1;

p_I = 9e3;
g_I = 2e7;
mi_I = 1e1;

    switch pacjent
        case 1
            d = 2.34;
            l = 2.09;
            k = 3.66e7;
            m = 2.04e-1;
            q = 1.42e-6;
            p = 3.42e-6;
            s = 8.39e-2;

            alfa = 7.5e8;
            beta = 1.2e-2;

        case 2
            d = 1.88;
            l = 1.81;
            k = 5.66e7;
            m = 9.12;
            q = 1.59e-6;
            p = 3.59e-6;
            s = 5.12e-1;

            alfa = 5e8;
            beta = 8e-3;
            
            case 11
            d = 2.11;
            l = 1.95;
            k = 4.66e7;
            m = 4.662;
            q = 1.505e-6;
            p = 3.51e-6;
            s = 2.98e-1;

            alfa = 6.25e8;
            beta = 1e-2;
    end

%% leczenie

V_L = 0; % TIL
V_M = 0; % cytostatyk
V_I = 0; % IL-2

%% chemioterapia
% parametry
K_T = 9e-1;
K_N = 6e-1;
K_L = 6e-1;
K_C = 6e-1;

% podanie cytostatyku
    if(metoda_leczenia == 2 || metoda_leczenia == 4) % 2 - chemioterapia, 4 -biochemioterapia
        
        V_M = podaj_cytostatyk(t, liczba_dni_w_cyklu, dni_dawkowania); % t - moment podczas symulacji
                                        % liczba_dni_w_cyklu - d�ugo�� cyklu chemioterapii
    end                                 % dni_dawkowania - czas dozowania cytostatyka                                                                                                                    
    
% podanie TIL
    if(metoda_leczenia == 3 || metoda_leczenia == 4) % 2 - immunoterapia, 4 -biochemioterapia
      
        V_L = podaj_TIL(t, 7, 8); % t - moment podczas symulacji, 
                                  % 7 / 8 - czas rozpocz�cia / zako�czenia
                                  % podawania TIL (tj. dozowanie �smego
                                  % dnia) 
                                  % schemat cyklu TIL [1 0]
% podanie IL-2
       
        V_I = podaj_IL2(t, 8, 0.3, 0.2); % t - moment podczas symulacji, 
                                  % 8 - czas rozpocz�cia podawania IL-2
                                  % (tj. rozpocz�cie dziewi�tego dnia)
    end                           % 0.3 - dozowanie IL-2 0.2 - przerwa
                                  % schemat cklu IL-2 [0,3 0,2]
    D = licz_D(d, L, T, s, l);

%% r�wnania modelu
dTdt = (a * T *(1 - (b * T))) - (c * N * T) - ...
    (D * T) - (K_T * (1 - (exp(-M))) * T);
dNdt = (e * C) - (f * N) + (g * ((T^2) / (h + (T^2))) * N) - ...
    (p * N * T) - (K_N * (1 - (exp(-M))) * N);
dLdt = ((-m) * L) + (jj * ((D^2 * T^2) / ...
    (k + (D^2 * T^2))) * L) - (q * L * T) + ...
    (((r1 * N) + (r2 * C)) * T) - (u * N * (L^2)) - ...
    (K_L * (1 - (exp(-M))) * L) + ((p_I * L * I) / (g_I + I)) + V_L;
dCdt = alfa - (beta * C) - (K_C * (1 - (exp(-M))) * C);
dMdt = (-gamma * M) + V_M;
dIdt = (-mi_I * I) + V_I;

rownania = [dTdt; dNdt; dLdt; dCdt; dMdt; dIdt; 0; 0; 0; 0];
end

