
function nIDK = MoveIDK(IDK, dist)

G = zeros(3, 9);

G1 = find(IDK==1);
G2 = find(IDK==2);
G3 = find(IDK==3);

G1.length = length(find(IDK==1));
G2.length = length(find(IDK==2));
G3.length = length(find(IDK==3));

if G1.length ~= 9 || G2.length ~= 9 || G3.length ~= 9
    large = max([G1.length G2.length G3.length]);
    small = min([G1.length G2.length G3.length]);
    if Large == G1.length && small == G2.length
        [m, i] = max(dist(G1,1));
        ind = G1(i);                %index of the farthest subject
        [temp, tempind] = min([inf dist(ind,2) dist(ind,3)]);
        if tempind == 2
            nIDK(ind) = tempind;
        else
            
    
    
    
   
else

    
    end



case
end