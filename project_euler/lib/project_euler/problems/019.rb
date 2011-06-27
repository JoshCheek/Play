require 'date'
require 'project_euler'

module ProjectEuler
  class Problem19
    
    def solution
      dates = Date.parse('1 Jan 1901') ... Date.parse('31 Dec 2000')
      dates.count { |date| monday?(date) && first_of_month?(date) }
    end
    
    def monday?(date)
      date.wday.zero?
    end
    
    def first_of_month?(date)
      date.day.one?
    end
    
  end
end
