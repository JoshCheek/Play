module Itinerary
module Actions
class  Discuss
    
  include Nestable
  
  def initialize(topic)
    super
    @topic = topic
  end
  
  def to(type)
    case type
    when :text
      super { "DISCUSS: #{@topic}" }
    end
  end
    
end end end
