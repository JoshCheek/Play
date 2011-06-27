require 'project_euler/primes'
require 'project_euler/core_extensions/enumerable'

module ProjectEuler
  class Problem10
    def solution
      Primes.each_upto(2_000_000).sum
    end
  end
end
