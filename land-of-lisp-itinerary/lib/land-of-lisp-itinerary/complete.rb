module Itinerary
  class Complete
    
    include Nestable
    
    def initialize(task)
      super
      @task = task
    end
    
    def to(type)
      "COMPLETE: #{@task}"
    end
    
  end
end
