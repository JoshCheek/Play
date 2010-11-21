module Itinerary
module Actions
class  Complete
    
  include Nestable

  def initialize(task)
    super
    @task = task
  end

  def to(type)
    case type
    when :text
      super { "COMPLETE: #{@task}" }
    end
  end
    
end end end
