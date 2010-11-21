module Itinerary
module Actions
class  Show
    
  include Nestable
  
  def initialize(shiny_thing,&block)
    super
    @to_show = shiny_thing
  end

  def to_s
    "SHOW: #{@to_show}"
  end

end end end