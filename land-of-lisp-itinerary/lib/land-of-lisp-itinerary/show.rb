module Itinerary
  class Show
    
    include Nestable
    
    def initialize(shiny_thing,&block)
      super
      @to_show = shiny_thing
    end

    def to(type)
      case type
      when :text
        "SHOW: #{@to_show}"
      end
    end


  end
end