% function [xlocs, ylocs, zlocs] = findVoxCenters(nx,ny,nz,dx,dy,dz,therange)
function [xc, yc, zc] = findVoxCenters(therange, modelname)

if strcmp(modelname,'Duke')
    xc = transpose(linspace(-300,305,122));
    yc = transpose(linspace(150,-155, 62));
    zc = transpose(linspace(925,-930,372));
    
    xc = xc(therange(1)+1:therange(4));
    yc = yc(therange(2)+1:therange(5));
    zc = zc(therange(3)+1:therange(6));
elseif strcmp(modelname, 'Ella')
    xc = transpose(linspace(-260,265,106));
    yc = transpose(linspace(145,-150, 60));
    zc = transpose(linspace(835,-840,336));
elseif strcmp(modelname, 'SM1')
    xc = transpose(linspace(-262.5,267.5,107));
    yc = transpose(linspace(262.5,-267.5,107));
    zc = transpose(linspace(170,-175,70));
elseif strcmp(modelname, 'SM2')
    xc = transpose(linspace(-195,200,80));
    yc = transpose(linspace(220,-225,90));
    zc = transpose(linspace(220,-225,90));
else
    error('Only possible options are Duke, Ella, and SM1!');
end
end