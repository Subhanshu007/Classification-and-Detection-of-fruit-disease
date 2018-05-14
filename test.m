clc;
clear all;
close all;
warning off all;

%% Read input image

[f,p] = uigetfile('*.jpg;*.bmp');
I = imread([p f]);
I = imresize(I,[256 256]);


%% rgb to lab color space conversion

im = I;
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

figure('name','Input Image result');
subplot(221);imshow(I,[]);title('Input Image');
subplot(222);imshow(R,[]);title('Red band Image');
subplot(223);imshow(G,[]);title('Green band Image');
subplot(224);imshow(B,[]);title('Blue Image');

[L, a, b] = RGB2Lab(R, G, B);

figure('name','RGB to LAB color space result');
subplot(131);imshow(L,[]);title('L color space result');
subplot(132);imshow(a,[]);title('a color space result');
subplot(133);imshow(b,[]);title('b color space result');
labb = cat(3,L,a,b);
cform = makecform('srgb2lab');
lab = applycform(I,cform); 

figure('name','Input Image & L*a*b Color space Result');
subplot(121);imshow(I,[]);title('Input RGB image');
subplot(122);imshow(lab);title('L*a*b color space result');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);

%% K-Means segmentation

 cl = 4;
 [ABC,c] = k_means(ll,cl);
 [d,e]=size(c);
 for i=1:d
     for j=1:e
         if c(i,j)==3
             new(i,j)=0;
         else
             new(i,j)=c(i,j);
         end
     end
 end
 
 [m1,s5] = size(new);
 for i = 1:m1
     for j = 1:s5
         if new(i,j) == 0
             new1(i,j,1:3) = I(i,j,1:3);
         else
             new1(i,j,1:3) = 0;
         end
     end
 end
figure('name','K-Means Result'),
subplot(121);imshow(new,[]);title('K-means Result');
subplot(122);imshow(uint8(new1),[]);title('K-means result on input image');
 
 %% feature extraction
 
 %% global color histogram
 
figure('name','global color histogram result');
 subplot(131);imhist(R);title('Red band histogram');
 subplot(132);imhist(G);title('Green band histogram');
 subplot(133);imhist(B);title('Blue band histogram');
 
 %% Color Coherence Vector (CCV)
 
 c = ccv(im);
 
 %% LBP
 
 a = ll;
 [m,n] = size(a);
 for i = 2:m-1
     for j = 2:n-1
         b = a(i-1:i+1,j-1:j+1);
         B(i-1:i+1,j-1:j+1) = LBP(b);
     end
 end
 figure,imshow(B);
 title('Local Binary Patterns');
 
 lbp = mean(mean(B))
 data = lbp;
 s5 = data;
 save example.mat s5 s5

