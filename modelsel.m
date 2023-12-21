function [filename, therange, nx, ny, nz, tissuefilename, excoffset] = modelsel(modelname)

if strcmp(modelname, 'Duke')
    filename = 'Duke_34y_V5_5mm';
    therange = [0 0 279 122 62 372];
    nx = 122;
    ny = 62;
    nz = 372;
    tissuefilename = 'Duke_34y_V5_5mm.tissues';
    excoffset = 0;
elseif strcmp(modelname, 'Ella')
    filename = 'Ella_26y_V2_5mm';
    therange = [0 0 0 106 60 85];
    nx = 106;
    ny = 60;
    nz = 336;
    tissuefilename = 'Ella_26y_V2_5mm_tissues.txt';
    excoffset = 0;
elseif strcmp(modelname, 'SM1')
    filename = 'SegmentationModel1';
    therange = [0 0 0 107 107  70];
    nx = 107;
    ny = 107;
    nz = 70;
    tissuefilename = 'SegmentationModel1.tissues';
    excoffset = 0;
elseif strcmp(modelname, 'SM2')
    filename = 'SegmentationModel2_v3';
    therange = [0 0 0 80 90 90];
    nx = 80;
    ny = 90;
    nz = 90;
    tissuefilename = 'UnknownHumanSubject_5mm.tissues';
    excoffset = 0;
else
    error('Only possible options are Duke, Ella, and SM1!');
end
end