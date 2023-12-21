function mtotal = massBasicCube(theintcells,cellmass)
mtotal = 0;
dim = size(theintcells,1);
for ind1 = 1:dim
    for ind2 = 1:dim
        for ind3 = 1:dim
            if theintcells(ind1,ind2,ind3) ~= 1
                mtotal = mtotal + cellmass(theintcells(ind1,ind2,ind3));
            end
        end
    end
end
end