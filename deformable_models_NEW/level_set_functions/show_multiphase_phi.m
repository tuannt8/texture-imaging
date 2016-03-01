function show_multiphase_phi(phi)

I = size(phi,3);
for i=1:I
    subplot(I,1,i)
    cla, imagesc(phi(:,:,i),[min(phi(:)),max(phi(:))]), axis image, hold on
    colormap(blue_white_red(0,256,[min(phi(:)),max(phi(:))]))
    contour(phi(:,:,i),[0 0],'g')
end

end


