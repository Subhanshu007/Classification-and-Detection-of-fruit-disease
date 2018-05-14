function  X1 = LBP(Resimage)

% Returns a rotation invariant LBP (uniform patterns) histogram (10 bins) 
% of picture X.

% the size of picture X must be at least 3x3 pixels

w1 = (1/sqrt(2))^2;
w2 = (1-1/sqrt(2))*(1/sqrt(2));

[sy sx] = size(Resimage);

Xi = zeros(sy+2,sx+2);
Xi(2:sy+1,2:sx+1) = Resimage;

Xi2 = zeros(sy+2,sx+2);
Xi4= zeros(sy+2,sx+2);
Xi6 = zeros(sy+2,sx+2);
Xi8 = zeros(sy+2,sx+2);
p1 = zeros(sy+2,sx+2);
p2 = zeros(sy+2,sx+2);
p3 = zeros(sy+2,sx+2);
p4 = zeros(sy+2,sx+2);
p5 = zeros(sy+2,sx+2);
p6 = zeros(sy+2,sx+2);
p7 = zeros(sy+2,sx+2);
p8 = zeros(sy+2,sx+2);
p9 = zeros(sy+2,sx+2);

p1(3:sy+2,3:sx+2) = Resimage;
p2(3:sy+2,2:sx+1) = w2*double(Resimage);
p3(3:sy+2,1:sx) = Resimage;

p4(2:sy+1,3:sx+2) = w2*double(Resimage);
p5(2:sy+1,2:sx+1) = (1-1/sqrt(2))^2*double(Resimage);
p6(2:sy+1,1:sx) = w2*double(Resimage);

p7(1:sy,3:sx+2) = Resimage;
p8(1:sy,2:sx+1) = w2*double(Resimage);
p9(1:sy,1:sx) = Resimage;

Xi1 = w1*p1+ p2+p4 + p5 + 0.000001; %Xi1 to the right and down from X
Xi2(3:sy+2,2:sx+1) = Resimage;
Xi3 = w1*p3 + p2 + p6 + p5 + 0.000001;
Xi4(2:sy+1,1:sx) = Resimage;
Xi5 = w1*p9 + p8 + p6 + p5 + 0.000001;
Xi6(1:sy,2:sx+1) = Resimage;
Xi7 = w1*p7 + p8 + p4 + p5 + 0.000001;
Xi8(2:sy+1,3:sx+2) = Resimage;

Xi = (Xi4>=Xi)+2*(Xi5>=Xi)+4*(Xi6>=Xi)+8*(Xi7>=Xi)+16*(Xi8>=Xi)+32*(Xi1>=Xi)+64*(Xi2>=Xi)+128*(Xi3>=Xi);

X1 = Xi(3:sy,3:sx);
end