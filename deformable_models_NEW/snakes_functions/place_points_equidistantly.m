function Snew = place_points_equidistantly(S)
% Distributes pponts equidistantly along the snake curve
% This has a small smoothing effect.

n = size(S,1);
Scirc = [S; S(1,:)]; % closed snake
p = [0;cumsum(sqrt(sum((Scirc(2:end,:)-Scirc(1:end-1,:)).^2,2)))]; % parametrization along the curve
pNew = linspace(0,p(end),n+1); % equidistant parametrization
Snew = interp1(p,Scirc,pNew(1:n));




