clear all
close all

%sampling period
Delta=0.01;
T=1;

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
y(:,1)=[0; 0];

%input
ut=[4;1];
u=repmat(ut,1,length(t));
x=zeros(2,length(t));

%initialization
x(:,1)=[0 ; 0];

%DT simulation of the system state from time 0 to time 10
for i=1:length(t)-1
    x(:,i+1)=Ad*x(:,i)+Bd*u(:,i);
    y(:,i+1)=Cd*x(:,i);
end

xt=zeros(2,length(t));
xt=[3-(0.5*exp(-0.5*Delta/T))-(2.5*exp(-1.5*Delta/T)); 1+((1/4)*exp(-0.5*Delta/T))-(1.25*exp(-1.5*Delta/T))];
yt=zeros(2,length(t));
yt(:,1)=[0; 0];
ut1=[4;1];
u1=repmat(ut1,1,length(t));


for j=1:length(t)-1
   xt(:,j+1)=Ad*xt(:,j)+Bd*u1(:,j);
   yt(:,j+1)=Cd*xt(:,j);
end

figure(1)
plot(t,x(1,:),'.',t,xt(1,:),'LineWidth',2,'MarkerSize',10);
legend('Simulation X_1','Theoretical X_1')
ylabel('x_1(t)=Vc_1(t)[v]')
xlabel('t[msec]')
title('Comparing Plot of X_1=Vc_1');
grid
figure(2)
plot(t,x(2,:),'.',t,xt(2,:),'LineWidth',2,'MarkerSize',10)
legend('Simulation X_2','Theoretical X_2')
ylabel('x_2(t)=Vc_2(t)[v]')
xlabel('t[msec]')
title('Comparing Plot of X_2=Vc_2');
grid
figure(3)
plot(t,y(1,:),'.',t,yt(1,:),'LineWidth',2,'MarkerSize',10)
legend('Simulation Y_1','Theoretical Y_1')
ylabel('y_1(t)=Vo_1(t)[v]')
xlabel('t[msec]')
title('Comparing Plot of Y_1=Vo_1');
grid
figure(4)
plot(t,y(2,:),'.',t,yt(2,:),'LineWidth',2,'MarkerSize',10)
legend('Simulation Y_2','Theoretical Y_2')
ylabel('y_2(t)=Vo_2(t)[v]')
xlabel('t[msec]')
title('Comparing Plot of Y_2=Vo_2');
grid
