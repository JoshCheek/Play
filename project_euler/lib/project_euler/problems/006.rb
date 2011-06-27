require 'project_euler/core_extensions/array'
require 'project_euler/core_extensions/integer'
require 'project_euler/core_extensions/enumerable'

module ProjectEuler
  class Problem6
    def solution
      square_of_sums = (1..100).sum ** 2
      sum_of_squares = (1..100).map { |i| i**2 }.sum
      square_of_sums - sum_of_squares
    end
  end
end
