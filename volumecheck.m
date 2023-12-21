function checkval = volumecheck(thecells,N)
vol = N*N*N;
vol10p = vol/10;
backgroundV = 0;
for ind1 = 1:size(thecells,1)
    for ind2 = 1:size(thecells,2)
        for ind3 = 1:size(thecells,3)
            if thecells(ind1,ind2,ind3) == 1 
                backgroundV = backgroundV + 1;
                if backgroundV > vol10p
                    checkval = 0; 
                    return;
                end
            end
        end
    end
end
checkval = 1;
return;
end