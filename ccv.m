
function f = ccv(im)
I = im;
[m,n,t] = size(I);

I1(:,1:n-1,:) = I(:,2:n,:);
I1(:,n,:) = I(:,1,:);
I2(:,1,:) = I(:,n,:);
I2(:,2:n,:) = I(:,1:n-1,:);
I3(1:m-1,:,:) = I(2:m,:,:);
I3(m,:,:) = I(1,:,:);
I4(1,:,:) = I(m,:,:);
I4(2:m,:,:) = I(1:m-1,:,:);
I = double(I);
I1 = double(I1);
I2 = double(I2);
I3 = double(I3);
I4 = double(I4);
Ibr = (I1+I2+I3+I4+I) / 5;

R = [255,0,0];
G = [0,255,0];
B = [0,0,255];
RG = R + G;
RB = R + B;
GB = G + B;
White = R + G +B;
Black = White * 0;
Color = [R;G;B;RG;RB;GB;White;Black];

for p=1:m
    for q=1:n
        Ipq = [Ibr(p,q,1),Ibr(p,q,2),Ibr(p,q,3)];
        dist1 = norm(R-Ipq);
        dist2 = norm(G-Ipq);
        dist3 = norm(B-Ipq);
        dist4 = norm(RG-Ipq);
        dist5 = norm(RB-Ipq);
        dist6 = norm(GB-Ipq);
        dist7 = norm(White-Ipq);
        dist8 = norm(Black-Ipq);
        Dist = [dist1,dist2,dist3,dist4,dist5,dist6,dist7,dist8];
        dist = min(Dist);
        [m1,n1] = find(Dist == dist);
        Ic(p,q,:) = Color(n1,:);
    end
end

Mask = zeros(m,n);

k = 1;
for p=1:m
    for q=1:n
        if Mask(p,q) == 0
            Mask(p,q) = k;
            % CColor(k,:) = Ic(p,q,:);
            k = k + 1;
        end
        % 1
        if p-1>0 && p-1<m && q-1>0 && q-1<n
            if Ic(p-1,q-1,:) == Ic(p,q,:)
                if Mask(p-1,q-1) == 0
                    Mask(p-1,q-1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p-1,q-1),Mask(p,q));
                end
            end
        end
        % 2
        if p-1>0 && p-1<m && q>0 && q<n
            if Ic(p-1,q,:) == Ic(p,q,:)
                if Mask(p-1,q) == 0
                    Mask(p-1,q) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p-1,q),Mask(p,q));
                end
            end
        end
        % 3
        if p-1>0 && p-1<m && q+1>0 && q+1<n
            if Ic(p-1,q+1,:) == Ic(p,q,:)
                if Mask(p-1,q+1) == 0
                    Mask(p-1,q+1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p-1,q+1),Mask(p,q));
                end
            end
        end
        % 4
        if p>0 && p<m && q-1>0 && q-1<n
            if Ic(p,q-1,:) == Ic(p,q,:)
                if Mask(p,q-1) == 0
                    Mask(p,q-1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p,q-1),Mask(p,q));
                end
            end
        end
        % 5
        if p>0 && p<m && q+1>0 && q+1<n
            if Ic(p,q+1,:) == Ic(p,q,:)
                if Mask(p,q+1) == 0
                    Mask(p,q+1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p,q+1),Mask(p,q));
                end
            end
        end
        % 6
        if p+1>0 && p+1<m && q-1>0 && q-1<n
            if Ic(p+1,q-1,:) == Ic(p,q,:)
                if Mask(p+1,q-1) == 0
                    Mask(p+1,q-1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p+1,q-1),Mask(p,q));
                end
            end
        end
        % 7
        if p+1>0 && p+1<m && q>0 && q<n
            if Ic(p+1,q,:) == Ic(p,q,:)
                if Mask(p+1,q) == 0
                    Mask(p+1,q) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p+1,q),Mask(p,q));
                end
            end
        end
        % 8
        if p+1>0 && p+1<m && q+1>0 && q+1<n
            if Ic(p+1,q+1,:) == Ic(p,q,:)
                if Mask(p+1,q+1) == 0
                    Mask(p+1,q+1) = Mask(p,q);
                else
                    Mask(p,q) = min(Mask(p+1,q+1),Mask(p,q));
                end
            end
        end
    end
