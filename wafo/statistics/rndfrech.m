function R = rndfrech(varargin)
%RNDFRECH Random matrices from a Frechet distribution.
% 
% CALL:  R = rndfrech(a,c,sz)
%        R = rndfrech(phat,sz)
% 
% R     = a matrix of random numbers from the Weibull distribution
% a, c  = parameters of the Frechet distribution
%  phat = Distribution parameter struct
%             as returned from WFRECHFIT.  
%    sz = size(R)    (Default common size of k,s and m0)
%         sz can be a comma separated list or a vector 
%         giving the size of R (see zeros for options).
%
% The Weibull distribution is defined by the distribution function
% 
%   F(x) = exp(-(x/a)^-c), x>=0, a,c>0
% 
% The random numbers are generated by the inverse method. 
%
% Example:
%   R=rndfrech(1,10,1,100);
%   phat=plotweib(R);
%
%   close all;
%
% See also  pdffrech,  cdffrech, invfrech, wfrechfit, momfrech 

% Reference: Cohen & Whittle, (1988) "Parameter Estimation in Reliability
% and Life Span Models", p. 25 ff, Marcel Dekker.


% Tested on: matlab 5.3
% History: 
% revised pab 23.10.2000
%  - added comnsize
%  - added greater flexibility on the sizing of R
% rewritten ms 15.06.2000

%error(nargchk(1,inf,nargin))
narginchk(1,inf)
Np = 2;
options = []; % struct; % default options
[params,options,rndsize] = parsestatsinput(Np,options,varargin{:});
% if numel(options)>1
%   error('Multidimensional struct of distribution parameter not allowed!')
% end

[a,c] = deal(params{:});
if isempty(rndsize),
  csize = comnsize(a,c);
else
  csize = comnsize(a,c,zeros(rndsize{:}));
end
if any(isnan(csize))
    error('a and c must be of common size or scalar.');
end

R = invfrech(rand(csize),a,c,'lowertail',false);





