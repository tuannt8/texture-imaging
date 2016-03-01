function show_phi(phi)

imagesc(phi,[min(phi(:)),max(phi(:))]), axis image, hold on
colormap(blue_white_red(0,256,[min(phi(:)),max(phi(:))]))
contour(phi,[0 0],'g')

end

