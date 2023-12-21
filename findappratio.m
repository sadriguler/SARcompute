function [mtotal, appratio, difference, martcube, finalartcube] = findappratio(maim, mp, mtotal, theintcells,cubeoffset, massacc)
global cellmass;
ratio = ((maim - mp) / (mtotal - mp)); % over-estimation ratio
appratio = (1-ratio)^(1/2); % geometric mean, maybe even a cubical one is a better approach
bodycells = double(theintcells~=1);
martcube = artcuberatios(appratio,cubeoffset).*cellmass(theintcells).*(bodycells);
mtotal = sum(sum(sum(martcube))) + mp;
difference = (mtotal-maim)/maim;
while abs(difference) > massacc
    ratio = ((maim - mp) / (mtotal - mp));
    appratio = appratio*(ratio^(1/2));
    martcube = artcuberatios(appratio,cubeoffset).*cellmass(theintcells).*(bodycells);
    mtotal = sum(sum(sum(martcube))) + mp;
    difference = (mtotal-maim)/maim;
end
finalartcube = artcuberatios(appratio,cubeoffset);
finalartcube(find(finalartcube==0)) = 1;
end