end

Rv = [];
Gv = [];
Bv = [];
RGv = [];
RBv = [];
GBv = [];
Whitev = [];
Blackv = [];
flag = 0;
for kc=1:k
    flag = 0;
    for p=1:m
        for q=1:n
            if Mask(p,q)==kc
                color = [Ic(p,q,1),Ic(p,q,2),Ic(p,q,3)];
                if R == color
                    Rv = [Rv, kc];
                elseif G == color
                    Gv = [Gv, kc];
                elseif B == color
                    Bv = [Bv, kc];
                elseif RG == color
                    RGv = [RGv, kc];
                elseif RB == color
                    RBv = [RBv, kc];
                elseif GB == color
                    GBv = [GBv, kc];
                elseif White == color
                    Whitev = [Whitev, kc];
                elseif Black == color
                    Blackv = [Blackv, kc];
                end
                flag = 1;
                break;
            end
        end
        if flag == 1
            break;
        end
    end
end

Kv = zeros(1,k-1);
for p=1:m
    for q=1:n
        Kv(Mask(p,q)) = Kv(Mask(p,q)) +1;
    end
end

threshold = (m*n) / 15;

Rc = 0;
Ri = 0;
[m1,n1] = size(Rv);
for p=1:n1
    if Kv(Rv(p)) > threshold
        Rc = Rc + Kv(Rv(p));
    else
        Ri = Ri + Kv(Rv(p));
    end
end

Gc = 0;
Gi = 0;
[m1,n1] = size(Gv);
for p=1:n1
    if Kv(Gv(p)) > threshold
        Gc = Gc + Kv(Gv(p));
    else
        Gi = Gi + Kv(Gv(p));
    end
end

Bc = 0;
Bi = 0;
[m1,n1] = size(Bv);
for p=1:n1
    if Kv(Bv(p)) > threshold
        Bc = Bc + Kv(Bv(p));
    else
        Bi = Bi + Kv(Bv(p));
    end
end

RGc = 0;
RGi = 0;
[m1,n1] = size(RGv);
for p=1:n1
    if Kv(RGv(p)) > threshold
        RGc = RGc + Kv(RGv(p));
    else
        RGi = RGi + Kv(RGv(p));
    end
end

RBc = 0;
RBi = 0;
[m1,n1] = size(RBv);
for p=1:n1
    if Kv(RBv(p)) > threshold
        RBc = RBc + Kv(RBv(p));
    else
        RBi = RBi + Kv(RBv(p));
    end
end

GBc = 0;
GBi = 0;
[m1,n1] = size(GBv);
for p=1:n1
    if Kv(GBv(p)) > threshold
        GBc = GBc + Kv(GBv(p));
    else
        GBi = GBi + Kv(GBv(p));
    end
end

Whitec = 0;
Whitei = 0;
[m1,n1] = size(Whitev);
for p=1:n1
    if Kv(Whitev(p)) > threshold
        Whitec = Whitec + Kv(Whitev(p));
    else
        Whitei = Whitei + Kv(Whitev(p));
    end
end

Blackc = 0;
Blacki = 0;
[m1,n1] = size(Blackv);
for p=1:n1
    if Kv(Blackv(p)) > threshold
        Blackc = Blackc + Kv(Blackv(p));
    else
        Blacki = Blacki + Kv(Blackv(p));
    end
end

CCV = [Rc,Ri,Gc,Gi,Bc,Bi,RGc,RGi,RBc,RBi,GBc,GBi,Whitec,Whitei,Blackc,Blacki];
f = CCV;

