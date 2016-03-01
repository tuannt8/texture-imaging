function B = regularization_matrix(N,alpha,beta)
% B is an NxN matrix for imposing elasticity and rigidity to snakes
% alpha is weigth for second derivative (elasticity)
% beta is weigth for (-)fourth derivative (rigidity)

r = zeros(1,N);
r(1:3) = alpha*[-2 1 0]/4 + beta*[-6 4 -1]/16;
r(end-1:end) = alpha*[0 1]/4 + beta*[-1 4]/16;
A = toeplitz(r);
B = (eye(N)-A)^-1;