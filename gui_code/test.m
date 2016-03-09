%% Probability
p1 = reshape(PROBABILITY(:,1), size(image));
p2 = reshape(PROBABILITY(:,2), size(image));

figure;
subplot(1,2,1);
imagesc(p2);
colormap gray; axis image;

subplot(1,2,2);
imagesc(p1);
colormap gray; axis image;

%% Labeling
s = size(image);
s = [s(2) s(1)];
p1 = reshape(LABELING(:,1), s);
p2 = reshape(LABELING(:,2), s);

figure;
subplot(1,2,1);
imagesc(p2);
colormap gray; axis image;

subplot(1,2,2);
imagesc(p1);
colormap gray; axis image;
%%
s = size(image);
s = [s(2) s(1)];
p1 = reshape(labelings(:,1), s);
p2 = reshape(labelings(:,2), s);

p1 = p1';
p2 = p2';

figure;
subplot(1,2,1);
imagesc(p2);
colormap gray; axis image;

subplot(1,2,2);
imagesc(p1);
colormap gray; axis image;