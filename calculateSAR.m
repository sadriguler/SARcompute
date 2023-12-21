function [averageSARs, cellSARcalcinfo] = ...
    calculateSAR(enl, maim, massacc, nuofsamples, mattonuindices, nutomatindices, singlecellvolume,maxSARvox)

global celllabeling;
global cellmass;
global usedVoxSAR;

averageSARs = zeros(nuofsamples,1);

% thedummyrange = therange;
% thedummyrange(1:3) = thedummyrange(1:3) + 1;

counter = 1;
celllabeling = zeros(nuofsamples,1); % 1: used 2: calculated
celllabeling(1) = 1;
usedVoxSAR = zeros(nuofsamples,1);
cellSARcalcinfo = zeros(nuofsamples,2);
calcMasses = zeros(nuofsamples,1);
for indVox = 2:nuofsamples
    %     tissuetype = celltype(ind);
    mtotal = cellmass(indVox);
    if mtotal >  maim % if resolution is very low, dont try to deal with that box
        averageSARs(indVox) = maxSARvox(indVox);
    else
        indx = nutomatindices(indVox,1);
        indy = nutomatindices(indVox,2);
        indz = nutomatindices(indVox,3);
        cubeoffset = 0;
        prevVcheck = 1;
        difference = 1;
        while ((abs(difference) > massacc) && (cubeoffset < 3))
            cubeoffset = cubeoffset + 1;
            dim = 2*cubeoffset+1;
            xp1 = indx-cubeoffset;
            yp1 = indy-cubeoffset;
            zp1 = indz-cubeoffset;
            xp2 = indx+cubeoffset;
            yp2 = indy+cubeoffset;
            zp2 = indz+cubeoffset;
            theintcells = mattonuindices(xp1:xp2,yp1:yp2,zp1:zp2);
            Vcheck = volumecheck(theintcells,2*cubeoffset+1);
            if Vcheck
                mtotal = massBasicCube(theintcells,cellmass);
                difference = (mtotal-maim)/maim;
                if abs(difference) < massacc
                    calcMasses(indVox) = mtotal;
                elseif mtotal > maim
                    [mtotal, appratio, difference, martcube, finalartcuberatio] = findappratio(maim, mp, mtotal, theintcells,cubeoffset, massacc);
                    [volCheck, activeVols] = partialVolCheck(2*cubeoffset+1, appratio, theintcells);
                    if volCheck == 1
                        counter  = counter + 1;
                        calcMasses(indVox) = mtotal;
                        
                        cellSARcalcinfo(indVox,:) = [cubeoffset, appratio];
                        artcubevols = finalartcuberatio*singlecellvolume;
                        calSAR = sum(sum(sum(maxSARvox(theintcells).*artcubevols)))/sum(sum(sum(artcubevols.*double(theintcells~=1))));
                        averageSARs(indVox) = calSAR;
                        
                        labelcells(theintcells,dim,activeVols,calSAR);
                        celllabeling(indVox) = 1; % calculated
                    end
                end
                mp = mtotal;
            elseif prevVcheck
                mtotal = massBasicCube(theintcells,cellmass);
                difference = (mtotal-maim)/maim;
                if abs(difference) < massacc
                    calcMasses(indVox) = mtotal;
                elseif mtotal > maim
                    [mtotal, appratio, difference, martcube, finalartcuberatio] = findappratio(maim, mp, mtotal, theintcells,cubeoffset, massacc);
                    [volCheck, activeVols] = partialVolCheck(2*cubeoffset+1, appratio, theintcells);
                    if volCheck == 1
                        counter  = counter + 1;
                        calcMasses(indVox) = mtotal;
                        
                        cellSARcalcinfo(indVox,:) = [cubeoffset, appratio];
                        artcubevols = finalartcuberatio*singlecellvolume;
                        calSAR = sum(sum(sum(maxSARvox(theintcells).*artcubevols)))/sum(sum(sum(artcubevols.*double(theintcells~=1))));
                        averageSARs(indVox) = calSAR;
                        
                        labelcells(theintcells,dim,activeVols,calSAR);
                        celllabeling(indVox) = 1; % calculated
                    end
                end
                mp = mtotal;
            end
            prevVcheck = Vcheck;
        end
    end
    if ~mod(counter,5000)
        display(['Mood is good: ' num2str(counter) '/' num2str(nuofsamples) '']);
    end
end

usedvoxels = find(celllabeling == 2);
for indVox = 1:length(usedvoxels)
    j = usedvoxels(indVox);
    counter = counter + 1;
    averageSARs(j) = usedVoxSAR(j);
    if ~mod(counter,5000)
        display(['Mood is good: ' num2str(counter) '/' num2str(nuofsamples) '']);
    end
end

% unusedVoxels = find(celllabeling == 0);
% for j = 1:length(unusedVoxels)
%     indVox = unusedVoxels(j);
%     % if indVox == 31849
%     %    print('hello world!'); 
%     % end
%     counter = counter + 1;
% 
%     indx = nutomatindices(indVox,1);
%     indy = nutomatindices(indVox,2);
%     indz = nutomatindices(indVox,3);
%     sixCubeSARs = zeros(1,6);
%     sixCubeVolumes = ones(1,6)*1e6;
%     for theExtendedCube = 1:6
%         mtotal = cellmass(indVox);
%         cubeoffset = 0;
%         while ((mtotal < maim) && (cubeoffset < enl/2))
%             mp = mtotal;
%             cubeoffset = cubeoffset + 1;
%             dim = 2*cubeoffset+1;
% 
% 
%             [xp1, yp1, zp1, xp2, yp2, zp2] = unusedCubeLimits(indx, indy, indz, cubeoffset, theExtendedCube);
%             theintcells = mattonuindices(xp1:xp2,yp1:yp2,zp1:zp2);
%             bodycells = double(theintcells~=1);
%             mtotal = sum(sum(sum(cellmass(theintcells).*bodycells)));
%         end
%         if mtotal > maim
%             %%% find ratio
%             [mtotal, appratio, difference, finalartcuberatio] = findappratioUnusedVox(maim, mp, mtotal, theintcells,cubeoffset, massacc, theExtendedCube);
%             sixCubeSARs(theExtendedCube) = sum(sum(sum(maxSARvox(theintcells).*finalartcuberatio)))/sum(sum(sum(finalartcuberatio.*double(theintcells~=1))));
%             sixCubeVolumes(theExtendedCube) = (2*cubeoffset-1+2*appratio)^3;
%         end
%     end
% 
%     [val, ind] = min(sixCubeVolumes);
%     candidates = find(sixCubeVolumes<val*1.05);
%     calSAR = max(sixCubeSARs(candidates));
%     averageSARs(indVox) = calSAR;
% end
end