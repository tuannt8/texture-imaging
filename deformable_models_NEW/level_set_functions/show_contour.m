function show_contour(I,phi,lw)
% image, level set function, line width

if nargin < 3
    lw = 2-(size(phi,3)>2);
end

% should handle all our test cases
cla
if size(I,3)==1
    imagesc(I), colormap gray
elseif size(I,3)==3
    image(I)
else
    imagesc(mean(I,3)), colormap gray
end

axis image, hold on
col = 'cmgbrykw';
for i=1:size(phi,3)
    contour(phi(:,:,i),[0 0],col(i),'LineWidth',lw)
end

end
