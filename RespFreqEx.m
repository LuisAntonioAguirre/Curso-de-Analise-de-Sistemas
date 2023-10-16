% Simulacoes relativas aa resposta em frequencia de sistemas em tempo
% continue e discreto.
% Video relacionado: https://youtu.be/jYc05vXIRYo

% LAA 14/10/2017

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

% grafico dos ultimos instantes (regime permanente)
figure(2)
set(gca,'FontSize',18)
plot(t(1700:2001),x(1700:2001),'b',t(1700:2001),y(1700:2001),'r')
grid
ylabel('x(t) e y(t)')
xlabel('t (s)')
axis([17 20 -1.2 1.2])

% determinacao "manual" do ganho em estado estacionario: o maximo da saida
% sobre o maximo da entrada, que eh um.
disp('ganho na frequencia w0')
K=max(y(1700:2001))

% encontrar o defsamento como a "distancia temporal" dos picos
picoX=find(x(1800:2001)==max(x(1800:2001)));
picoY=find(y(1800:2001)==max(y(1800:2001)));
dif=(picoX-picoY)*0.01;

% o periodo eh
T=2*pi/w0;
% portanto a fase eh em radianos. O sinal negativo indica que o sinal de
% saida esta *atrasado* em relacao aa entrada.
disp('fase em radianos')
fase=2*pi*dif/T

% determinacao do ganho e fase diretamente da resposta em frequencia:
j=sqrt(-1);

disp('ganho na frequencia w0')
KH=abs(1/(j*w0+1))
disp('fase em radianos na frequencia w0')
faseH=phase(1/(j*w0+1))

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

% grafico dos ultimos instantes (regime permanente)
figure(3)
set(gca,'FontSize',18)
stem(k(970:1000),x(970:1000),'b');
hold on
stem(k(970:1000),y(970:1000),'r')
hold off
grid
ylabel('x(n) e y(n)')
xlabel('n')
axis([970 1000 -5.2 5.2])

% determinacao "manual" do ganho em estado estacionario: o maximo da saida
% sobre o maximo da entrada, que eh um.
disp('ganho na frequencia w0')
Kd=max(y(970:990))

% encontrar o defsamento como a "distancia" em amostras dos picos
picoXd=find(x(970:990)==max(x(970:990)));
picoYd=find(y(970:990)==max(y(970:990)));
difd=(picoXd-picoYd);

% o periodo eh
N=2*pi/w0;
% O sinal negativo indica que o sinal de
% saida esta *atrasado* em relacao aa entrada.
disp('fase')
fase=2*pi*difd/N

% determinacao do ganho e fase diretamente da resposta em frequencia:
j=sqrt(-1);

disp('ganho na frequencia w0')
KHd=abs(2/(1-(3/4)*exp(-j*w0)+(1/8)*exp(-j*2*w0)))
disp('fase em radianos na frequencia w0')
faseHd=phase(2/(1-(3/4)*exp(-j*w0)+(1/8)*exp(-j*2*w0)))
