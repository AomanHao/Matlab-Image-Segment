% this function is used to evaluate the image segmentation results.
% J.Liu and Y.H. Yang, "Multi-resolution color image segmentation," IEEE
% PAMI 16, pp.689-700,1994
% another version: 
% M. Borsotti, P. Campadelli, and R. Schettini, "Quantitiative evaluation
% of color image segmentation results," Pattern Recognitiion Letters 19,
% pp.741-747, 1998
% input: Im   -- original image
%        CMap -- class map
% output: value indicate the evaluation
% by Qinpei zhao 

function Score = LiuYang(Im, CMap)

% image property
[Ih, Iw, d] = size(Im);
% segmentation no.
Rn = max(CMap(:));

% within cluster
Rmean = zeros(Rn, d);
color_err = zeros(1, Rn);
% for each region
for i = 1:Rn,
    sqerr = 0;
    sq = find(CMap == i);
    Si = length(sq);
    for dim = 1:d,
        Ri = zeros(Ih, Iw);
        Aver_id = zeros(Ih, Iw);
        temp1 = Im(:,:,dim);
        Ri(sq) = temp1(sq);
        % Aver_id -- average value
        Aver_id(sq) = sum(Ri(:))/Si;
        Rmean(i,dim) = sum(Ri(:))/Si;
        % squared color error
        sqerr = sqerr + sum(sum((Ri - Aver_id).^2));
    end
    color_err(i) = sqerr / sqrt(Si); 
end
within_err = sum(color_err)/(sqrt(Rn));

% % between cluster
% between_err = sum(pdist(Rmean, 'euclidean')); 

Score = within_err;

