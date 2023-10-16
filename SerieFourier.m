% Introducao aa Serie de Fourier
% video relacionado: https://youtu.be/x-if6ctPCI8

% LAA 29/8/17

close all
clear

% definicoes 

% entre a frequencia fundamental em rad/s
w0=input('Entre a frequencia fundamental em rad/s: ');

% entre o numero de componentes harmonicos
n=input('Entre o numero de componentes harmonicos: ');

% define vetores de modulo e fase
m=zeros(n,1);
teta=zeros(n,1);

disp(' ');
disp('Para cada componente entre o modulo e a fase (entre 0 e 2pi).');
disp('A primeira componente eh a fundamental (escolha-a diferente de zero),');
disp('a segunda componente eh a 2a harmonica etc.') 
disp(' ');

for k=1:n
    fprintf('Componente: %d  ',k);
    m(k)=input('Modulo: ');
    teta(k)=input('Fase (entre 0 e 2pi): ');
end

% periodo fundamental
T0=2*pi/w0;
% vetor de tempo. Escolhemos ter 20 valores por periodo da harmonica mais
% rapida e simular 5 periodos.
t=0:T0/(20*n):5*T0;

% define o vetor do sinal
x=zeros(1,length(t));

% compoe o sinal total adicionando as componentes harmonicas
for k=1:n
    x=x+m(k)*cos(k*w0*t+teta(k));
end

figure(1)
set(gca,'FontSize',18)
plot(t, x,'b')
xlabel('t')
ylabel('x(t)') 
axis([0 t(end) min(x)*1.1 max(x)*1.1]);


