function scalar = Myfun(img)
%% guassain mask filter of weight
sigma = 5;
Weight = fspecial('gaussian',[sigma,sigma],1);
scalar = sum(sum((double(img).*Weight)))/(sigma^2);

