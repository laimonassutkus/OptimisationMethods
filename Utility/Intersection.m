function [XL, YL, ZL] = Intersection(X, Y, Z1, Z2)
    zdiff = Z1 - Z2;
    C = contours(X, Y, zdiff, [0 0]);
    XL = C(1, 2:end);
    YL = C(2, 2:end);
    ZL = interp2(X, Y, Z1, XL, YL);
end