function C=makeComposite(F,B,alpha)

% MAKECOMPOSITE     Creates new composite given foreground image F,
%   background image B and alpha channel.
%   Applies the following simple logic: if size(B)=size(F), then the
%   foreground is simply composed on the background image. Otherwise, the
%   user will be able to choose where to place the foreground object in the
%   new composition. Use left mouse clicks to change the location and right
%   mouse click to confirm the decision.
%
%   If the function is called with B=[], the foreground will be composed on
%   a black background.
%
%   Author: Michael Rubinstein
%

if isempty(B)
    B=zeros(size(F));
end

if ~isa(F,'double')
    F=im2double(F);
end
if ~isa(B,'double')
    B=im2double(B);
end

if all(size(F)==size(B))
    C=makeComposite_fixed(alpha,F,B);
else
    C=makeComposite_free(alpha,F,B);
end


function C=makeComposite_fixed(alpha,F,B)

alpha=repmat(alpha,[1,1,size(F,3)]);
C=alpha.*F+(1-alpha).*B;


function C=makeComposite_free(alpha,F,timg)

% calculate bounding box for matte
[y,x]=find(alpha~=0);
[h,w]=size(alpha);
xmin=min(x); ymin=min(y);
xmax=max(x); ymax=max(y);
ww=xmax-xmin+1; wh=ymax-ymin+1;
% extract bounding box data
F=F(ymin:ymax,xmin:xmax,:);
alpha=repmat(alpha(ymin:ymax,xmin:xmax),[1,1,size(timg,3)]);

% create interface
figure('Name','Create Composite','NumberTitle','off');
imagesc(timg);
C=timg;
while 1
    [x,y,btn]=ginput(1);
    if btn==3
        break;
    end
    tmp=timg;
    twinX=round(x)  ; twinY=round(y);
    if ( x<1 | y<1 | (twinY+wh)>size(timg,1) | (twinX+ww)>size(timg,2)),
        fprintf('====>Out of bounds, or paste area exceeds image area. Try again!\n\n');
    else,
        B=tmp(twinY:(twinY+wh-1),twinX:(twinX+ww-1),:);
        tmp(twinY:(twinY+wh-1),twinX:(twinX+ww-1),:)=alpha.*F+(1-alpha).*B;
        C=tmp;
        imagesc(C);
    end;
end;

close;

