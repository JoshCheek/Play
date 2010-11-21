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
        [ "READ #{@title.inspect} (#{@pages}):",
          todo.map do |task|
            result = task.to type
            if result.is_a? String
              "  #{result}"
            else
              result.map { |line| "#{line}" }
            end
          end
        ].flatten
      end
    end
        
    def todo
      @todo ||= Array.new
    end
        
  end
end

