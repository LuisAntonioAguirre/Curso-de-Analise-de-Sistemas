% produz eixos para tracado do diagrama de Bode
% video relacionado: https://youtu.be/e1FrLUKkVBE

% LAA 7/11/17

close all

w=logspace(-1,1);
x=zeros(size(w));


figure(1)
set(gca,'FontSize',18)
semilogx(w,x,'w.');
grid
xlabel('\omega')
ylabel('|H(j\omega)| (dB)')
axis([0.1 10 -40 40])


% print -dpng eixosBode_mod.png


figure(2)
set(gca,'FontSize',18)
semilogx(w,x,'w.');
grid
xlabel('\omega')
ylabel('fase[H(j\omega)] (graus)')
axis([0.1 10 -280 100])


% print -dpng eixosBode_fas.png

%%
% polinomio do numerador
num=10*[1 3];

% produto: (s+2)(s^2 +s+2)
den=conv([1 2],[1 1 2]);

% coloca um polo na origem do plano s
den=[den 0];

% constroi a funcao de transferencia e chama-a de H
H=tf(num,den);

% traca o diagrama de Bode
bode(H)
grid

% print -dpng Bode_exemplo.png
