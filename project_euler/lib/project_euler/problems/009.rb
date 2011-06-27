require 'project_euler'

module ProjectEuler
  class Problem9
    def solution
      PythagoreanTriples.find { |triple| triple.sum == 1000 }.multiplied
    end
  end
end

