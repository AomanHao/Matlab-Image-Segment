function [F,B,alpha]=solve(mu_F,Sigma_F,mu_B,Sigma_B,C,sigma_C,alpha_init,maxIter,minLike)

% SOLVE     Solves for F,B and alpha that maximize the sum of log
%   likelihoods at the given pixel C.
%   input:
%   mu_F - means of foreground clusters (for RGB, of size 3x#Fclusters)
%   Sigma_F - covariances of foreground clusters (for RGB, of size
%   3x3x#Fclusters)
%   mu_B,Sigma_B - same for background clusters
%   C - observed pixel
%   alpha_init - initial value for alpha
%   maxIter - maximal number of iterations
%   minLike - minimal change in likelihood between consecutive iterations
%
%   returns:
%   F,B,alpha - estimate of foreground, background and alpha
%   channel (for RGB, each of size 3x1)
%
    
I=eye(3);
vals=[];

for i=1:size(mu_F,2)
    mu_Fi=mu_F(:,i);
    invSigma_Fi=inv(Sigma_F(:,:,i));
            
    for j=1:size(mu_B,2)
        mubi=mu_B(:,j);
        invSigmabi=inv(Sigma_B(:,:,j));
        
        alpha=alpha_init;
        iter=1;
        lastLike=-realmax;
%         z=[];
        while (1)
            
            % solve for F,B
            A=[invSigma_Fi+I*(alpha^2/sigma_C^2) , I*alpha*(1-alpha)/sigma_C^2; 
               I*((alpha*(1-alpha))/sigma_C^2)  , invSigmabi+I*(1-alpha)^2/sigma_C^2];
             
            b=[invSigma_Fi*mu_Fi+C*(alpha/sigma_C^2); 
               invSigmabi*mubi+C*((1-alpha)/sigma_C^2)];
           
            X=A\b;
            F=max(0,min(1,X(1:3)));
            B=max(0,min(1,X(4:6)));
            
            % solve for alpha
            alpha=max(0,min(1,((C-B)'*(F-B))/sum((F-B).^2)));
            
            % calculate likelihood
            L_C=-sum((C-alpha*F-(1-alpha)*B).^2)/sigma_C;
            L_F=-((F-mu_Fi)'*invSigma_Fi*(F-mu_Fi))/2;
            L_B=-((B-mubi)'*invSigmabi*(B-mubi))/2;
            like=L_C+L_F+L_B;
            
%             fprintf('like=%.2f, iter=%d\n',like,iter);
%             z(iter)=like;
            
            if iter>=maxIter | abs(like-lastLike)<=minLike
                break;
            end
            
            lastLike=like;
            iter=iter+1;
        end
        
        % we need only keep the maximal value, but for now we keep all
        % values anyway as there are not many, and we can investigate them
        % later on
        val.F=F;
        val.B=B;
        val.alpha=alpha;
        val.like=like;
        vals=[vals val];
    end
end

% return maximum likelihood estimations
[t,ind]=max([vals.like]);
F=vals(ind).F;
B=vals(ind).B;
alpha=vals(ind).alpha;

