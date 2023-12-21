function [xp1, yp1, zp1, xp2, yp2, zp2] = unusedCubeLimits(indx, indy, indz, cubeoffset, cubetype)

if cubetype == 1
    xp1 = indx;
    yp1 = indy-cubeoffset;
    zp1 = indz-cubeoffset;
    xp2 = indx+2*cubeoffset;
    yp2 = indy+cubeoffset;
    zp2 = indz+cubeoffset;
elseif cubetype == 2
    xp1 = indx-2*cubeoffset;
    yp1 = indy-cubeoffset;
    zp1 = indz-cubeoffset;
    xp2 = indx;
    yp2 = indy+cubeoffset;
    zp2 = indz+cubeoffset;
elseif cubetype == 3
    xp1 = indx-cubeoffset;
    yp1 = indy;
    zp1 = indz-cubeoffset;
    xp2 = indx+cubeoffset;
    yp2 = indy+2*cubeoffset;
    zp2 = indz+cubeoffset;
elseif cubetype == 4
    xp1 = indx-cubeoffset;
    yp1 = indy-2*cubeoffset;
    zp1 = indz-cubeoffset;
    xp2 = indx+cubeoffset;
    yp2 = indy;
    zp2 = indz+cubeoffset;
elseif cubetype == 5
    xp1 = indx-cubeoffset;
    yp1 = indy-cubeoffset;
    zp1 = indz;
    xp2 = indx+cubeoffset;
    yp2 = indy+cubeoffset;
    zp2 = indz+2*cubeoffset;
elseif cubetype == 6
    xp1 = indx-cubeoffset;
    yp1 = indy-cubeoffset;
    zp1 = indz-2*cubeoffset;
    xp2 = indx+cubeoffset;
    yp2 = indy+cubeoffset;
    zp2 = indz;
end

end