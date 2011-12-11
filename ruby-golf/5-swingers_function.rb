pairs = [["Homer","Marge"],["Micky","Minnie"],["Fred","Wilma"],["Peter","Lois"],["George","Judy"]]

men_are_in_same_order = lambda do |result|
  pairs.map(&:first) == result.map(&:first)
end

no_woman_is_paired_with_the_man_she_came_with = lambda do |result|
  pairs.each_with_index.all? do |(man, woman), index|
    woman != result[index].last
  end
end


puts Solution.new('1. Swingers Function', <<SOLUTION, <<COMMENT)
  def swingers(s)f,l=s.transpose;f.zip l.rotate end
SOLUTION
  The directions didnt specify randomness as a requirement,
  this algorithm is simple and deterministic but easy to understand.
COMMENT
  .test { 
    swingers pairs
  }.expect { |result|
    men_are_in_same_order[result] &&
    no_woman_is_paired_with_the_man_she_came_with[result]
  }
