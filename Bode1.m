% tracado de diagramas de Bode para sistema com um polo
% video correspondente: https://youtu.be/5SJ-bj758P0


% LAA 31/10/17

clear
close all

%%

w=logspace(-2,2,100);
tau=1;

j=sqrt(-1);
%for k=1:length(w)
    mod=20*log10(abs(1./(j.*w*tau+1)));
    ang=phase(1./(j.*w*tau+1));
%end

figure(1)
semilogx(w,ang)
set(gca,'FontSize',18)
grid
xlabel('\omega/\tau')
ylabel('fase [H(j\omega)]')
axis([w(1) w(end) -1.2*pi/2 0.2*pi/2])

% 

figure(2)
subplot(211)
set(gca,'FontSize',18)
semilogx(w,mod)
xlabel('\omega/\tau')
ylabel('|H(j\omega)| (dB)')
axis([w(1) w(end) -42 5])
grid
subplot(212)
set(gca,'FontSize',18)
semilogx(w,ang)
xlabel('\omega/\tau')
ylabel('fase [H(j\omega)]')
axis([w(1) w(end) -1.2*pi/2 0.2*pi/2])
grid

