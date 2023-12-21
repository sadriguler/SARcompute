function volumes = artcuberatiosUnused(rho,offset,theCube)
N = 2*offset+1;
volumes = zeros(N,N,N);
dx = ones(1,N);
dy = ones(1,N);
dz = ones(1,N);
if (theCube == 1) || (theCube == 2)
    if rho > 0.5
        if theCube == 1
            dx(end) = 2*rho-1;
        else
            dx(1) = 2*rho-1;
        end
    elseif rho <= 0.5
        if theCube == 1
            dx(end) = 0;
            dx(end-1) = 2*rho;
        else
            dx(1) = 0;
            dx(2) = 2*rho;
        end
    elseif rho > 1
        error("rho cannot be bigger than 1!");
    end
    dy(1) = rho;
    dy(end) = rho;
    
    dz(1) = rho;
    dz(end) = rho;
    
elseif (theCube == 3) || (theCube == 4)
    if rho > 0.5
        if theCube == 3
            dy(end) = 2*rho-1;
        else
            dy(1) = 2*rho-1;
        end
    elseif rho <= 0.5
        if theCube == 3
            dy(end) = 0;
            dy(end-1) = 2*rho;
        else
            dy(1) = 0;
            dy(2) = 2*rho;
        end
    elseif rho > 1
        error("rho cannot be bigger than 1!");
    end
    dx(1) = rho;
    dx(end) = rho;
    
    dz(1) = rho;
    dz(end) = rho;
elseif (theCube == 5) || (theCube == 6)
    if rho > 0.5
        if theCube == 5
            dz(end) = 2*rho-1;
        else
            dz(1) = 2*rho-1;
        end
    elseif rho <= 0.5
        if theCube == 5
            dz(end) = 0;
            dz(end-1) = 2*rho;
        else
            dz(1) = 0;
            dz(2) = 2*rho;
        end
    elseif rho > 1
        error("rho cannot be bigger than 1!");
    end
    dx(1) = rho;
    dx(end) = rho;
    
    dy(1) = rho;
    dy(end) = rho;
end
for indx = 1:N
    for indy = 1:N
        for indz = 1:N
            volumes(indx,indy,indz) = dx(indx)*dy(indy)*dz(indz);
        end
    end
end
end