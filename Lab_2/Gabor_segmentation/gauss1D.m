function G = gauss1D(sigma,kernel_size)
% Calculate 1D discrete Gaussian filter
counter = 1;
G = zeros(1,kernel_size);
for x = -floor(kernel_size/2):floor(kernel_size/2)
    G(counter) = exp(-x^2/(2*sigma^2))/(sigma*sqrt(2*pi)); % Gaussian function
    counter = counter+1;
end
sum_G = sum(G);
G = G./sum_G;
end
