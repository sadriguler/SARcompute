
function labelcells(theintcells,dim,activeVol,calSAR)
global celllabeling;
global usedVoxSAR;
for ind1 = 1:dim
    for ind2 = 1:dim
        for ind3 = 1:dim
            if (celllabeling(theintcells(ind1,ind2,ind3)) ~= 1) && (activeVol(ind1,ind2,ind3)>0.999)
                if celllabeling(theintcells(ind1,ind2,ind3)) == 2
                    if calSAR > usedVoxSAR(theintcells(ind1,ind2,ind3))
                        usedVoxSAR(theintcells(ind1,ind2,ind3)) = calSAR;
                    end
                else
                    celllabeling(theintcells(ind1,ind2,ind3)) = 2; % used
                    usedVoxSAR(theintcells(ind1,ind2,ind3)) = calSAR;
                end
            end
        end
    end
end

end