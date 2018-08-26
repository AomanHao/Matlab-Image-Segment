function trimap=getTrimap(simg)

% GETTRIMAP     Enables the user to enter trimap for the given image using
%   a simple polygonal interface. Instructions will appear in MATLAB
%   command line
%   The resulting trimap will have the same size as simg, with values 0,1
%   and 0.5 at pixels marked background, foreground and unknown
%   respectively.
%
%   Author: Michael Rubinstein
%

simg=im2double(simg);
% defines the source polygon
figure('Name','Enter Trimap','NumberTitle','off');
imshow(simg);
fprintf('====>Mark foreground region\n');
fprintf('====>Define polygon with left mouse clicks and terminate with a right click\n');
[smap,sxi,syi]=roipoly; sxi=floor(sxi); syi=floor(syi);

trimap=zeros(size(smap));
trimap(smap)=1;
hold on;
im2=.5*(simg+repmat(trimap,[1,1,3])); % for display
imshow(im2);

fprintf('====>Mark unknown region\n');
fprintf('====>Define polygon with left mouse clicks and terminate with a right click\n');

kmap=roipoly;
trimap(kmap&~smap)=0.5;
im2=.5*(simg+repmat(trimap,[1,1,3])); % for display
imshow(im2);

