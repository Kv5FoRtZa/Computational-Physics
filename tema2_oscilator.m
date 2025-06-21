clc; clear; close all;
g = 9.80665;
L = 2;
theta0 = 30;
theta0 = theta0 * pi / 180;
viteza0 = 0;
viteza0 = viteza0 * pi / 180;

glm = 0;
gsd = 1 - glm;

ti = 0;
T = 2 * pi * sqrt(L/g);
coef_frecare = 0.0098;
omega = 2 * pi / T;
tf = 10 * T;
t = linspace(ti,tf,1000);
dt = t(2) - t(1);
aux = dt^2*g/L;

theta_num = zeros(1,1000);
theta_num(1) = theta0;
theta_num(2) = theta0 + dt * viteza0;
theta_max = sqrt(theta0^2 + viteza0^2/omega^2);
phi = atan(-viteza0/omega/theta0);

theta_an = theta_max* cos(omega * t + phi);
for j = 0:0.0001:1
    coef_frecare = j;
    theta_num = zeros(1,1000);
    theta_num(1) = theta0;
    theta_num(2) = theta0 + dt * viteza0;
    for i = 2 : 1000 - 1
        theta_dot = (theta_num(i) - theta_num(i-1)) / dt;
        theta_num(i + 1) = (2 * theta_num(i) - theta_num(i - 1) - aux * sin(theta_num(i)) - coef_frecare * dt * theta_dot);
        if theta_num(i) > theta_num(i + 1) && theta_num(i) > theta_num(i - 1)
            save = theta_num(i);
        end
    end
    if(abs(save - theta0 / 2) < 0.01)
        coef = coef_frecare;
        break;
    end
end
if glm == 1
    figure(1);
    plot(t,theta_an,'-r',t,theta_num,'-b');
    xlabel('t(s)');
    ylabel('theta(rad)');
    title('Lege unghiulara de miscare');
    grid;
    legend('analitic-armonic,numeric');
else   
    figure(2);
    simt = 0;
    tic;
    x = L * sin(theta_num);
    y = -L * cos(theta_num);
    while simt < tf
        indice = abs(t - simt) == min(abs(t - simt));
        xg = x(indice);
        yg = y(indice);
        plot([0,xg],[0,yg],'-k');hold on;
        plot(xg,yg,'.r','MarkerSize', 10);
        xlabel('x(m)');
        ylabel('y(m)');
        grid;
        axis([-L,L,-L,L]);
        axis square;
        pause(1e-3);
        simt = toc;
        hold off;
    end
end