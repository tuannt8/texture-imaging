clear, close all
addpath fastkmeans texture_functions_updated flann level_set_functions
    
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
center = [150,200];
radius = 50;

% curve evolution
sigma = 1; % sigma for gaussian smoothing
nStep = 100;
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
mask = initial_mask([r,c],radius,center);
phi = mask2sdf(mask);
%figure(1), show_phi(phi)
figure(2), show_contour(im,phi)
gaussian_filter = fspecial('gaussian', [6*round(sigma)+1,1], sigma);

%% ITERATE, VARIANT FROM SCIA 2015
for i = 1:nStep
    in = phi<0; % current segmentation
    DictProb = T1*in(:);
    alpha = sum(in(:))/sum(~in(:)); % area(in)/area(out)
    DictProb = DictProb./(DictProb+alpha*(1-DictProb)); % area normalization
    P = reshape(T2*DictProb,size(A)); % probabilities
    phi = phi + w*(0.5-P); % updating
    phi = filter2(gaussian_filter,filter2(gaussian_filter',phi)); % regularizing
    phi = phi/(1+a); % questionable division
    % phi = 50*phi/max(abs(phi(:))); % alternative to questionable division
    % figure(1), cla, show_phi(phi), title(i), drawnow
    figure(2), cla, show_contour(im,phi), title(i), drawnow
end
figure(1), cla, show_phi(phi), title(i), drawnow
