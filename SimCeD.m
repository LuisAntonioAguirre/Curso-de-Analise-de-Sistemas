% Simulacoes relativas aa resposta em frequencia de sistemas em tempo
% continue e discreto.
% Video relacionado: https://youtu.be/TjfVxaIC6sY

% LAA 17/10/2017

clear
close all

%% o caso em tempo continuo

% o sistema com resposta ao impulso h(t)=exp(-t)u(t) serah definido como
num=1;
den=[1 1];
sys=tf(num,den);
[h,t]=impulse(sys);

% verificacao
figure(1)
set(gca,'FontSize',18)
plot(t,h)
ylabel('h(t)')
xlabel('t (s)')

%%
% entrada senoidal
t=0:0.01:20;
w0=3;
x=cos(w0*t);

% simulacao para entrada senoidal
y=lsim(sys,x,t);

% grafico dos primeiros instantes (regime transitorio)
figure(2)
set(gca,'FontSize',18)
plot(t(1:500),x(1:500),'b',t(1:500),y(1:500),'r')
grid
ylabel('x(t) e y(t)')
xlabel('t (s)')
axis([0 5 -1.2 1.2])

%% o caso em tempo discreto

% entrada senoidal
k=1:1000;
w0=pi/10;
x=cos(w0*k);

% simulacao do sistema para entrada senoidal
% condicoes iniciais nulas
y(1)=0;
y(2)=0;
for n=3:length(k)
  y(n)=(3/4)*y(n-1)-(1/8)*y(n-2)+2*x(n);
end;

% grafico dos primeiros instantes (regime transitorio)
figure(3)
set(gca,'FontSize',18)
stem(k(1:50),x(1:50),'b');
hold on
stem(k(1:50),y(1:50),'r')
hold off
grid
ylabel('x[n] e y[n]')
xlabel('n')
axis([1 50 -5.2 5.2])

