function [mtotal, appratio, difference, finalartcube] = findappratioUnusedVox(maim, mp, mtotal, theintcells,cubeoffset, massacc, theCube)
global cellmass;
ratio = ((maim - mp) / (mtotal - mp)); % over-estimation ratio
appratio = (1-ratio)^(1/2); % geometric mean, maybe even a cubical one is a better approach
bodycells = double(theintcells~=1);
mtotal = sum(sum(sum(artcuberatiosUnused(appratio,cubeoffset,theCube).*cellmass(theintcells).*(bodycells))));
difference = (mtotal-maim)/maim;

while abs(difference) > massacc
    ratio = ((maim - mp) / (mtotal - mp));
    appratio = appratio*(ratio^(1/2));
    
    mtotal = sum(sum(sum(artcuberatiosUnused(appratio,cubeoffset,theCube).*cellmass(theintcells).*(bodycells))));
    difference = (mtotal-maim)/maim;
end

finalartcube = artcuberatiosUnused(appratio,cubeoffset,theCube);
end