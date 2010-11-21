module Itinerary
module Actions
class  Complete
    
  include Nestable

  def initialize(task)
    super
    @task = task
  end

  def to_s
    "COMPLETE: #{@task}"
  end
    
end end end
