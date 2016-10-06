function R = k_NNS(S, q, k) 
    N = length(S);

    D = zeros(N, 1);
    for n = 1:N
        D(n) = taxicab(S(n, 1), S(n, 2), q(1), q(2));
    end

    [~, I] = sort(D);

    R = S(I(1:k), :);
end