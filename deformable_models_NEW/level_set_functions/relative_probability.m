function P_relative = relative_probability(P)

P_relative = zeros(size(P));
for i=1:size(P,3)
    P_in = P(:,:,i);
    P_out = max(P(:,:,[1:i-1,i+1:end]),[],3);
    P_relative(:,:,i) = P_in./(P_in+P_out);
end
