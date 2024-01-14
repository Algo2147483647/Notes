function [x] = OrthogonalMatchingPursuit(A, b, s)
r = b;
lamb = [];
A_ = [];
x = zeros(size(A,2),1);

for i = 1 : s
    tmp = A' * r;
    [~, ind] = max(abs(tmp));
    lamb = [lamb, ind];
    A_ = [A_, A(:, ind)];

    tmp = pinv(A_) * b;

    for j = 1 : i
        x(lamb(j)) = tmp(j);
    end

    r = b - A * x;
end

end