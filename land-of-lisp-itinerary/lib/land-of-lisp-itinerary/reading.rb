module Itinerary
  class Reading
    @@current_page = 0
  
    def initialize(title,&followup)
      raise "readings must have only one title" unless title.size == 1
      @@current_page += 1
      @pages = "#{@@current_page}-#{ @@current_page += (@@current_page-title.values.first).abs }"
      @title = title.keys.first
      instance_eval(&followup)
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
    
    def discuss(topic)
      todo << Discuss.new(topic)
    end
    
    def complete(task)
      todo << Complete.new(task)
    end
    
    def todo
      @todo ||= Array.new
    end
        
  end
end

