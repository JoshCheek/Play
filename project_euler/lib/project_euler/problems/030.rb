require 'project_euler'

module ProjectEuler
  class Problem30
    
    def nth_power?(num, power)
      num.digits.map { |digit| digit**power }.sum == num
    end
    
    def solve_for(n)
      upper_bound = n*(9**n)
      (2..upper_bound).inject 0 do |sum, num|
        if nth_power?(num, n)
          sum + num
        else
          sum
        end
      end
    end
    
    def solution
      solve_for 5
    end
    
  end
end
