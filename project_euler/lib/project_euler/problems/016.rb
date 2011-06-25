require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem16
    def solution
      (2**1000).digits.inject(:+)
    end
  end
end
