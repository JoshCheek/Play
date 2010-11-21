module Itinerary
  class Reading
    
    include Nestable
    
    @@current_page = 0
  
    def initialize(title,&followup)
      raise "readings must have only one title" unless title.size == 1
      super
      @pages = "#{@@current_page += 1}-#{ @@current_page += title.values.first.abs }"
      @title = title.keys.first
    end
  
    def to(type)
      case type
      when :text
        super { "READ #{@title.inspect} (#{@pages}):" }
      end
    end
        
    def todo
      @todo ||= Array.new
    end
        
  end
end

