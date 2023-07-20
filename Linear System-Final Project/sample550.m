%%% simulation sampling period
Delta=1e-5;

%%% Ad and Bd for the discrete time case
%%% for A=[1 (t-\tau); 0 1], B=[0; 1]
Ad=[1 Delta; 0 1]; %%% Ad = Phi((k+1)T,kT)
Bd=[0.5*Delta^2;Delta]; %%% Bd= \int_{kT}^{(k+1)T} Phi((k+1)T,s)B(s)ds
t=0:Delta:1;

%%% input (found in class)
u=-3940+5880*t;
x=zeros(2,length(t));

%%% initialization (from class)
x(:,1)=[-10 ; 1000];

%%% DT simulation of the system state from time 0 to time 1
for i=1:length(t)-1
    x(:,i+1)=Ad*x(:,i)+Bd*u(i);
end


figure(1)
plot(t,x(1,:))
ylabel('$x_1(t)=x(t)$[m]','Interpreter','LaTeX')
xlabel('$t$[sec]','Interpreter','LaTeX')
grid
figure(2)
plot(t,x(2,:))
ylabel('$x_2(t)=\dot{x}(t)$[m/sec]','Interpreter','LaTeX')
xlabel('$t$[sec]','Interpreter','LaTeX')
grid