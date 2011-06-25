require 'project_euler/fibs'

module ProjectEuler
  class Problem2
    def solution
      
      fib_sum = 0
      Fibs.each do |crnt|
        fib_sum += crnt if crnt.even?
        break if crnt > 4_000_000
      end
      fib_sum
      
    end
  end
end
