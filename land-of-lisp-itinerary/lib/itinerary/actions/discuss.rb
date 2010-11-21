module Itinerary
module Actions
class  Discuss
    
  include Nestable
  
  def initialize(topic)
    super
    @topic = topic
  end
  
  def to_s
    "DISCUSS: #{@topic}"
  end
    
end end end
