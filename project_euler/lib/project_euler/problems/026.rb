require 'project_euler'

module ProjectEuler
  class Problem26
    
    def recurring_cycle(denominator)
      numerator = 1
      seen = []
      loop do
        # require 'pry'
        # binding.pry
        if denominator.divide? numerator
          return []
        elsif denominator > numerator
          numerator *= 10
        else
          seen << numerator
          first_seen = seen.index numerator
          return seen[first_seen...-1] if first_seen != seen.size-1
          numerator = numerator % denominator
        end
      end
    end
    
    def recurring_period(n)
      recurring_cycle(n).size
    end
    
    def solve_for(n)
      (1..n).max_by { |i| recurring_period i }
    end
    
    def solution
      solve_for 1000
    end

  end
end
