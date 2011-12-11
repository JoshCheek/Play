puts Solution.new('2. Caesar Cipher', <<SOLUTION, <<COMMENT)
  def caeser(s,n)s.gsub(/./){|c|(c.ord+n).chr}end
SOLUTION
  This one seems like it probably has lots of edge cases that should be specified,
  but this satisfies the given example and works both forwards and backwards.
COMMENT
  .test { caeser "hello", 3  }.expect { |result| result == "khoor" }
  .test { caeser "khoor", -3 }.expect { |result| result == "hello" }
