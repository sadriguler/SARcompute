%%% AUTHOR: SADRI GULER
% Maximum spatial-averaged SAR calculation of an antenna array. Electric field
% intensity distributions are imported from CST Microwave Studio 20XX and
% then worst case SAR calculation is applied. This calculation is
% applicable for hexahedral mesher. In hexahedral meshes, free-space is
% labeled as 0, therefore, a dummy voxel/cell/cube is added as the first
% cell to describe 0 density and 0 electric conductivity. Moreover, this is
% assigned as a tissue to the 1st tissue and tissue numbers are increased
% by one for the other tissues.

clear all; close all; %clc;

x = tic;
op = 2; % 1: write locs to the cubecenters.txt 2: calculate 10g SAR
numberofchannels = 8;
numberofrandPhases = 1000;
exAmp = [1 1 1 1 1 1 1 1];
exPhases = (rand(numberofrandPhases,numberofchannels)*360); % 250 samples of phases for all channels
% exPhases = [258.97 226.92 80.237 127.9 222.01 173.44 52.982 334.76];
% exPhases = [0 0 0 0 0 0 0 0];
modelname = 'Duke'; % Duke, Ella, SM1, SM2
maim = 10;
massacc = 0.0001/100; %
% outputdim = [49 49 5]; % needs to be decided before
global celllabeling;
global cellmass;
global usedVoxSAR;


maxSARs = zeros(numberofrandPhases,9);
%%% model details:::
[filename, therange, nx, ny, nz, tissuefilename, excoffset] = modelsel(modelname);
dx = 5; dy = 5; dz = 5; % resolution in each direction in mm's
offset = 0;

filename = strcat(filename,'.raw');
fileID=fopen(filename,'r');
% free space is labeled as 0 in Duke data, and all other tissues are
% labeled with positive numbers. Therefore, the labels are increased by 1
% to easen the access to the tissue parameters during the SAR calculation.
if strcmp(modelname, 'SM1') || strcmp(modelname, 'SM2')
    % This is actually a TEMPORARY SOLUTION. The reason behind the mistake is that
    % tissues are labeled starting from zero rather than one in the tissues
    % file of the SM1 model.
    model=fread(fileID,[nx*ny*nz],'char') + 2;
else
    model=fread(fileID,[nx*ny*nz],'char') + 1;
end
fclose(fileID);

model = reshape(model,[nx,ny,nz]);
B = model;
% 3D model is also trimmed for the local calculation
model = model(therange(1)+1:therange(4),therange(2)+1:therange(5),therange(3)+1:therange(6));

nxcalc = therange(4) - therange(1);
nycalc = therange(5) - therange(2);
nzcalc = therange(6) - therange(3);
enl = 10; % enlargement is applied due to the computation benefits
A = zeros(nxcalc+2*enl ,nycalc+2*enl ,nzcalc+2*enl );
A(enl+1:enl+nxcalc,enl+1:enl+nycalc,enl+1:enl+nzcalc) = model;

% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% This needs to be edited!!! The function is custom made for Duke!!!!!!!!!
[xlocs, ylocs, zlocs] = findVoxCenters(therange, modelname);

tissuedata = importdata(tissuefilename);
tissuedata = tissuedata.data;
electrcond = [0; tissuedata(:,4)];
tissuedens = [1; tissuedata(:,5)];
colordata = [0 0 0.2; tissuedata(:,10:12)/255];
tissuesnotcalculated = find(tissuedens==0);
tissuesnotcalculated = [1; tissuesnotcalculated];

display('Counting started!');
Acalc = zeros(nx+2*enl,ny+2*enl,nz+2*enl);
nuofsamples = 1; % start number of samples from one to count surrounding space
% as a specific tissue for easy calculations later; this first sample is
% assigned to free space.
for indx = 1+enl:nxcalc+enl
    for indy = 1+enl:nycalc+enl
        for indz = 1+enl:nzcalc+enl
            if ~ismember(A(indx,indy,indz),tissuesnotcalculated)
                nuofsamples = nuofsamples + 1;
                Acalc(indx,indy,indz) = 1;
            end
        end
    end
end

display('Create index matrices!');
nutomatindices = zeros(nuofsamples,3);
mattonuindices = ones(nxcalc+2*enl,nycalc+2*enl,nzcalc+2*enl);
celltype = ones(nuofsamples,1);
celltype(1) = 1; % first cell is assigned to free space
nuofsamples = 1;
for indx = 1+enl:nxcalc+enl
    for indy = 1+enl:nycalc+enl
        for indz = 1+enl:nzcalc+enl
            if  Acalc(indx,indy,indz) == 1
                nuofsamples = nuofsamples + 1;
                nutomatindices(nuofsamples,:) = [indx,indy,indz];
                mattonuindices(indx,indy,indz) = nuofsamples;
                celltype(nuofsamples,1) = A(indx,indy,indz);
            end
        end
    end
end

zlocs = zlocs-5;
display('Prepare sample coordinates');
xcoords = xlocs(nutomatindices(2:nuofsamples,1)-enl);
ycoords = ylocs(nutomatindices(2:nuofsamples,2)-enl);
zcoords = zlocs(nutomatindices(2:nuofsamples,3)-enl);

