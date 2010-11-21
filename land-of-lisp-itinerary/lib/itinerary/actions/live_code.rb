module Itinerary
module Actions
class  LiveCode
  
  include Nestable
  
  def initialize(to_code)
    super
    @to_code = to_code
  end
  
  def to_s
    "LIVE CODE: #{@to_code}"
  end
  
end end end