require 'project_euler/core_extensions/integer'
require 'project_euler/core_extensions/enumerable'

module ProjectEuler
  class Problem16
    def solution
      (2**1000).digits.sum
    end
  end
end
