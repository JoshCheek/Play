module Itinerary
  class Day
    
    include Nestable
  
    def initialize(date)
      super
      @date = date
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