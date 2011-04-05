Finding longest repeated substring
==

This is solution for problem [rubyquiz #153](http://rubyquiz.com/quiz153.html).

It finds longest repeated substrings using Karp-Miller-Rosenberg algorithm with complexity O(n * logn * logn).
On my notebook (Intel Core 2 Duo 2.16 GHz) calculating longest substring in Homer's 'Illiad' ('test/homer-illiad.in') takes about 3 minutes.

Usage
--

    bin/kmr.rb (note: input comes from standard input)
    bin/kmr.rb string
    bin/kmr.rb -f filename
