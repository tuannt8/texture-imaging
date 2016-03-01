clear, close all
addpath 'fastkmeans' 'texture_functions' 'flann' 'level_set_functions'
    
% SETTINGS
input_image = '../data/164074.jpg';
scFac = 1; % scale factor for the input image

% dictionary settings
nToClust = 5000;
branching_factor = 5;
number_layers = 4;
M = 3; % size of the patches
normalize = true; % normalization makes texture invariant to global intensity changes

%  curve initialization
center2 = [200,200];
center3 = [270,450];
radius = 30;

% curve evolution
sigma = 1; % sigma for gaussian smoothing
nStep = 150;
w = 2; 
a = 0.05; % questionable division

%global show_runtime; show_runtime = true;

% PRE-PROCESSING
% texture
im = imresize(imread(input_image), scFac);
im_double = double(im);
tree = build_km_tree(im_double,M,branching_factor,...
    nToClust,number_layers,normalize);
A = search_km_tree(im_double,tree,branching_factor,normalize);
[T1,T2] = transition_matrix(biadjacency_matrix(A,M));
[r,c,l] = size(im_double);

%% level set initialization
mask = zeros(r,c,3);
mask(:,:,2) = initial_mask([r,c],radius,center2);
mask(:,:,3) = initial_mask([r,c],radius,center3);
mask(:,:,1) = ones(r,c) - sum(mask,3);% background

phi = mask2sdf(mask);
figure(1), show_multiphase_phi(phi)
figure(2), show_contour(im,phi)
gaussian_filter = fspecial('gaussian', [6*round(sigma)+1,1], sigma);

%% ITERATE, VARIANT FROM SCIA 2015
for i = 1:nStep
    in = reshape(phi<0,[size(phi,1)*size(phi,2),size(phi,3)]); % current segmentation
    DictProb = T1*in;    
    
    % carefull area normalization
    alpha = sum(in); % area for each class
    alpha(alpha==0) = eps; % preventing division with 0
    DictProb = DictProb*diag(1./alpha);  % dividing with area 
    sDictProb = sum(DictProb,2); % sum of probs for each dict pixel
    sDictProb(sDictProb==0) = eps; % preventing division with 0
    DictProb = diag(1./sDictProb)*DictProb; % each pixel sums to 1
    
    P = reshape(T2*DictProb,size(phi)); % probabilities
    P_relative = relative_probability(P); % relative (multilable) probabilities
    
    phi = phi + w*(0.5-P_relative); % updating
    
    % regularizing
    for j = 1:size(phi,3)
        phi(:,:,j) = filter2(gaussian_filter,filter2(gaussian_filter',phi(:,:,j)));
    end
    phi = phi/(1+a); % questionable division
    % figure(1), cla, show_multiphase_phi(phi), title(i), drawnow
    figure(2), cla, show_contour(im,phi), title(i), drawnow
end
figure(1), show_multiphase_phi(phi), title(i), drawnow
