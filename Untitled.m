function X = dtft(x,n,w)
X = zeros(size(w));
    for i = 1:length(w)
        X(i) = sum(x.* exp(-1*j * w(i) * n));

    end
end