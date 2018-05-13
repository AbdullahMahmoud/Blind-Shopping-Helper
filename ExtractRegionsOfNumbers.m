function [ Results ] = ExtractRegionsOfNumbers(I , Generic , Size)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
CC = bwconncomp(I);
bounds = regionprops(CC,'all');
[h w] = size(bounds);
NearestRegion = zeros(2,h);
Visited = zeros(1,h);
for i=1:h
    MainX = bounds(i).BoundingBox(1);
    MainY = bounds(i).BoundingBox(2);
    MainWidth = bounds(i).BoundingBox(3);
    MainHieght = bounds(i).BoundingBox(4);
    if(Generic && ~(MainHieght > 25 && MainHieght < 300 && MainWidth > 20 && MainWidth < 300 &&  bounds(i).Extent >.3 && bounds(i).Area > 200 && (max(MainHieght,MainWidth)/min(MainHieght,MainWidth))>=1 && (max(MainHieght,MainWidth)/min(MainHieght,MainWidth))<=3 ))
        continue;
    elseif(~Generic && ~(MainHieght > 30 && MainHieght < 100 && MainWidth > 30 && MainWidth < 110 &&  bounds(i).Extent >.3 && bounds(i).Area > 500 && (max(MainHieght,MainWidth)/min(MainHieght,MainWidth))>=1 && (max(MainHieght,MainWidth)/min(MainHieght,MainWidth))<=3 ))
        continue;
    end
    for j=1 : h
        NearX = bounds(j).BoundingBox(1);
        NearY = bounds(j).BoundingBox(2);
        NearWidth = bounds(j).BoundingBox(3);
        NearHieght = bounds(j).BoundingBox(4);
        if(i == j || Generic && ~(bounds(j).Extent >.3 && bounds(j).Area > 200 && NearHieght > 25 && NearHieght < 300 && NearWidth > 20 && NearWidth < 300 )) 
            continue;
        elseif(i == j ||~Generic && ~(bounds(j).Extent >.3 && bounds(j).Area > 500 && NearHieght > 30 && NearHieght < 100 && NearWidth > 30 && NearWidth < 110 )) 
            continue;
        end
        if((max(NearHieght,NearWidth)/min(NearHieght,NearWidth))>=1 && (max(NearHieght,NearWidth)/min(NearHieght,NearWidth))<=3 && abs(MainHieght - NearHieght)<=10 && abs(NearY - MainY) <= NearHieght/4  && NearX - MainX>=MainWidth - 10 && NearX - MainX<=MainWidth+10)                                                                        
            NearestRegion(:,i) = [i;j];
            Visited(:,j) = 1;
        end
    end
end
Results = zeros(0,10);
for i=1 : h
    if(NearestRegion(1,i) ~= 0 && Visited(1,i) == 0)
        k=i;
        j=1;
        TmpRes = zeros(1,10);
        TmpRes(:,j) = NearestRegion(1,k);
        Flag = 0;
        IC=imcrop(I,bounds(NearestRegion(1,k)).BoundingBox);
        SE = strel('square',3);
        IC = imerode(IC,SE);
        IC = bwareaopen(IC, 50);
        CC = bwconncomp(IC);
        if(CC.NumObjects == 1)
            Flag = 1;
        end
        while NearestRegion(1,k) ~= 0 % && Flag
            j = j + 1;
            IC=imcrop(I,bounds(NearestRegion(2,k)).BoundingBox);
            SE = strel('square',3);
            IC = imerode(IC,SE);
            IC = bwareaopen(IC, 50);
            CC = bwconncomp(IC);
            if(CC.NumObjects == 1)
                Flag = 1;
            end
            TmpRes(:,j) = NearestRegion(2,k);
            k = NearestRegion(2,k);
        end
        if Size && j == 2 && Flag
            Results = [Results ; TmpRes];
        elseif ~Size && Flag
            Results = [Results ; TmpRes];
        end
    end
end
end