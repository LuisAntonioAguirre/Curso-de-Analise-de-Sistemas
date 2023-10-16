% tracado de diagramas de Bode para sistema com dois polos complexos conjugados
% video correspondente: https://youtu.be/5Wx7M9UbSeY 

% LAA 31/10/17

clear
close all

%%

w=logspace(-2,2,200);
% frequencia natural
wn=1;
% quociente de amortecimento (varios valores)
zeta=0.1:0.2:0.9;

mod=zeros(length(zeta),length(w));
ang=zeros(length(zeta),length(w));

j=sqrt(-1);
for k=1:length(zeta)
    den=(j.*w/wn).^2+2*zeta(k).*(j*w/wn)+1;
    mod(k,:)=20*log10(abs(1./den));
    ang(k,:)=phase(1./den);
end

figure(3)
subplot(211)
set(gca,'FontSize',18)
semilogx(w,mod)
xlabel('\omega/\omega_n')
ylabel('|H(j\omega)| (dB)')
grid
subplot(212)
set(gca,'FontSize',18)
semilogx(w,ang)
xlabel('\omega/\omega_n')
ylabel('fase [H(j\omega)]')
axis([w(1) w(end) -1.2*pi 0.2])
grid


