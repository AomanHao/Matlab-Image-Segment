function p=makeParameters()

p=struct();

p.N=            25;                         % pixel neighborhood size
p.sigma=        8;                          % variance of gaussian for spatial weighting
p.sigma_C=      0.01;                       % camera variance
p.clustFunc=    @cluster_OrachardBouman;    % clustering function
p.minN=         10;                         % minimum required foreground and background neighbors for optimization
p.guiMode=      0;                          % if 1, will show a nice looking progress bar. if 0, will print progress to command line

% clustering parameters
p.clust.minVar= 0.05;                       % minimal cluster variance in order to stop splitting

% optimization parameters
p.opt.maxIter=  50;                         % maximal number of iterations
p.opt.minLike=  1e-6;                       % minimal change in likelihood between consecutive iterations
