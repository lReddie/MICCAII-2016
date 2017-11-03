function nIDK = constrainedIDK(B)
% CONSTRAINEDIDK - Takes 2D IDK and minimizes it to 1D

nIDK = zeros(size(B,1),1);
temp = zeros(size(B));


for i = 1:size(B,2)
    temp(:,i) = B(:,i)*i;
end

nIDK = sum(temp,2);

end