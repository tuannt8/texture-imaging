function phi = initial_mask(dim,radius,centers,distance)
% either centers or distance should be given (or neither)

if nargin<3 || isempty(centers)
    centers = (dim+1)/2;
end

if nargin==4 % multiple equaly distanced circles
    cx = radius:distance:dim(1)-radius;
    cy = radius:distance:dim(2)-radius;    
    cx = cx + (1+dim(1)-cx(1)-cx(end))/2; % centering
    cy = cy + (1+dim(2)-cy(1)-cy(end))/2; 
    [CX,CY] = ndgrid(cx,cy);
    centers = [CX(:),CY(:)];
end

phi = false(dim);
[X,Y] = ndgrid(1:dim(1),1:dim(2));

for s = 1:size(centers,1)
    in = (X-centers(s,1)).^2+(Y-centers(s,2)).^2 < radius^2;
    phi = phi | in;
end