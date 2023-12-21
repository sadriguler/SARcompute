function theM = calcMass(themasses,rho,offset)
N = 2*offset-1;  % number of cubes in one edge minus two
theCornerM = [ themasses(1,1,1) themasses(1,1,end) themasses(1,end,1) themasses(1,end,end)...
    themasses(end,1,1) themasses(end,1,end) themasses(end,end,1) themasses(end,end,end)];
theM = sum(theCornerM)*(rho^3);

theEdgeM = [reshape([themasses(1,2:end-1,1) themasses(end,2:end-1,1) themasses(1,2:end-1,end) themasses(end,2:end-1,end)],[1,N*4]) ...
    reshape([themasses(1,1,2:end-1) themasses(end,1,2:end-1) themasses(1,end,2:end-1) themasses(end,end,2:end-1)],[1,N*4]) ...
    reshape([themasses(2:end-1,1,1) themasses(2:end-1,1,end) themasses(2:end-1,end,1) themasses(2:end-1,end,end)],[1,N*4]) ];
theM = theM + sum(sum(sum(theEdgeM)))*(rho^2);

theSideM = [reshape([themasses(1,2:end-1,2:end-1) themasses(end,2:end-1,2:end-1)],[1,2*(N^2)]) ...
    reshape([themasses(2:end-1, 1,2:end-1) themasses(2:end-1, end,2:end-1)],[1,2*(N^2)]) ...
    reshape([themasses(2:end-1, 2:end-1, 1) themasses(2:end-1, 2:end-1, end)],[1,2*(N^2)])];

theM = theM + sum(sum(sum(theSideM)))*rho;

end