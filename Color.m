function result = Color(Image , color)
Image = imresize(Image , [50  50]);
[H W L] = size(Image);
img = uint8(zeros(H, W, L));

biege = 0;
black =  0;
brown = 0;
darkblue=0;
lightblue=0;
for row=1:H
	for col=1:W
				if(Image(row, col, 1) >= 200 && Image(row, col, 1) <= 240 && Image(row, col, 2) >= 170 && Image(row, col, 2) <= 200 && Image(row, col, 3) >=140 && Image(row, col, 3) <= 160)
					biege = biege +1;
		        elseif(Image(row, col, 1) >= 0 && Image(row, col, 1) <= 20 && Image(row, col, 2) >= 0 && Image(row, col, 2) <= 20 && Image(row, col, 3) >= 0 && Image(row, col, 3) <= 20)
		        	black = black+1;
		        elseif(Image(row, col, 1) >= 40 && Image(row, col, 1) <= 60 && Image(row, col, 2) >= 30 && Image(row, col, 2) <= 60 && Image(row, col, 3) >= 20 && Image(row, col, 3) <= 50)
					brown = brown+1;
				elseif(Image(row, col, 1) >= 10 && Image(row, col, 1) <= 50 && Image(row, col, 2) >= 10 && Image(row, col, 2) <= 50 && Image(row, col, 3) >= 40 && Image(row, col, 3) <= 90)
					darkblue=darkblue+1;
				elseif(Image(row, col, 1) >= 150 && Image(row, col, 1) <= 210 && Image(row, col, 2) >= 110 && Image(row, col, 2) <= 220 && Image(row, col, 3) >= 110 && Image(row, col, 3) <= 220)
					lightblue=lightblue+1;
				end

	end 
end


if((biege>1000 || color)&&biege == max(biege, max(black,max(brown,max(darkblue,lightblue)) )))
	result =1;
elseif((black>1000 || color)&&black == max(biege, max(black,max(brown,max(darkblue,lightblue)) )))
	result = 2;
elseif((brown>1000 || color)&&brown == max(biege, max(black,max(brown,max(darkblue,lightblue)) )))
	result = 3;
elseif((darkblue>1000 || color)&&darkblue == max(biege, max(black,max(brown,max(darkblue,lightblue)) )))
	result = 4;
elseif((lightblue>900 || color)&&lightblue == max(biege, max(black,max(brown,max(darkblue,lightblue)) )))
	result = 5;
else result=0;
end