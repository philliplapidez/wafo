function str = strjoin(cstr, sep)
%STRJOIN  Join strings in a cell array.
%
% CALL:  str0 = strjoin(cstr, sep);
%
%   str0         = [str1,sep,str2,sep,....]
%   cstr         = {str1,str2,...},  strings to join
%   sep          = string separator
%   
%   STRJOIN joins the separate strings STR1, STR2, ... 
%   into a single string with fields separated by SEP.
%   This function is inspired by Perl' function join().
%
% Examples:
%
%  assert(strjoin({'hello'}, '-'), 'hello');
%  assert(strjoin({'hello', 'world'}), 'hello world');
%  assert(strjoin({'2', '3', '4'}, '-by-'), '2-by-3-by-4');
%  assert(strjoin({'1', '2', '3', '4', '5'}, {' ', ',', '-', ';'}), '1 2,3-4;5');
%  assert(strjoin({'1', '2'}, '\n'), '1\n2');
%  assert(strjoin({'1'; '2'}, {'\n'}), '1\n2');
%  assert(strjoin({}, ','), '');
%
% See also: insert

% revised pab 13.12.2000
% - updated header.
%   Author:      Peter J. Acklam
%   Time-stamp:  2000-02-03 13:30:21
%   E-mail:      jacklam@math.uio.no
%   WWW URL:     http://www.math.uio.no/~jacklam

   % Check number of input arguments.
   error(nargchk(1, 2, nargin));

   if nargin == 1 
      sep = ' ';
   end
   num = numel (cstr);
   empty_sep_or_single_string = isempty(sep) || num==1;
   if empty_sep_or_single_string
      str = [ cstr{:} ];
   elseif num==0
      str = '';      
   else
      if ischar(sep)
        sep = {sep};    
      end
      if numel(sep)==1
        sep = repmat(sep, 1, num-1);
      end 
      sep{end+1} = '';
      str = [ [cstr(:).'; sep(:).']{:} ];
   end

%!assert(strjoin({'hello'}, '-'), 'hello')
%!assert(strjoin({'hello', 'world'}), 'hello world')
%!assert(strjoin({'2', '3', '4'}, '-by-'), '2-by-3-by-4')
%!assert(strjoin({'1', '2', '3', '4', '5'}, {' ', ',', '-', ';'}), '1 2,3-4;5')
%!assert(strjoin({'1', '2'}, '\n'), '1\n2')
%!assert(strjoin({'1'; '2'}, {'\n'}), '1\n2')
%!assert(strjoin({}, ','), '')