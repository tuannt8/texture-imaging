function S = keep_snake_inside(S,dim,b)

S(:,1) = max(min(S(:,1), dim(1)-b), 1+b);
S(:,2) = max(min(S(:,2), dim(2)-b), 1+b);