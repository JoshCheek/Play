require 'project_euler/primes'

module ProjectEuler
  class Problem7
    def solution
      Primes.nth 10001
    end
  end
end
