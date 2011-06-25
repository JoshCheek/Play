require 'project_euler/core_extensions/array'
require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem4
    def solution
      
      max = 0
      (100..999).each do |a|
        (100..999).each do |b|
          crnt = a * b
          next if crnt < max
          max = crnt if crnt.digits.palindrome?
        end
      end
      max
      
    end
  end
end
