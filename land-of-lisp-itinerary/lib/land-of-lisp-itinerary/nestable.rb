module Itinerary
  module Nestable
    
    def initialize(*args,&nested)
      instance_eval(&nested) if nested
    end

    def todo
      @todo ||= Array.new
    end
    
    def read(title,&followup)
      todo << Read.new(title,&followup)
    end
  
    def discuss(topic)
      todo << Discuss.new(topic)
    end
    
    def complete(task)
      todo << Complete.new(task)
    end
    
    def supplement(task)
      todo << Supplement.new(task)
    end
    
    def show(shiny_thing)
      todo << Show.new(shiny_thing)
    end
    
    def live_code!(to_code)
      todo << LiveCode.new(to_code)
    end
    
    def to(type)
      case type
      when :text
        [ yield,
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