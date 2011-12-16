For Chicago Ruby's [Hack Night](http://www.meetup.com/ChicagoRuby/events/43150262/) on 15 Dec 2011:

Inspired by the [one-line scripts for awk](http://www.pement.org/awk/awk1line.txt),
we'll write Ruby programs to do things
like double-space a file or add line numbers to the file or center the text in each
line of a file.  The challenge is to write the shortest possible program that works
for each of these tasks:

### doublespace a file

      ruby -lpe '$_<<"\n"'


### add line numbers to each input file

      # not happy with this one, but couldn't figure out how to get ARGF to reset $.
      # (also, 1.9 only)
      ruby -e 'l=-> line {puts "#$. #{line}"}; ARGV.each { |name| File.foreach name, &l}; $stdin.each &l'


### add line numbers for all files together

     ruby -lne 'print "#$. #$_"'
     ruby -lpe '$_.prepend "#$. "'


### add line numbers only for nonblank lines

    ruby -lpe '/^$/ ? $.-=1 : $_ = "#$. :#$_"'


### count lines in file

    ruby -ne 'END{puts $.}'


### count words in file

    ruby -ane 'w = (w||0) + $F.size; END { p w }'


### output total number of lines that contain 'abc'

    ruby -e 'p ARGF.readlines.grep(/abc/).size'
    ruby -ne 'w=(w||0)+1 if /abc/; END{p w}'


### output a string of 43 X's

    ruby -e 'puts "X"*43'


### insert a string of 3 X's after column 6 of each input line

    ruby -ple '$_.insert 6, "xxx" if $_.size > 6'


### delete leading whitespace from beginning of each line

    ruby -pe '$_.sub! /^\s+/, ""'


### delete trailing whitespace from end of each line

    ruby -pe '$_.gsub! /\s+$/, "\n"'


### add leading blanks to right-align all text in 80-column width

    ruby -pe '$_ =  "%80s\n" % $_.chomp'


### add leading and trailing blanks to center each line in 80 columns

    ruby -lpe '$_= $_.center 80' input-file


### reverse the text in each line

    ruby -lpe '$_.reverse!'


### concatenate every 5 lines of input, using , as separator

    ruby -e 'ARGF.each_slice(5) { |lines| puts lines.map(&:chomp).join(",") }'


### print first 10 lines of file

    ruby -pe 'exit if $. > 10'


### print last 10 lines of file

    ruby -ne 'puts $_ if $. > 10'


### print line 13 of file

    ruby -ne 'puts $_ if $. == 13'


### delete blank lines from file

    ruby -ne 'puts $_ unless $_ == "\n"'


### delete consecutive duplicate lines from file

    ruby -ne 'puts $_ if /^[^\n]/../^$/'


### delete any duplicate lines from file

    # consecutive duplicates
    ruby -lne 'BEGIN{last=""};puts last=$_ unless last==$_'
    
    # any duplicate in input
    ruby -lne 'BEGIN{lines=Hash.new{|h,l|puts h[l]=l}};lines[$_]'
