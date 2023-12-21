function volumes = artcuberatios(rho,offset)
N = 2*offset+1;
volumes = zeros(N,N,N);
% corners
theratio = rho^3;
volumes(1,1,1) = theratio;
volumes(1,1,end) = theratio;
volumes(1,end,1) = theratio;
volumes(1,end,end)= theratio;
volumes(end,1,1) = theratio;
volumes(end,1,end) = theratio;
volumes(end,end,1) = theratio;
volumes(end,end,end)= theratio;

% edges
theratio = rho^2;
volumes(1,2:end-1,1) = theratio;
volumes(end,2:end-1,1) = theratio;
volumes(1,2:end-1,end) = theratio;
volumes(end,2:end-1,end) = theratio;
volumes(1,1,2:end-1) = theratio;
volumes(end,1,2:end-1) = theratio;
volumes(1,end,2:end-1) = theratio;
volumes(end,end,2:end-1) = theratio;
volumes(2:end-1,1,1) = theratio;
volumes(2:end-1,1,end) = theratio;
volumes(2:end-1,end,1) = theratio;
volumes(2:end-1,end,end) = theratio;

% sides
theratio = rho;
volumes(1,2:end-1,2:end-1) = theratio;
volumes(end,2:end-1,2:end-1) = theratio;
volumes(2:end-1, 1,2:end-1) = theratio;
volumes(2:end-1, end,2:end-1) = theratio;
volumes(2:end-1, 2:end-1, 1) = theratio;
volumes(2:end-1, 2:end-1, end) = theratio;
end