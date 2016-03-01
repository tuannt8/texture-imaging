function cmap = blue_white_red(c,M,CLim)
%BLUEWHITERED   Blue, white, and red color map.
%   BLUEWHITERED returns blue-white-red colormap, with colormap limits
%   given by the current colormap. White color corresponds  to the c value,
%   which by default is 0 for negative-to-positive colormaps, and mean of
%   colormap limits othervise. The length of the colormap is M, which by
%   default is the length of the current colormap. Optionaly limits of
%   colormap may also be given.

% number of elements in colormap
if nargin < 2
    M = size(colormap,1);
end

if nargin < 1
    c = 0;
end

% finding limits of current colormap
if nargin < 3
    CLim = get(gca, 'CLim');
end

% if current colormap does not include 0, we use only half of the
% red-white-blue colormap
low = CLim(1);
high = CLim(2);

if c<=low || c>= high
    c = (low + high)/2;
end

X = [low; (low+c)/2; c; (high+c)/2; high];
V = [0,0,0.5;
    0,0.5,1;
    1,1,1;
    1,0,0;
    0.5,0,0];
Xq = linspace(low,high,M);
cmap = interp1(X,V,Xq);

end
