%% Important vars
clear;
clc;

addpath functions;
global PROBABILITY LABELING dictionary ...
    LABELING_OVERLAY dict image nr_labels;

%% Default

% image = imread('bag.png');
image = imread('texture.jpg');
image = image(:,:,1);
dict.method = 'euclidean';
dict.patch_size = 15;
dict.branching_factor = 2;
dict.number_layers = 5;
dict.number_training_patches = 1000;
dict.normalization = false;
nr_labels = 2;


[r,c,~] = size(image);
LABELING = zeros(r*c,nr_labels);

%% Init labeling
texture.init_label_circle();

%% Initialization

[image,image_rgb,image_gray] = texture.normalize_image(image); % impose 0-to-1 rgb
LABELING_OVERLAY = image_rgb; % image overlaid labeling
SEGMENTATION_OVERLAY = 0.5+zeros(r,c,3); % segmentation, optionally overlay

%% %%%%%%%% TEXTURE REPRESENTATION %%%%%%%%%%
% initialization: building a texture representation of the image
% parsing dictopt input: either dictionary_options, dictionary or mappings

dictionary = build_dictionary(image,dict);
mappings = compute_mappings(image,dictionary);
T1 = mappings.T1;
T2 = mappings.T2;

PROBABILITY = 1/nr_labels*ones(size(LABELING));

%% Update
% PROBABILITY = METHOD(LABELING);
labelings = LABELING;
labelings(~any(labelings,2),:) = 1/nr_labels; % distributing
PROBABILITY = T2*(T1*labelings); % computing probabilities
        
% labeling_overwrite
 
% regularize
                
%% compute_overlays
COLORS = [0.5000    0.5000    0.5000
            0    1.0000    1.0000
            1.0000         0    1.0000];
COLOR_WEIGHT = 0.2;

LABELING_OVERLAY = reshape(LABELING*COLORS(2:end,:),size(image_rgb)).*...
        (COLOR_WEIGHT+(1-COLOR_WEIGHT)*image_gray);
unlabeled = repmat(~any(LABELING,2),[3,1]); % pixels not labeled
LABELING_OVERLAY(unlabeled) = image_rgb(unlabeled);

maxprob = max(PROBABILITY,[],2);
maxprobloc = PROBABILITY == maxprob(:,ones(nr_labels,1));
uncertain = sum(maxprobloc,2)>1; % pixels with max probability at two or more classes
maxprobloc(uncertain,:) = 0;
SHOW_INDEX = 1;
if SHOW_INDEX==1 % segmentation
    SEGMENTATION_OVERLAY = reshape([uncertain,maxprobloc]*COLORS,size(image_rgb));
else % SHOW_INDEX==2 overlay
    SEGMENTATION_OVERLAY = reshape([uncertain,maxprobloc]*COLORS,...
        size(image_rgb)).*(COLOR_WEIGHT+(1-COLOR_WEIGHT)*image_gray);
end

% show_overlays(get_pixel);