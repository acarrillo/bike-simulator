function tire_sim_view
global x_rear x_front theta_rear theta_front slip_rear slip_front;
% radius (m)
r = .4;

x_lim = [-2 30];
y_lim = [-1 4];

low_lim = 1;
while(x_rear(low_lim)<.001)
    low_lim = low_lim+1;
end


clf;
wheel_plot = subplot(211);

slip_force = subplot(212);
title('Slip/Force Graph');
xlabel('Wheel Slip');
ylabel('Tractive Force');
grid on;
s = linspace(-1,1,1000);
plot(s, sin(2*atan((5*s)-1*((3*s)-atan(3*s)))));
hold on;
wheelrear_sf = plot(0,0);
wheelfront_sf = plot(0,0);

for t = low_lim:length(x_rear)
    
    subplot(slip_force);
    title('Slip/Force Graph');
    xlabel('Wheel Slip');
    ylabel('Tractive Force');
    grid on;
    delete(wheelrear_sf);
    delete(wheelfront_sf);
    
    slip_1 = slip_rear(t);
    force_1 = sin(2*atan((5*slip_rear(t))-1*((3*slip_rear(t))-atan(3*slip_rear(t)))));
    wheelrear_sf = text(slip_1, force_1, '\leftarrow Rear');
    
    slip_2 = slip_front(t);
    force_2 = sin(2*atan((5*slip_front(t))-1*((3*slip_front(t))-atan(3*slip_front(t)))));
    wheelfront_sf = text(slip_2, force_2, '\leftarrow Front');  
    
    
    cla(wheel_plot);
    subplot(wheel_plot);
    line(x_lim, [0 0]);
    hold on;
    
    % Visualize output
    circleplot(x_rear(t), r, r, -1*theta_rear(t));
    circleplot(x_front(t), r, r, -1*theta_front(t));
    frame = line([x_rear(t) x_front(t)], [r r]);
    set(frame, 'Color', 'black');
    
    axis equal
    xlim(x_lim)
    ylim(y_lim)
    set(gca, 'YTickLabel', []);
    set(gca, 'YTick', []);
    % Pause for dramatic effect
    pause(.1);
    hold off;
end
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