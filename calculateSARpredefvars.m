function averageSARs = calculateSARpredefvars(cellSARcalcinfo, celllabeling, enl, nuofsamples, nutomatindices, mattonuindices, nxcalc, nycalc, nzcalc, maxSARvox, singlecellvolume)

averageSARs = zeros(nuofsamples,1);
% maxSARvox3D = zeros(nxcalc+2*enl,nycalc+2*enl,nzcalc+2*enl);
% for ind = 2:nuofsamples
%     indx = nutomatindices(ind,1);
%     indy = nutomatindices(ind,2);
%     indz = nutomatindices(ind,3);
%     maxSARvox3D(indx,indy,indz) = maxSARvox(ind);
% end

for ind = 2:nuofsamples
    if celllabeling(ind) == 1
        cubeoffset = cellSARcalcinfo(ind,1);
        appratio = cellSARcalcinfo(ind,2);
        finalartcuberatio = artcuberatios(appratio,cubeoffset);
        finalartcuberatio(find(finalartcuberatio==0)) = 1;
        artcubevols = finalartcuberatio*singlecellvolume;
        
        indx = nutomatindices(ind,1);
        indy = nutomatindices(ind,2);
        indz = nutomatindices(ind,3);
        xp1 = indx-cubeoffset;
        yp1 = indy-cubeoffset;
        zp1 = indz-cubeoffset;
        xp2 = indx+cubeoffset;
        yp2 = indy+cubeoffset;
        zp2 = indz+cubeoffset;
        theintcells = mattonuindices(xp1:xp2,yp1:yp2,zp1:zp2);
        
        calSAR = sum(sum(sum(maxSARvox(theintcells).*artcubevols)))/sum(sum(sum(artcubevols.*double(theintcells~=1))));
        averageSARs(ind) = calSAR;
    end
end

end