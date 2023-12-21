function [x,y,z] = centerofacell(i,j,k,xlocs, ylocs, zlocs)
nxoffset = therange(1) - 1;
nyoffset = therange(2) - 1;
nzoffset = therange(3) - 1;

x = xlocs(i-nxoffset);
y = ylocs(j-nyoffset);
z = zlocs(k-nzoffset);
end