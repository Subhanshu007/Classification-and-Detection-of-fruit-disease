clc;
clear all;
close all;
warning off all;

%% Read input image

[f,p] = uigetfile('*.jpg;*.bmp');
I = imread([p f]);
I = imresize(I,[256 256]);

if ndims(I) == 3
    g = rgb2gray(I);
else
    g = I;
end

th=50;

[m,n]=size(g);
ib=zeros(m,n);
 for r=1:m
     for c=1:n
         if g(r,c)<th
             ib(r,c)=1;
         end
     end
 end

 figure,imshow(ib,[]);
 
 hh = im2bw(g,0.3);
 new = hh;
  [m1,s5] = size(hh);
 for i = 1:m1
     for j = 1:s5
         if hh(i,j) == 0
             new1(i,j,1:3) = I(i,j,1:3);
         else
             new1(i,j,1:3) = 0;
         end
     end
 end
 figure,imshow(new1,[]);