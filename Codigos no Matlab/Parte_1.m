%Beatriz Cristina Pereira de Assis
%Projeto PDS - Filtragem de �udio com filtros IIR

%Analise no dominio do tempo
[x,fa] = audioread('fala_sirene_tm1.wav'); %leitura do audio
subplot(2,1,1);                  %define a escala do gr�fico
plot(x(1:400));             %plota as 400 primeiras amostras
title('Sinal no dominio do Tempo');       %Titulo do gr�fico
xlabel('Tempo');                           %Titulo do eixo x
ylabel('Magnitude');                       %Titulo do eixo y
figure;

%An�lise espectral da frequencia    
X = fft(x);                        %Faz a transformada de fourier
N = length(X);                       %Pega a quantidade de pontos
X = X/(N/2);                                        %Normalizacao
f = [0: N-1]*fa/(N-1); %Vetor que contem as frequencias de f a fa
subplot(2,1,1);                       %define a escala do gr�fico
plot(f(1:N/2),abs(X(1:N/2)));           %Plota f sem espelhamento
title('Espectro de Frequencia do Sinal');      %Titulo do gr�fico
xlabel('Frequencia');                           %Titulo do eixo x
ylabel('Magnitude');                            %Titulo do eixo y

%............................PRIMEIRA PARTE...............................

%Primeira Filtragem - Notch
wc = 2*pi*300;                  %Frequ�ncia de corte do filtro Notch
r =0.99;                                       %Raio do filtro Notch
a =[1 -2*cos(wc/fa) 1];                   %Numerador do filtro Notch
b =[1 -2*r*cos(wc/fa) r^2];             %Denominador do filtro Notch
[H,W] = freqz(a,b,512,fa);   %Resposta em frequ�ncia do filtro Notch
hold on                                   %Mant�m o gr�fico anterior
plot(W,abs(H),'r');  %plota a resposta em frequencia do filtro Notch
                                    
y = filtro_iir(a,b,x); % Aplicando o filtro Notch ao sinal original
Y = fft(y);                 %Calcula a transformada de Fourier de y
subplot(2,1,2);               %define a escala e posi�ao do gr�fico
plot(f(1:N/2),abs(Y(1:N/2)))    %plota o espectro do �udio filtrado

%Segunda Filtragem - Chebyshev Tipo I
wn = 800/(fa/2);                           %Frequencia de corte          
[t,u]= cheby1(10,1,wn);                       %Filtro Chebyshev
[h,w] = freqz(t,u,512,fa);    %Resposta em frequ�ncia do filtro 
hold on;                             %Mant�m o gr�fico anterior
plot(w, 2000*abs(h)); %plota a resposta em frequencia do filtro   
title('Espectro de Frequencia do Sinal');    %Titulo do gr�fico
xlabel('Frequencia');                         %Titulo do eixo x
ylabel('Magnitude');                          %Titulo do eixo y

figure;                                                      %Novo grafico
p = filtro_iir(t,u,y);               %implementa��o da fun��o desenvolvida
P = fft(p);                        %Calcula a transformada de Fourier de P
subplot(2,1,1);                      %define a escala e posi�ao do gr�fico
plot(f(1:N/2),abs(P(1:N/2)))           %plota o espectro do �udio filtrado
title('Espectro de Frequencia do Sinal');               %Titulo do gr�fico
xlabel('Frequencia');                                    %Titulo do eixo x
ylabel('Magnitude');                                     %Titulo do eixo y
sound(p,fa)                                     %Reproduz o �udio filtrado 
audiowrite('C:\Users\Windows\Downloads\PDS\audio_filtrado_1.wav',p,fa); 
%Grava o �udio filtrado

%Resposta ao impulso do Filtro Notch
figure;                                        %Novo grafico
[h1,w1] = impz(a,b);                 %coeficientes do filtro
subplot(2,1,1);        %define a escala e posi�ao do gr�fico
plot(w1,abs(h1), 'r');          %plota a resposta ao impulso
title('Resposta ao Impulso - Notch');     %Titulo do gr�fico
xlabel('Tempo');                           %Titulo do eixo x
ylabel('Magnitude');                       %Titulo do eixo y

%Resposta ao impulso do Filtro Chebyshev
[h2,w2] = impz(t,u);                 %coeficientes do filtro
subplot(2,1,2);        %define a escala e posi�ao do gr�fico
plot(w2,abs(h2),'r');           %plota a resposta ao impulso
title('Resposta ao Impulso - Chebyshev'); %Titulo do gr�fico
xlabel('Tempo');                           %Titulo do eixo x
ylabel('Magnitude');                       %Titulo do eixo y
