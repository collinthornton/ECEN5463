close all

%% Friction parameters
frictionModel = 'Smooth'; %Do not change this!

%% Initial Conditions
q0 = [0;0]; %Initial angular position
qDot0 = [0;0]; %Initial angular velocity
x0 = [q0;qDot0];

%% Animation parameters
L=[1;0.5]; %Link lengths
w=[0.1;0.05]; %Link widths

%% Simulation
options = odeset(...
    'OutputFcn',@(t,y,flag) nLinkAnimateOutputFcn(t,y,flag,L,w)...
    );
[t,x]=ode45(...
    @(t,x) robotDynamicsExam3(t,x,controlFunExam3(t,x),frictionModel),...
    [0 10],...
    x0,...
    options...
    );
xlabel('$x$ (m)','Interpreter','Latex')
ylabel('$y$ (m)','Interpreter','Latex')

%% Plots
x=x';
q = x(1:2,:);
qd = [(1 - exp(-2 * t.')) .* cos(2 * t.');
      (1 - exp(-2 * t.')) .* sin(t.')];
e = qd - q;
figure
plot(t,e)
xlabel('$t$ (s)','Interpreter','Latex')
ylabel('$e(t)$ (rad)','Interpreter','Latex')
legend('Link 1','Link 2');
figure
tau=controlFunExam3(0,x);
plot(t,tau);
xlabel('$t$ (s)','Interpreter','Latex');
ylabel('$\tau(t)$ (Nm)','Interpreter','Latex');
legend('Link 1','Link 2');

%% Functions
function [ tau ] = controlFunExam3( t,x )
    %Controller Design
    kp=[150 0;0 10];
    qd = [(1-exp(-2*t)) * cos(2*t);
          (1-exp(-2*t)) * sin(t)];
    e=qd-[x(1,:);x(2,:)]; % this notation ensures that  
    %the function can either operate on a single 
    %state x or a matrix of states with each column 
    %as one state
    tau = kp*e;
end