module Itinerary
  class Day
    
    include Nestable
  
    def initialize(date)
      super
      @date = date
    end
  
    def read(title,&followup)
      todo << Reading.new(title,&followup)
    end
    
    def todo
      @todo ||= Array.new
    end
  
    def to(type)
      case type
      when :text
        [ "DUE: #{@date.upcase}:",
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