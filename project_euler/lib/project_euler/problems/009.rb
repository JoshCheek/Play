require 'project_euler/pythagorean_triples'
module ProjectEuler
  class Problem9
    def solution
      PythagoreanTriples.find { |a,b,c| a+b+c == 1000 }.inject :*
    end
  end
end

