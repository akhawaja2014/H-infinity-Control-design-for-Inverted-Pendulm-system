close all
M=1.0;
m=0.25;
l=0.5;
b1 = 0.05;
g = 9.81;
% I = (1/3)*m*l*l;
% q = (I+(m*(l^2)))*(M+m)-(m*l)^2;
%% State Space

A = [0 0 1 0;....
     0 0 0 1;...
     0 -(m*g/M) -b1/M 0;...
     0 (2*(M + m)*g)/(M*l) 2*b1/(M*l) 0];

B = [0; 0; 1/M; -2/(M*l)];

C = [1 0 0 0;0 1 0 0];

D = [0;0];

sys=ss(A,B,C,D);

%% Transfer Function
 Transfer_function = tf(sys);
 
%  sys1 = Transfer_function(2,:);
%  s = zpk('s'); % Laplace variable s
%  Gd = 30/s; 
%  [K,CL,GAM] = loopsyn(sys1,Gd);
%  [num,den] = tfdata(K);
%  transfer_fcn = tf(num,den)
%  GAM;
%  K;

Transfer_function=tf(sys)
sys1=Transfer_function(2,:)
%Pendulum angle to input force T.F
 %theetabyU=tf([m*(l/q) 0],[1 (((b1*(I+(m*(l^2))))+(b2*(M+m)))/q) -(((b1*b2)+(m*l*g*(M+m)))/q) -((b1*m*l*g)/q)])
 %plant_poles = pole(theetabyU)
 %plant_zeros = tzero(theetabyU)
 clf, sigma(sys1,'g',{.1,100});
title('Singular value plot for theeta/U')
s = zpk('s'); % Laplace variable s
Gd =10/s;     
sigma(Gd,{.1 100})
grid
title('Target loop shape Gd(s).')
set(gca,'FontSize',9,'Fontsize',14,'FontName','Times')

% create textarrow pointing to crossover frequency Wc
hold on;
plot([10,35],[0,21],'k.-'); 
plot(10,0,'kd');
plot([.1,100],[0 0],'k');
text(3,23,'Crossover Frequency \omega_c = 10');
hold off;
%Using LOOPSYN to Compute the Optimal Loop-Shaping Controller
[K,CL,GAM] = loopsyn(sys1,Gd);
GAM
K
%comparison
L = sys1*K;              % form the compensated loop L
figure

sigma(Gd,'b',L,'r--',{.1,100});
set(gca,'FontSize',9,'Fontsize',14,'FontName','Times')
grid on
legend('Gd (target loop shape)','L (actual loop shape)');
%Analyzing the Shaped-Loop L, Closed-Loop T, and Sensitivity S
T = feedback(L,eye(1));
T.InputName = {'Force'};
S = eye(1)-T;

% SIGMA frequency response plots
figure

sigma(inv(S),'m',T,'g',L,'r--',Gd,'b',Gd/GAM,'b:',...
	Gd*GAM,'b:',{.1,100})
grid on
legend('1/\sigma(S) performance',...
	'\sigma(T) robustness',...
	'\sigma(L) open loop',...
	'\sigma(Gd) target loop shape',...
	'\sigma(Gd) \pm GAM(dB)');
set(gca,'FontSize',9,'Fontsize',14,'FontName','Times')
% Make lines wider and fonts larger

set(findobj(gca,'Type','line','-not','Color','b'),'LineWidth',2);
h = findobj(gca,'Type','line','-not','Color','b');
set(h,'LineWidth',2);

% figure
% step(T,8)
% title('Responses to step commands');
% S = stepinfo(T)
figure
impulse(T,8)

title('Responses to impulse commands');
set(gca,'FontSize',9,'Fontsize',14,'FontName','Times')