clc; clear all
close all
format long

metoda_leczenia = 4;

pacjent = 1; % 1 lub 2

% pocz�tkowe st�enie lek�w
M_0 = 0; % st�enie cytostatyka M(t)
liczba_dni_w_cyklu = 0; % co ile dni wyst�puje dodzowanie cytostatyka w CHEMIOTERAPII, przerwa
dni_dawkowania = 0; % czas dozowania cytostatyka w CHEMIOTERAPII, dozowanie
I_0 = 0; % st�enie IL-2 I(t)
        
switch metoda_leczenia
    case 1 % brak leczenia
        T_0 = 1.8e7; % pocz�tkowa liczba kom�rek nowotworowych T(t)
        N_0 = 1e5; % pocz�tkowa liczba kom�rek NK N(t)
        L_0 = 1e2; % pocz�tkowa liczba limfocyt�w CD8+T L(t)
        C_0 = 6e10; % pocz�tkowa liczba limfocyt�w kr���cych C(t)
     
    case 2 % chemioterapia
        T_0 = 1.8e7;
        N_0 = 1e5;
        L_0 = 1e2;
        C_0 = 3.5e9;
        liczba_dni_w_cyklu = 4; % zmiany schematu
        dni_dawkowania = 1;     % chemioterapii
        
    case 3 % immunoterapia
        T_0 = 1e6;
        N_0 = 1e5;
        L_0 = 1e2;
        C_0 = 3.5e9;
       
    case 4 % biochemioterapia
        T_0 = 1.8e7;
        N_0 = 1e5;
        L_0 = 1e2;
        C_0 = 3.5e9;
        liczba_dni_w_cyklu = 8; % zmiany schematu
        dni_dawkowania = 1;     % chemioterapii
end

x = [T_0; N_0; L_0; C_0; M_0; I_0; liczba_dni_w_cyklu; metoda_leczenia; pacjent; dni_dawkowania]; % parametry wej�ciowe uk�adu r�wna�
t = 0 : 1/24 : 120; % czas symulacji
[t,y] = ode45(@model_de_Pillis, t, x); % rozwi�zanie uk�adu r�wna� r�niczkowych

wyswietl_wykresy(t, y); % graficzne przedstawienie wynik�w

for n = 1 : 2881 % wyznaczenie dnia regresji nowotworu (spadek liczby kom�rek nowotworowych do 1)
    if(y(n,1) < 1) 
    disp('dzie� regresji:')
    disp(t(n))
    break
    end
end
