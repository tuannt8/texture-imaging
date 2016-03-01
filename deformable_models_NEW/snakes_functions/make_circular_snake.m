function S = make_circular_snake(c,r,N)
% c center, r radius, N number of snake points

alpha = (0:N)*2*pi/N; % N+1 point
alpha(end) = []; % removing last

x = c(1) + r*cos(alpha);
y = c(2) + -r*sin(alpha); 
S = [x(:),y(:)]; % snake
