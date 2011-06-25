require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem3
    def solution
      600851475143.prime_factors.max
    end
  end
end
