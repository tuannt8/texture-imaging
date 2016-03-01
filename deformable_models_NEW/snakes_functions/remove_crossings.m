function S = remove_crossings(S)
% A heuristic for resolving simple loops in a closed snake by
% reordering points in the smaller loop end. Does not handle
% self-intersections.

S1 = [S;S(1,:)];
n1 = size(S1,1);
n = n1-1;

for i = 1:n1-3
    for j = i+2:n1-1
        if ( is_crossing(S1(i,:), S1(i+1,:), S1(j,:), S1(j+1,:)) )
            f = i+1;
            t = j;
            if ( j-i > n/2 )
                f = j+1;
                t = i+n;
            end
            while ( f < t )
                idF = mod(f,n);
                if ( idF == 0 )
                    idF = n;
                end
                f = f + 1;
                
                idT = mod(t,n);
                if ( idT == 0 )
                    idT = n;
                end
                t = t - 1;
                tmp = S1(idF,:);
                S1(idF,:) = S1(idT,:);
                S1(idT,:) = tmp;
            
            end
            S1(end,:) = S1(1,:);
        end
    end
end

S = S1(1:end-1,:);