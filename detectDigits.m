function [result strings] = detectDigits(Image , Generic , color , Size , Price) 


strings = ones(0,10)*-2; 
Im=Color(Image , color);
if(Im==0 || Size  || Price)

I=adaptivethreshold(Image,25,0.01);
%I= bwareaopen(I,300);
se = strel('disk',1);
I = imopen(I,se);
% I= bwareaopen(I,300);
strings = NumbersRecognition(I , Image , Generic , Size , Price);
I = 1-I ;
strings = [strings ; NumbersRecognition(I , Image , Generic , Size , Price)];
result = I ;

elseif(Im>0&&Im<6)
    result=Im;
end

end     
