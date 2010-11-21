module Itinerary
  class Supplement
    
    include Nestable
    
    def initialize(task)
      @task = task
    end
    
    def to(type)
      case type
      when :text
        "SUPPLEMENT: #{@task}"
      end
    end
    
  end
end