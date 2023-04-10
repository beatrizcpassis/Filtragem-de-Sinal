%Beatriz Cristina Pereira de Assis
%Projeto PDS - FUNÇÃO FILTRO FIR

function y= filtro_fir(b,x)

M= length(x);                      %tamanho do vetor do sinal de entrada
N= length(b);                             %tamanho do filtro FIR (Ordem)   
y= zeros(1,M);          % gera o vetor para armazenar a saida do sistema 
aux= zeros(1,N);       %gera vetor auxiliar para fazer a eq de diferenca
for i= 1:M
    aux= circshift(aux,1); %desloca circularmente os valores de aux em 1
    aux(1)=x(i);   %atualiza a 1 posição de aux com a amostra atual de x 
    y(i)= b*aux';                                      %Saida do sistema
end
end 