% coordinate transformations of the interested body
[xcoords,ycoords,zcoords,xlocs,ylocs,zlocs] = ...
    modeltransformation(xcoords,ycoords,zcoords,xlocs,ylocs,zlocs,'HeadNeckTD_onBedCopper-Duke');
thecoords = [xcoords,ycoords,zcoords];
if op == 1 % write calculated coordinates of each voxel to a txt file
    fileID = fopen('cubecenters.txt','wt');
    fprintf(fileID,'%f\t%f\t%f\n',transpose(thecoords));
    fclose(fileID);
elseif op == 2
    display('Calculate SAR related parameters');
    singlecellvolume = dx/1000*dy/1000*dz/1000; % in m3
    celldensity = tissuedens(celltype);
    cellcond = electrcond(celltype);
    cellmass = singlecellvolume*celldensity*1000; % in g

    display('Electric field import!');
    Es = zeros(nuofsamples,3,numberofchannels);
    for theAC = 1:numberofchannels
        [~, thefield] = importfield(strcat('./fieldResults/',['e-field (f=298) [AC' num2str(theAC + excoffset) '].txt']));
        thefield = thefield(1:nuofsamples-1,:);
        Es(2:nuofsamples,:,theAC) = thefield;
        display(['Part-' num2str(theAC) ' is done!']);
    end

    %     display('Magnetic field import!');
    %     B1ps = zeros(outputdim(1)*outputdim(2)*outputdim(3),numberofchannels);
    %     for theAC = 1:numberofchannels
    %         %         filename = [foldername,'B1p' num2str(theAC) '.csv'];
    %         filename = strcat('./fieldResults/',modelname,['/B1- (f=298) [AC' num2str(theAC + excoffset) '].txt']);
    %         thefile = importdata(filename);
    %         B1ps(:,theAC) = thefile.data(:,8) + 1i*thefile.data(:,9);
    %         display(['Part-' num2str(theAC) ' is done!']);
    %     end

    for phasesample = 1:numberofrandPhases
        exPhs = exPhases(phasesample,:);
        Eabs2 = zeros(nuofsamples-1,3);
        for exc = 1:numberofchannels
            Eabs2 = Eabs2 + Es(2:nuofsamples,:,exc)*exAmp(exc)*exp(1i*exPhs(exc)/180*pi);
        end
        Eabs2 = abs(Eabs2(:,1)).^2+abs(Eabs2(:,2)).^2+abs(Eabs2(:,3)).^2;

        maxSARvox = zeros(nuofsamples,1);
        maxSARvox(2:nuofsamples) = Eabs2.*cellcond(2:nuofsamples)./celldensity(2:nuofsamples);



        display(['Calculating ' num2str(phasesample) '. excitation...']);
        if phasesample == 1
            [averageSARs, cellSARcalcinfo] = ...
                calculateSAR(enl, maim, massacc, nuofsamples, mattonuindices, nutomatindices, singlecellvolume, maxSARvox);
        else
            averageSARs = calculateSARpredefvars_mex(cellSARcalcinfo, celllabeling, enl, nuofsamples, nutomatindices,mattonuindices, nxcalc, nycalc, nzcalc, maxSARvox, singlecellvolume);
        end

        SARs_v2 = zeros(nxcalc,nycalc,nzcalc); % SAR calculated on the points associated with the data size
        for isample = 2:nuofsamples
            indx = nutomatindices(isample,1)-enl;
            indy = nutomatindices(isample,2)-enl;
            indz = nutomatindices(isample,3)-enl;
            SARs_v2(indx,indy,indz) = averageSARs(isample);
        end
        maxSARs(phasesample,:) = [max(max(max(SARs_v2)))/2,exPhases(phasesample,:)];

        xr1 = find(xlocs==-127);
        xr2 = find(xlocs==123);
        yr1 = find(ylocs==-121);
        yr2 = find(ylocs==134);
        zr = 75;
        SARfilename = strcat('fieldResults','/SAR (f=298) [AC9] (10g).txt');

        if strcmp(modelname, 'Duke')
            SARmidplane = SARs_v2(xr1:xr2,yr1:yr2, zr)/2;
        elseif strcmp(modelname, 'Ella')
            SARmidplane = flipud(SARs_v2(xr2:xr1,yr1:yr2, zr)/2);
        end
        csvwrite(strcat('calculatedFields/',['/SAR' num2str(phasesample) '.csv']),SARmidplane)

        % SARex = importdata(SARfilename);
        % SARex = SARex.data(:,4);
        % [locs, ind] = find(SARex>0);
        % mask = zeros(length(SARex),1);
        % mask(locs) = 1;

        %         B1p = zeros(outputdim(1)*outputdim(2)*outputdim(3),1);
        %         for exc = 1:numberofchannels
        %             B1p = B1p + B1ps(:,exc)*exAmp(exc)*exp(1i*exPhs(exc)/180*pi);
        %         end
        %         B1p = B1p.*mask;
        %         B1p = [real(B1p),imag(B1p)];
        %         csvwrite(strcat('calculatedFields/',modelname,['/B1p' num2str(phasesample) '.csv']),B1p)
        display(['Calculation for phase number ' num2str(phasesample) ' is done!']);
    end
else% plotting
    warning('opt should be either 1 (for cubecenters.txt) or 2 (SAR calculation).')
end
display(['Computation time: ' num2str(toc(x)) ' seconds']);

csvwrite(['maxSARs.csv'],maxSARs);