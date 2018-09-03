% this function is used to evaluate the image segmentation results.
% H.C. Chen, S.J. Wang. The use of visible color difference in the
% quantitative evaluation of color image segmentation, in: Proceedings of
% ICASSP, 2004
% input: Im   -- original image
%        CMap -- class map
% output: value indicate the evaluation
% inter-intra region visual error
% NB: design for CIE l*a*b color space
% by Qinpei zhao 

function [Eintra, Einter] = EVisible(Im, CMap, th)

% image property
[Ih, Iw, d] = size(Im);
% segmentation no.
Rn = max(CMap(:));

% segmented image with average color of that region
Seg = zeros(Ih, Iw, d);
Rmean = zeros(Rn, d);
% for each region
for i = 1:Rn,
    sq = find(CMap == i);
    Si = length(sq);   
    for dim = 1:d,
        Aver_id = zeros(Ih, Iw);
        Ri = zeros(Ih, Iw);
        temp1 = Im(:,:,dim);
        Ri(sq) = temp1(sq);
        Aver_id(sq) = sum(Ri(:))/Si;
        Rmean(i,dim) = sum(Ri(:))/Si;
        Ri(sq) = Aver_id(sq);        
        Seg(:,:,dim) = Seg(:,:,dim) + Ri;
    end
end

% intra-region error
Diff = zeros(Ih, Iw, d);
Diff = double(Im) - Seg;
Diff = sqrt(Diff(:,:,1).^2 + Diff(:,:,2).^2 + Diff(:,:,3).^2);
th1 = repmat(th, Ih, Iw);
Eintra = length(find((Diff-th1)>0))/(Ih*Iw);

% inter-region error
E_diff = zeros(1, Rn*(Rn-1)/2);
E_diff(th-sqrt(pdist(Rmean))>0) = 1;
wts = [];
for t = 1:Rn,
    for s = t+1:Rn,
        R1 = zeros(Ih, Iw);
        sq1 = find(CMap == t);
        R1(sq1) = t;
        BRegion1 = imdilate(R1, [0 1 0; 1 1 1; 0 1 0]);
        Boundary1 = BRegion1 & ~R1;
        R2 = zeros(Ih, Iw);
        sq2 = find(CMap == s);
        R2(sq2) = s;
        BRegion2 = imdilate(R2, [0 1 0; 1 1 1; 0 1 0]);
        Boundary2 = BRegion2 & ~R2;
        R = R1 + R2;
        BRegion = imdilate(R, [0 1 0; 1 1 1; 0 1 0]);
        Boundary = BRegion & ~R;
        Bw = Boundary1+Boundary2-Boundary;
        Bw = bwmorph(Bw, 'thin');
        wts = [wts length(find(Bw))];       
    end
end

C = 1/6;
Einter = sum(wts.*E_diff)/(C*Ih*Iw);


