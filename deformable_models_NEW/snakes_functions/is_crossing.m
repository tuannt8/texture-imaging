function is_cross = is_crossing(p1, p2, p3, p4)
% detects crossings between a two line segments: p1 to p2 and p3 to p4

is_cross = false;

p21 = p2-p1;
p34 = p3-p4;
p31 = p3-p1;

alpha = (p34(2)*p31(1)-p31(2)*p34(1))/(p34(2)*p21(1)-p21(2)*p34(1));
if alpha>0 && alpha<1
    beta = (p21(2)*p31(1)-p31(2)*p21(1))/(p21(2)*p34(1)-p34(2)*p21(1));
    if beta>0 && beta<1
        is_cross = true;
    end
end

