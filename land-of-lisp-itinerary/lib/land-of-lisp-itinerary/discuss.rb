module Itinerary
  class Discuss
    
    include Nestable
    
    def initialize(topic)
      @topic = topic
      super
    end
    
    def to(type)
      "DISCUSS: #{@topic}"
    end
    
  end
end
