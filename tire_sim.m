function tire_sim
slip = linspace(0,1,100);
coeff_friction = 1*sin(2*atan((5*slip)-1*((3*slip)-atan(3*slip))));

% mass (kg)
m = 1; 
% radius (m)
global r
r = .4;
J = m*(r^2); 
N = 9.8;

x = 0;
v = 0;
a = 0;
theta = 0;
w = 0;
alpha = 0;
F = 0;

% For visualiation
global x_lim y_lim
x_lim = [-2 10];
y_lim = [-1 4];
movie = zeros

numticks = 1000;
start_time = 0;
end_time = 10; % seconds
time_step = (end_time - start_time) / numticks;
time = start_time:time_step:end_time;

input = zeros(1,numticks);

% Design your input here
input(1) = .0125;
input(2) = .0125;
input(100) = .125;

for t = 1:numticks
    % Calculate slip ratio
    % Update state variables
    x = x+(v*time_step);
    v = v+(a*time_step);
    theta = mod((theta + (w*time_step)), 360);
    w = w + (alpha*time_step);
    
    
    
    if w*r == v
        s = 0;
    else
        s = (w*r - v) / max(w*r, v);
    end
    mu = sign(s)*coeff_friction(floor(abs(s)*99)+1);
    F = mu/N;
    
    alpha = (input(t)/J) - r*F/J;
    
    a = F/m;

    
    % Visualize output
    drawstate(x, theta);    % Pretty up the drawing
    axis equal
    xlim(x_lim)
    ylim(y_lim)
    set(gca, 'YTickLabel', []);
    set(gca, 'YTick', []);
    
    % Pause for dramatic effect
    pause(.1);
end
end

function drawstate(x, theta)
clf;
% Draw ground plane
global x_lim r
line(x_lim, [0 0]);
hold on
circleplot(x, r, r, theta);
hold off
end

function circleplot(x,y,r, theta)
%x and y are the coordinates of the center of the circle
%r is the radius of the circle
%0.01 is the angle step, bigger values will draw the circle faster but
%you might notice imperfections (not very smooth)
ang=0:0.01:2*pi; 
xp=r*cos(ang);
yp=r*sin(ang);
p = plot(x+xp,y+yp);
set(p, 'Color', 'red');
p2 = line([x x+r*cos(theta)], [y y+r*sin(theta)]);
set(p2, 'Color', 'green');
end
