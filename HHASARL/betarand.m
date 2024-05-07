function r = betarand(a,b,varargin);

% [~, sizeOut] = internal.stats.statsizechk(2,a,b,varargin{:});

% Generate gamma random values and take ratio of the first to the sum.
g1 = randg(a,1); % could be Infs or NaNs
g2 = randg(b,1); % could be Infs or NaNs
r = g1 ./ (g1 + g2);

% For a and b both very small, we often get 0/0.  Since the distribution is
% essentially a Bernoulli(a/(a+b)), we can replace those NaNs.
% t = (g1==0 & g2==0);
% if any(t(:))
%     p = a ./ (a+b);
%     if ~isscalar(p), p = p(t); end
%     r(t) = binornd(1,p(:),sum(t(:)),1);
% end
