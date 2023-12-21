function [xcoords,ycoords,zcoords,xlocs,ylocs,zlocs] = ...
    modeltransformation(xcoords,ycoords,zcoords,xlocs,ylocs,zlocs,modelname)

if strcmp(modelname, 'Duke')
    zcoords = zcoords + 875; zlocs = zlocs + 875;
    yorigin = (min(ylocs) + max(ylocs))/2;
    zorigin = (min(zlocs) + max(zlocs))/2;
    ycoords = ycoords - 2*(ycoords-yorigin); ylocs = ylocs - 2*(ylocs-yorigin);
    zcoords = zcoords - 2*(zcoords-zorigin); zlocs = zlocs - 2*(zlocs-zorigin);
    zcoords = zcoords - 231; zlocs = zlocs -231;
    xcoords = xcoords + 7.5; xlocs = xlocs + 7.5;
    ycoords = ycoords + 12.5; ylocs = ylocs + 12.5;
elseif strcmp(modelname, 'HeadNeckTD_onBedCopper-Duke')
    yorigin = (min(ylocs) + max(ylocs))/2;
    zorigin = (min(zlocs) + max(zlocs))/2;
    ycoords = ycoords - 2*(ycoords-yorigin); ylocs = ylocs - 2*(ylocs-yorigin);
    zcoords = zcoords - 2*(zcoords-zorigin); zlocs = zlocs - 2*(zlocs-zorigin);
    zcoords = zcoords + 650;    zlocs = zlocs + 650;
    xcoords = xcoords + 8;      xlocs = xlocs + 8;
    ycoords = ycoords + 14;     ylocs = ylocs + 14;
elseif strcmp(modelname, 'Ella')
    xorig = (min(xlocs) + max(xlocs))/2;
    yorig = (min(ylocs) + max(ylocs))/2;
    xcoords = 2*xorig - xcoords;        xlocs = 2*xorig - xlocs;
    ycoords = 2*yorig - ycoords;        ylocs = 2*yorig - ylocs;
    xcoords = xcoords - 10;             xlocs = xlocs - 10;
    zcoords = zcoords + 960;            zlocs = zlocs + 960;
elseif strcmp(modelname, 'SM1')
    % rotate -90 degree around x axis
    ycoordsnew = zcoords;       ylocsnew = zlocs;
    zcoordsnew =-ycoords;       zlocsnew =-ylocs;
    ycoords = ycoordsnew;       ylocs = ylocsnew;   
    zcoords = zcoordsnew;       zlocs = zlocsnew;
    % transformation [-10, 0, 1670]
    xcoords = xcoords - 10;     xlocs = xlocs - 10;
    zcoords = zcoords + 1670;   zlocs = zlocs + 1670;
    % offset due to the origin as center of the object during rotation
    zcoords = zcoords - 5;      zlocs = zlocs - 5; % 
elseif strcmp(modelname, 'SM2')
    % transformation [0, -20, 1580]
    ycoords = ycoords -20;      ylocs = ylocs - 20;
    zcoords = zcoords + 1580;   zlocs = zlocs + 1580;
else   
    error('Only possible options are Duke, Ella, and SM1!');
end
end