function [T1,T2] = transition_matrix(B)
%TRANSITION_MATRIX   Label to probability transition matrices.
% T = TRANSITION_MATRIX(B) builds transition matrix based on the bipartite
% matrix B, obtained from function B = bipartite_matrix(A,M). Transition
% matrix defines a linear mapping between images which have the same size
% as A, and may be used as a diffusion matrix or as a label image (L) to
% probability image (P) transition matrix, P = T*L.
% [T1,T2] = TRANSITION_MATRIX(B) returns intermediate transitions from a
% label image to a dictionary and from a dictionary to a probability image
% so that T = T2*T1. Depending on the size of the image and the dictionary,
% it might be more efficient to compute P = T2*(T1*L).
%
% Authors: vand@dtu.dk

global show_runtime % a global flag determining whether run-time is shown

if show_runtime
    fprintf('transition_matrix... '), tic
end

[rc,nm] = size(B);

Dxinv = sparse(1:rc,1:rc,1./(sum(B,2)+eps),rc,rc);
Dyinv = sparse(1:nm,1:nm,1./(sum(B,1)+eps),nm,nm);

if nargout ==1
    T1 = Dxinv*B*Dyinv*B';
else
    T1 = Dyinv*B';
    T2 = Dxinv*B;
end

if show_runtime
    disp(['   finished in ',num2str(toc)])
end

end