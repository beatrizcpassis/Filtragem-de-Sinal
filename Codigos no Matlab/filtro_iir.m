%Beatriz Cristina Pereira de Assis
%Projeto PDS - FUNÇÃO FILTRO IIR

function y= filtro_iir(a,b,x)

  M = length(x);                       %tamanho do vetor do sinal de entrada
  N = length(a);                              %tamanho do filtro IIR (Ordem) 
  T = length(b);                 %tamanho do vetor do sinal de realimentacao
  
  y = zeros(1,M);              %gera vetor para armazenar a saida do sistema 
  aux = zeros(N,1);      %gera vetor com os coeficientes da eq. dif. entrada
  aux1 = zeros(T-1,1);     %gera vetor com os coeficientes da eq. dif. saída
  
for i = 1:M
    aux = circshift(aux,1);   % desloca circularmente os valores de aux em 1
    aux(1) = x(i);     %atualiza a 1 posição de aux com a amostra atual de x  
    
    y(i) = ((a*aux)-(b(2:T)*aux1));                        %saida do sistema
    
    aux1 = circshift(aux1,1); %desloca circularmente os valores de aux1 em 1
    aux1(1) = y(i);   %atualiza a 1 posição de aux1 com a amostra atual de y
end
end

