% Keegan Donley
% Dec 5, 2017

% Open image
I = imread('Input.png');
% Initialize histogram
H = zeros(256);

% Calculate histogram
[l, w] = size(I);
for r = 1:l
    for c = 1:w
        index = I(r, c);
        index = index + 1;
        H(index) = H(index) + 1;
    end
end

% Display histogram
figure;
hist = bar(0:255, H, 'histc');

% Thresholding
q = zeros(255);
q(1) = H(1) / (l * w);
n = zeros(255);
u = zeros(255);
P = zeros(255);
max = 0;
index = 0;

sum = 0;
for j = 1:256
    sum = sum + j * H(j);
end
sum = sum / (l * w);

for i = 1:255
%     find sigma b^2 for each
%     pick the maximum value and use the corresponding i
%     if (sigb^2 > th; th = sigb^2
    P = H(i + 1) / (l * w);
    q(i + 1) = P + q(i);
    n(i + 1) = ((i + 1) * P) / q(i + 1) + q(i) * n(i) / q(i + 1);
    u(i + 1) = (sum - q(i + 1) * n(i + 1)) / (1 - q(i + 1));
    s1 = q(i + 1) * (1 - q(i + 1)) * (n(i + 1) - u(i + 1));
    s = s1 ^ 2;
    if (s > max)
        max = s;
        index = i;
    end
end
th = index
I2 = zeros(size(I));
I2 (find(I>=th)) = 255;
I2 (find(I<th)) = 0;
figure;
imshow(I2)
