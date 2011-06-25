require 'project_euler/primes'

module ProjectEuler
  class Problem10
    def solution
      Primes.each_upto(2_000_000).inject(0) { |sum, prime| sum + prime }
    end
  end
end
