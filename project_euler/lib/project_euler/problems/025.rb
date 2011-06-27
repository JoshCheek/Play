require 'project_euler'

module ProjectEuler
  class Problem25
    
    def solve_for(n)
      Fibs.each.with_index do |fib, index|
        return index if n == fib.num_digits
      end
    end
    
    def solution
      solve_for 1000
    end
    
  end
end
