function rownania = model_de_Pillis_chemiotherapy(t, x)

T = x(1);
N = x(2);
L = x(3);
C = x(4);
M = x(5);
I = x(6);
Ialfa = x(7);
liczba_dni_w_cyklu = x(8);
pacjent = x(9);

V_M = 0;
V_L = 0;
V_I = 0;

% ustawienie parametr�w
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
mi_I = 1e1;
p_I = 1.25e-1;
g_I = 2e7;

switch pacjent
    case 9
        d = 2.34;
        l = 2.09;
        k = 3.66e7;
        m = 2.04e-1;
        q = 1.42e-6;
        p = 3.42e-6;
        s = 8.39e-2;
        alfa = 7.5e8;
        beta = 1.2e-2;
    case 10
        d = 1.88;
        l = 1.81;
        k = 5.66e7;
        m = 9.12;
        q = 1.59e-6;
        p = 3.59e-6;
        s = 5.12e-1;
        alfa = 5e8;
        beta = 8e-3;
end

% parametry do chemioterapii
K_T = 9e-1;
K_N = 6e-1;
K_L = 6e-1;
K_C = 6e-1;

% funkcja st�enia cytostatyku
    if(t >= 0 && t <= 1 || t >= liczba_dni_w_cyklu && t <= liczba_dni_w_cyklu+1 ...
            || t >= 2*liczba_dni_w_cyklu && t <= (2*liczba_dni_w_cyklu)+1 ...
            || t >= 3*liczba_dni_w_cyklu && t <= (3*liczba_dni_w_cyklu)+1 ...
            || t >= 4*liczba_dni_w_cyklu && t <= (4*liczba_dni_w_cyklu)+1 ...
            || t >= 5*liczba_dni_w_cyklu && t <= (5*liczba_dni_w_cyklu)+1 ...
            || t >= 6*liczba_dni_w_cyklu && t <= (6*liczba_dni_w_cyklu)+1 ...
            || t >= 7*liczba_dni_w_cyklu && t <= (7*liczba_dni_w_cyklu)+1 ...
            || t >= 8*liczba_dni_w_cyklu && t <= (8*liczba_dni_w_cyklu)+1)
        V_M = 5;
    end

D = licz_D(d, L, T, s, l);

% r�wnania modelu
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
dIalfadt = Ialfa;

rownania = [dTdt; dNdt; dLdt; dCdt; dMdt; dIdt; dIalfadt; 0; 0];
end

