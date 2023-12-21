clear all; close all; clc;
!rm -r codegen/

% calculateSARpredefvars(cellSARcalcinfo, celllabeling, enl, nuofsamples, nutomatindices, nxcalc, nycalc, nzcalc, maxSARvox, singlecellvolume)

vectorType1 = coder.typeof(0, [inf 1], [0 0]);
vectorType2 = coder.typeof(0, [inf inf inf], [0 0 0]);
vectorType3 = coder.typeof(0, [inf 3], [0 0]);
vectorType4 = coder.typeof(0, [inf 2], [0 0]);
codegen calculateSARpredefvars -o calculateSARpredefvars_mex ...
    -args {vectorType4,vectorType1, 0, 0, vectorType3, vectorType2, 0, 0, 0, vectorType1, 0} % ...
    % -globals {'enl', 0, 'maim', 0, 'massacc', 0}