function tire_sim_view
global x1 x2 theta1 theta2;
% radius (m)
r = .4;

x_lim = [-2 30];
y_lim = [-1 4];

low_lim = 1;
while(x1(low_lim)<.001)
    low_lim = low_lim+1;
end

for t = low_lim:length(x1)
    clf;
    line(x_lim, [0 0]);
    hold on;
    
    % Visualize output
    circleplot(x1(t), r, r, -1*theta1(t));
    circleplot(x2(t), r, r, -1*theta2(t));
    frame = line([x1(t) x2(t)], [r r]);
    set(frame, 'Color', 'black');
    
    axis equal
    xlim(x_lim)
    ylim(y_lim)
    set(gca, 'YTickLabel', []);
    set(gca, 'YTick', []);
    % Pause for dramatic effect
    pause(.1);    
end
hold off;
end

function [p, p2]=circleplot(x,y,r, theta)
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