clear, close all
addpath fastkmeans texture_functions_updated flann snakes_functions
    
% SETTINGS
input_image = '../data/134052.jpg';
scFac = 1; % scale factor for the input image

% dictionary settings
nToClust = 5000;
branching_factor = 5;
number_layers = 4;
M = 3; % size of the patches
normalize = true; % normalization makes texture invariant to global intensity changes

%  curve initialization
nr_points = 200; % number of snakes points
center = [150,200];
radius = 50;

% curve evolution
nStep = 100;
step_size = 1;
alpha = 1; % elasticity
beta = 0.5; % stifness

global show_runtime; show_runtime = true;

% PRE-PROCESSING
% texture
im = imresize(imread(input_image), scFac);
im_double = double(im)/double(max(im(:)));

tree = build_km_tree(im_double,M,branching_factor,...
    nToClust,number_layers,normalize);
A = search_km_tree(im_double,tree,branching_factor,normalize);
[T1,T2] = transition_matrix(biadjacency_matrix(A,M));
[r,c,l] = size(im_double);

%% snakes initialization
S = make_circular_snake(center*scFac, radius*scFac, nr_points);
S = keep_snake_inside(S,[r,c],floor(M/2));
figure(1), imagesc(im), axis image, hold on, plot(S(:,2),S(:,1))
B = regularization_matrix(nr_points,alpha,beta);

%% ITERATE, VARIANT SIMILAR TO ICPR 2014
for i = 1:nStep    
    in = poly2mask(S(:,1),S(:,2),r,c);    
    DictProb = T1*in(:);
    alpha = sum(in(:))/sum(~in(:)); % area(in)/area(out)
    DictProb = DictProb./(DictProb+alpha*(1-DictProb)); % area normalization
    P = reshape(T2*DictProb,size(A)); % probabilities
    P_snake = P(sub2ind([r,c],round(S(:,1)),round(S(:,2)))); 
    % F = 5*(P_snake-0.5); % alternative snake force
    P_snake(P_snake==0) = eps;
    P_snake(P_snake==1) = 1-eps;
    F = log(P_snake./(1-P_snake)); % snake force    
    N = snake_normals(S); 
    S = S + step_size*F*[1,1].*N; % moving the snake according to the force
    S = B*S; % curve smoothing
    S = remove_crossings(S);
    S = place_points_equidistantly(S);
    S = keep_snake_inside(S,[r,c],floor(M/2));
    figure(1), cla, imagesc(im), axis image, hold on, 
        plot(S([1:end,1],2),S([1:end,1],1),'LineWidth',2)
    title(i), drawnow
end
figure(2), imagesc(P), axis image