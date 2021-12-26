function eigvector=getStationaryDistribution(state_matrix)
    % %%%%%%%%%Eigenvector with eigenvalue of 1
    [x,lumda]=eig(state_matrix');
    r1=abs(sum(lumda));
    q=find(r1==max(r1));
    max_x=x(:,q);%
    eigvector=max_x/sum(max_x); % stationnary distribution
end