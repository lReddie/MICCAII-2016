function Prob = IDKProb(Dist)

Prob = Dist.^(-1) ./ repmat( sum( [ones(27,1)./Dist(:,1) ones(27,1)./Dist(:,2) ones(27,1)./Dist(:,3) ],2), [1,3]);

end