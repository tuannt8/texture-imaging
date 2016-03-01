function N = snake_normals(S)
% normals for a closed snake

Xe = S([end,1:end,1],:); % extended S

N = Xe(1:end-1,:)-Xe(2:end,:); % dX
N = [N(:,2),-N(:,1)]; % orthogonal to dX
Nn = sum(N.^2,2).^0.5; % for normalization
id = find(Nn~=0);
Nedges = N;
Nedges(id,:) = N(id,:)./[Nn(id),Nn(id)]; % edge normals
N = (Nedges(1:end-1,:)+Nedges(2:end,:))/2; % vertices normals
