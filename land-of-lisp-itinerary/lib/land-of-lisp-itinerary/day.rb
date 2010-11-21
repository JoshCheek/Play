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
        super { "DUE: #{@date.upcase}:" }
      end
    end
  
  end
end