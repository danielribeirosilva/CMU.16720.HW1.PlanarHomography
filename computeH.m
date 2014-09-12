%Many of the steps coded here are unnecessary, but I did it to be easy to read
%and to have a notation and format that is identical to my solution on question 3

%p1, p2 are 2xN matrices
function [H2to1] = computeH(p1, p2)

    %get number of examples (N)
    N = size(p1,2);

    %append the 3rd column (of 1's)
    p2 = [p2; ones(1,N)]; %P2 is now 3xN

    %use these points to create the A matrix (the one from question 3)
    A = zeros(2*N,9);
    for i=1:N
        u = p1(1,i);
        v = p1(2,i);
        p2t = p2(:,i)';
        A(2*i - 1, :) = [p2t 0 0 0 -u*p2t];
        A(2*i, :) = [0 0 0 p2t -v*p2t];
    end

    %Get eigenvalues for A^t * A
    [V,D] = eig(A'*A);
    %get position of min eigenvalue
    [min_eigenvalue, pos] = min(diag(D));
    %get eivenvector of minimal eigenvalue (that's the solution to our problem)
    min_eigenvector = V(:,pos);
    
    
    %compute H
    H2to1 = vec2mat(min_eigenvector,3); %H is a 3x3 matrix
    
end