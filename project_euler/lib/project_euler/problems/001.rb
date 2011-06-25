require 'project_euler/core_extensions/integer'

module ProjectEuler
  class Problem1
    def solution
      
      (1...1000).inject 0 do |sum, i| 
        if 3.divide?(i) || 5.divide?(i)
          sum + i
        else
          sum
        end
      end
      
    end
  end
end