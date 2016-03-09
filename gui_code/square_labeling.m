global LABELING image;

s = size(image);

% square 1, label 1
s_size = round(s/10);
start = round(s/4);

for i = start:start+s_size
    for j = start:start+s_size
        LABELING(i*s(2)+j,1) = 1;
    end
end



% square 2, label 2
s_size = round(s/10);
start = round(s*3/4);

for i = start:start+s_size
    for j = start:start+s_size
        LABELING(i*s(2)+j,2) = 1;
    end
end