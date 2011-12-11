Solutions for [Ruby Golf](http://rubysource.com/ruby-golf/)
===========================================================

    $ ./runner.sh 
    1. Fizz Buzz: 74 characters
      def fizzbuzz(n)(n%15==0?'FizzBuzz':n%3==0?'Fizz':n%5==0?'Buzz':n).to_s end
      4 tests: Pass, Pass, Pass, Pass

    2. Caesar Cipher: 47 characters
      def caeser(s,n)s.gsub(/./){|c|(c.ord+n).chr}end
      2 tests: Pass, Pass

      This one seems like it probably has lots of edge cases that should be specified,
      but this satisfies the given example and works both forwards and backwards.

    3. Rock Paper Scissors Game: 104 characters
      def play(s)o=%w(Rock Paper Scissors Rock);m=rand 3;"#{o[m]},#{o[m+1]==s ?:Win:o[m]==s ?:Draw: :Lose}"end
      4 tests: Pass, Pass, Pass, Pass

    4. String Counter: 46 characters
      def count(h,n)h.upcase.scan(n.upcase).size end
      2 tests: Pass, Pass

    1. Swingers Function: 49 characters
      def swingers(s)f,l=s.transpose;f.zip l.rotate end
      1 tests: Pass

      The directions didnt specify randomness as a requirement,
      this algorithm is simple and deterministic but easy to understand.

---------------------------------------

**This code is unmaintained.** 

_If you do something interesting with it, let me know so I can be happy._

---------------------------------------

Copyright (c) 2010 Joshua Cheek

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
