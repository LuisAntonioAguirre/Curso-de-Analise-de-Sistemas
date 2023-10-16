% Modulacao e demodulacao AM
% Video associado: https://youtu.be/_YISfjXBpSs

% LAA 28/11/17

close all
clear

%%
% gera um sinal "informacao" hipotetico

% frequencia natural (geraremos um sinal "periodico")
w0=1;

% vetor de tempo correspondente a 4 periodos da fundamental
t=0:pi/100:8*pi/w0-pi/100;
L=length(t);

% sinal de informacao
x=cos(w0*t)+0.5*sin(2*w0*t)+0.1*cos(3*w0*t);
% para o caso de incluir um off-set
% x=x+1.5;

% fft do sinal
X=fft(x);

% frequencia de amostragem em Hz (inverso do intervalo de amostragem)
Fs=100/pi;
P2 = abs(X/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
w=2*pi*f;


% grafico do sinal
figure(1)
subplot(211)
set(gca,'FontSize',18)
plot(t,x,'b');
axis([0 t(end) -3 3])
xlabel('t')
ylabel('x(t)');

subplot(212)
set(gca,'FontSize',18)
plot(w,log10(P1),'b')
axis([0 8*pi -20 0])
xlabel('w(rad/s)')
ylabel('log|X(jw)|')


%%
% portadora em 10 rad/s
c=cos(10*t);

% sinal modulado
y=x.*c;

% fft do sinal modulado
Y=fft(y);

% frequencia de amostragem em Hz (inverso do intervalo de amostragem)
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);



% grafico do sinal modulado
figure(2)
subplot(211)
set(gca,'FontSize',18)
plot(t,x,'b--',t,y,'k');
axis([0 t(end) -3 3])
xlabel('t')
ylabel('y(t)');

subplot(212)
set(gca,'FontSize',18)
plot(w,log10(P1),'k')
axis([0 8*pi -20 0])
xlabel('w(rad/s)')
ylabel('log|Y(jw)|')

%%

%%
% demodulacao
w=cos(10*t);

% modulacao do sinal modulado
z=y.*w;

% fft do sinal modulado
Z=fft(z);

% frequencia de amostragem em Hz (inverso do intervalo de amostragem)
P2 = abs(Z/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);


% grafico do sinal modulado duplamente
figure(3)
subplot(211)
set(gca,'FontSize',18)
plot(t,z,'r');
axis([0 t(end) -2 2])
xlabel('t')
ylabel('z(t)');

subplot(212)
set(gca,'FontSize',18)
plot(w,log10(P1),'r')
axis([0 8*pi -20 0])
xlabel('w(rad/s)')
ylabel('log|Z(jw)|')

%%
% "filtro" (um bom filtro eh projetado de outra forma)
% frequencia de corte
wc=15;
% ordem do filtro
n=10;
den=1;
for k=1:n
    den=conv(den,[1 wc]);
end
filtro=tf(den(end),den);
figure(4)
[mag,phase]=bode(filtro,w);

% grafico do sinal modulado duplamente
figure(3)
subplot(211)
set(gca,'FontSize',18)
plot(t,z,'r');
axis([0 t(end) -2 2])
xlabel('t')
ylabel('z(t)');

subplot(212)
set(gca,'FontSize',18)
plot(w,log10(P1),'r',w,20*log10(squeeze(mag)),'k')
axis([0 8*pi -20 1])
xlabel('w(rad/s)')
ylabel('log|Z(jw)|')

% filtrar o sinal modulado duplamente
zd=lsim(filtro,z,t);

figure(4)
set(gca,'FontSize',18)
plot(t,x,'k',t,zd*max(x)/max(zd),'m');
axis([0 t(end) -2 2])
xlabel('t')
ylabel('x(t), zd(t)');

%%


