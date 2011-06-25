require 'project_euler/core_extensions/array'
require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem6
    def solution
      square_of_sums = (1..100).inject(:+)**2
      sum_of_squares = (1..100).map { |i| i**2 }.inject(:+)
      square_of_sums - sum_of_squares
    end
  end
end
