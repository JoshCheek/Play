puts Solution.new('4. String Counter', <<SOLUTION)
  def count(h,n)h.upcase.scan(n.upcase).size end
SOLUTION
  .test { count "Banana", "a" }.expect { |result| result == 3 }
  .test { 
    count "RubySource provides advice, tutorials, commentary, and insight into the Ruby and Rails ecosystem", "ruby"
  }.expect { |result| result == 2}
