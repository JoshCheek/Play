module Itinerary
  class Complete
    
    def initialize(task)
      @task = task
    end
    
    def to(type)
      "COMPLETE: #{@task}"
    end
    
  end
end
