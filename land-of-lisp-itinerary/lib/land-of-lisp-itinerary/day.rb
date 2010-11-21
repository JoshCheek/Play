module Itinerary
  class Day
  
    def initialize(date,&definition)
      self.date = date
      instance_eval(&definition)
    end
  
    def read(title,&followup)
      todo << Reading.new(title,&followup)
    end
  
    def date=(date)
      @date = date
    end
  
    def date
      @date
    end
  
    def todo
      @todo ||= Array.new
    end
  
    def to(type)
      case type
      when :text
        [ "DUE: #{date.upcase}:",
          todo.map do |task| 
            result = task.to type
            if result.is_a? String
              "  #{result}"
            else
              result.map { |line| "  #{line}" }
            end
          end
        ].flatten
      end
    end
  
  end
end