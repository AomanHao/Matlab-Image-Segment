
% Demonstrates alpha matte calculation and composition with new background
% Assumes the images folder is already extracted under the code
% directory.
%
% Author: Michael Rubinstein

im=imread('images/woman/input.png');
% trimap=imread('images/gandalf/trimap.png');

trimap=getTrimap(im);

p=makeParameters;
[F,B,alpha]=bayesmat(im,trimap,p);

figure;
imshow(im);
title('Input');

figure;
imshow(trimap);
title('Trimap');

figure;
imshow(alpha);
title('Alpha');

Bnew=imread('images/gandalf/background-small.png');
figure;
imshow(Bnew);
title('New background');

C=makeComposite(F,Bnew,alpha);
figure;
imshow(C);
title('Composite');

