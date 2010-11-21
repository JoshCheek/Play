module Itinerary
  class Discuss
    
    def initialize(topic)
      @topic = topic
    end
    
    def to(type)
      "DISCUSS: #{@topic}"
    end
    
  end
end
