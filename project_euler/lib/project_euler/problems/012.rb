require 'project_euler/triangle_numbers'
require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem12
    def solution
      TriangleNumbers.find do |triangle_number|
        triangle_number.factors.size > 500
      end
    end
  end
end
