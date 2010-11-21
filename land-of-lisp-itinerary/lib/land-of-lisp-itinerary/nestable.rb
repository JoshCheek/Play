module Itinerary
  module Nestable
    
    def initialize(*args,&nested)
      instance_eval(&nested) if nested
    end

    def todo
      @todo ||= Array.new
    end
    
    def read(title,&followup)
      todo << Reading.new(title,&followup)
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
    
  end
end