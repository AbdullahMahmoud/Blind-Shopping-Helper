function Results = NearestDigit( I , LD)
FDL = zeros(1,0);
[a b] = size(LD);
for i=1 : b
    path = num2str(LD(1,i));
    path= strcat(path,'.bmp');
    d = imread(path);
    [x y z] = size(d);
    if(z>1)
    d = rgb2gray(d);
    end
    d = im2bw(d);
    d = centerobject(d);
    FD= gfd(d,3,12);
    FDL = [FDL FD];
end
%Imput Image preparation 
I = im2bw(I);
I = centerobject(I);
FDI= gfd(I,3,12);
FDL = [FDI FDL];
%Predection
dist = pdist(FDL','cityblock');
dist_sf = squareform(dist);
%dist_sf
dist_sf(1,:) = [];
[M,I] = min(dist_sf);
Results = [M(1,1) LD(I(1,1))];
end

