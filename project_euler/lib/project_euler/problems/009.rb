require 'project_euler/pythagorean_triples'
require 'project_euler/core_extensions/enumerable'

module ProjectEuler
  class Problem9
    def solution
      PythagoreanTriples.find { |triple| triple.sum == 1000 }.multiplied
    end
  end
end

