require 'project_euler'

module ProjectEuler
  class Problem10
    def solution
      Primes.each_upto(2_000_000).sum
    end
  end
end
