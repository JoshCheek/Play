require 'project_euler'

module ProjectEuler
  class Problem29
        
    def solve_for(n)
      solutions = []
      (2..n).each do |a|
        (2..n).each do |b|
          solutions << a**b
        end
      end
      solutions.uniq.size
    end
    
    def solution
      solve_for 100
    end
    
  end
end
