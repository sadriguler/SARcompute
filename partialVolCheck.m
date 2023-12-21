function [check, activeVolVoxels] = partialVolCheck(N, appratio, theintcells)
Vol = (N - 2 + 2*appratio) ^ 3;
Vol90p = Vol*9/10;

activeVolVoxels = double(theintcells~=1);

FaceVol = appratio;
activeVolVoxels(2:N-1,2:N-1,1) = activeVolVoxels(2:N-1,2:N-1,1)*FaceVol;
activeVolVoxels(2:N-1,2:N-1,N) = activeVolVoxels(2:N-1,2:N-1,N)*FaceVol;
activeVolVoxels(2:N-1,1,2:N-1) = activeVolVoxels(2:N-1,1,2:N-1)*FaceVol;
activeVolVoxels(2:N-1,N,2:N-1) = activeVolVoxels(2:N-1,N,2:N-1)*FaceVol;
activeVolVoxels(1,2:N-1,2:N-1) = activeVolVoxels(1,2:N-1,2:N-1)*FaceVol;
activeVolVoxels(N,2:N-1,2:N-1) = activeVolVoxels(N,2:N-1,2:N-1)*FaceVol;

SideVol = appratio*appratio;
activeVolVoxels(2:N-1,1,1) = activeVolVoxels(2:N-1,1,1)*SideVol;
activeVolVoxels(2:N-1,1,N) = activeVolVoxels(2:N-1,1,N)*SideVol;
activeVolVoxels(2:N-1,N,1) = activeVolVoxels(2:N-1,N,1)*SideVol;
activeVolVoxels(2:N-1,N,N) = activeVolVoxels(2:N-1,N,N)*SideVol;
activeVolVoxels(1,2:N-1,1) = activeVolVoxels(1,2:N-1,1)*SideVol;
activeVolVoxels(1,2:N-1,N) = activeVolVoxels(1,2:N-1,N)*SideVol;
activeVolVoxels(N,2:N-1,1) = activeVolVoxels(N,2:N-1,1)*SideVol;
activeVolVoxels(N,2:N-1,N) = activeVolVoxels(N,2:N-1,N)*SideVol;
activeVolVoxels(1,1,2:N-1) = activeVolVoxels(1,1,2:N-1)*SideVol;
activeVolVoxels(1,N,2:N-1) = activeVolVoxels(1,N,2:N-1)*SideVol;
activeVolVoxels(N,1,2:N-1) = activeVolVoxels(N,1,2:N-1)*SideVol;
activeVolVoxels(N,N,2:N-1) = activeVolVoxels(N,N,2:N-1)*SideVol;

CornerVol = appratio*appratio*appratio;
activeVolVoxels(1,1,1) = activeVolVoxels(1,1,1)*CornerVol;
activeVolVoxels(1,1,N) = activeVolVoxels(1,1,N)*CornerVol;
activeVolVoxels(1,N,1) = activeVolVoxels(1,N,1)*CornerVol;
activeVolVoxels(1,N,N) = activeVolVoxels(1,N,N)*CornerVol;
activeVolVoxels(N,1,1) = activeVolVoxels(N,1,1)*CornerVol;
activeVolVoxels(N,1,N) = activeVolVoxels(N,1,N)*CornerVol;
activeVolVoxels(N,N,1) = activeVolVoxels(N,N,1)*CornerVol;
activeVolVoxels(N,N,N) = activeVolVoxels(N,N,N)*CornerVol;

activeVol = sum(sum(sum(activeVolVoxels)));
if activeVol >= Vol90p
    check = 1;
else
    check = 0;
end

end