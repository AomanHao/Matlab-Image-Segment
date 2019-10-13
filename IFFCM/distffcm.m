function dist=distffcm(Miuij,V)
%%求直觉模糊集的欧式距离
miui=V;

dist = zeros(size(V, 1), size(Miuij, 1));
if size(V, 2) > 1,
    for k = 1:size(V, 1),
	dist(k, :) = sqrt(sum(((Miuij-ones(size(data, 1), 1)*V(k, :)).^2)'));
    end
else	% 1-D data
    for k = 1:size(V, 1),
    %out(k, :) = abs(center(k)-data)';
	dist1=((Miuij-miui(k, :)).^2);
    dist(k, :) = sqrt(dist1);
    end
end
