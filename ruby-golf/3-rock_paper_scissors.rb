def seed_for(environment, result)
  environment.define_singleton_method :rand do |*|
    [:rock, :paper, :scissors].index result
  end
end


puts Solution.new('3. Rock Paper Scissors Game', <<SOLUTION)
  def play(s)o=%w(Rock Paper Scissors Rock);m=rand 3;"\#{o[m]},\#{o[m+1]==s ?:Win:o[m]==s ?:Draw: :Lose}"end
SOLUTION
  .test {
    seed_for self, :rock
    play "Rock"
  }.expect { |result| result == "Rock,Draw" }
  .test {
    seed_for self, :rock
    play "Paper"
  }.expect { |result| result == "Rock,Win" }
  .test {
    seed_for self, :rock
    play "Scissors"
  }.expect { |result| result == "Rock,Lose" }
  .test {
    seed_for self, :paper
    play "Soap"
  }.expect { |result| result == "Paper,Lose" }
