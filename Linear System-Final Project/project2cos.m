close all
clear all

%sampling period
Delta=0.01;

%Ad and Bd for the discrete time case
%for A=[-1/T -1/T;-1/4T -1/T], B=[1/T 0;1/4T 3/4T], T=1ms
% Ad = Phi((k+1)T,kT)
Ad=[-2 2;1 1]*[exp(-0.5*Delta) 0;0 exp(-1.5*Delta)]*[-0.25 0.5;0.25 0.5];
% Bd= \int_{kT}^{(k+1)T} Phi((k+1)T,s)B(s)ds
Bd=[-2 2;1 1]*[2-2*exp(-0.5*Delta) 0;0 (2/3)-(2/3)*exp(-1.5*Delta)]*[-0.25 0.5;0.25 0.5]*[1 0;0.25 0.75];

t=0:Delta:10;

%y(t)
Cd=[1 1;0 1];
y=zeros(2,length(t));
y(:,1)=[0 ; 0];

%input
u=zeros(2,length(t));
u=[4; 1]*cos(2*pi*t);
x=zeros(2,length(t));

%initialization
x(:,1)=[0 ; 0];

%DT simulation of the system state from time 0 to time 10 msec
for i=1:length(t)-1
    x(:,i+1)=Ad*x(:,i)+Bd*u(:,i);
    y(:,i+1)=Cd*x(:,i);
end

figure(1)
subplot(1,2,1)
plot(t,x(1,:))
ylabel('$x_1(t)=Vc1(t)$[v]','Interpreter','LaTeX')
xlabel('$t$[msec]','Interpreter','LaTeX')
grid
subplot(1,2,2)
plot(t,x(2,:))
ylabel('$x_2(t)=Vc2(t)$[v]','Interpreter','LaTeX')
xlabel('$t$[msec]','Interpreter','LaTeX')
grid

figure(2)
subplot(1,2,1)
plot(t,y(1,:))
ylabel('$y_1(t)=Vo1(t)$[v]','Interpreter','LaTeX')
xlabel('$t$[msec]','Interpreter','LaTeX')
grid
subplot(1,2,2)
plot(t,y(2,:))
ylabel('$y_2(t)=Vo2(t)$[v]','Interpreter','LaTeX')
xlabel('$t$[msec]','Interpreter','LaTeX')
grid

