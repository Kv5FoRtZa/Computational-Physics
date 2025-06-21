clc; clear; close all;

g = 9.80665;
ro = 7850;
r = 0.13;
m = 4/3 * pi * r^3 * ro;
G = m * g;
v0 = 1100;
alpha0 = 0; 
eta = 1.81 * 1e-5;
b1 = 6 * pi * eta * r;
c = 0.4609;
ro0 = 1.22; 
b2 = c * 4 * pi * r^2 * ro0 / 2;
maxim = -99;
unghi = 0;
for j = 0:0.5:90
    alpha0 = j;
    t0 = 0;
    tf = 2 * v0/g*sind(alpha0);
    N = 1500;
    t = linspace(t0,tf,N);
    dt = t(2) - t(1);
    vx = zeros(1,N);
    vy = vx;
    x = zeros(1,N);
    y = x;
    vx(1) = v0 * cosd(alpha0);
    vy(1) = v0 * sind(alpha0);
    for i = 1:N-1
        aux = 1 - dt*(b1 + b2 * sqrt(vx(i)^2+vy(i)^2))/m;
        vx(i + 1) = vx(i) * aux;
        vy(i + 1) = vy(i) * aux - g*dt;
        x(i + 1) = x(i) + vx(i) * dt;
        y(i + 1) = y(i) + vy(i) * dt;
        if y(i + 1) < 0
            break;
        end
    end
    if (x(i) > maxim)
        maxim = x(i);
        unghi = alpha0;
    else
        break;
    end
end
t = t(1:i); vx = vx(1:i);vy = vy(1:i);x = x(1:i);y = y(1:i);
afis=['Bataia maxima a proiectilului este de ',num2str(maxim/1e3),' Km'];disp(afis);
afis=['Si este pentru unghiul ',num2str(unghi),' grade'];disp(afis);


