function bw=adaptivethreshold(IM,ws,C,tm)
%ADAPTIVETHRESHOLD An adaptive thresholding algorithm that seperates the
%foreground from the background with nonuniform illumination.
%  bw=adaptivethreshold(IM,ws,C) outputs a binary image bw with the local 
%   threshold mean-C or median-C to the image IM.
%  ws is the local window size.
%  tm is 0 or 1, a switch between mean and median. tm=0 mean(default); tm=1 median.
%
%  Contributed by Guanglei Xiong (xgl99@mails.tsinghua.edu.cn)
%  at Tsinghua University, Beijing, China.
%
%  For more information, please see
%  http://h...content-available-to-author-only...c.uk/rbf/HIPR2/adpthrsh.htm

IM=imresize(IM,[700 700]);
if (nargin<3)
    error('You must provide the image IM, the window size ws, and C.');
elseif (nargin==3)
    tm=0;
elseif (tm~=0 && tm~=1)
    error('tm must be 0 or 1.');
end
 
IM=mat2gray(IM);
 
if tm==0
    mIM=imfilter(IM,fspecial('average',ws),'replicate');
else
    mIM=medfilt2(IM,[ws ws]);
end
sIM=mIM-IM-C;
bw=im2bw(sIM,0);
bw=imcomplement(bw);
% BW=imfill(bw,4);
BW = ordfilt2(bw,2,ones(3,3));
BW=not(BW);
 
 
lb = bwlabel(BW);
st = regionprops(lb, 'Area', 'PixelIdxList' );
toRemove = [st.Area] <500; % fix your threshold here
toRemove = [st.Area] >2500; % fix your threshold here
 
exImage = BW;
exImage( vertcat(st(toRemove).PixelIdxList ) ) = 0; % remove
 
   h = 1/3*ones(5,1);
    H = h*h';
    % im be your image
    exImage = filter2(H,exImage);
   % se = strel('line',5,2);
     %   exImage = imerode(exImage,se);
 
 
 
%BW = bwareaopen(bw, 900);
%Regions = regionprops(BW, 'BoundingBox', 'Area' );
 L = bwlabel(BW,4);
[r, c] = find(L==2);
rc = [r c];
 %figure,imshow(rc);
 
%rectangle('Position',Regions(1).BoundingBox,'edgecolor','g','linewidth',2);
%RegionOfNumbers = imcrop(I, Regions(1).BoundingBox);