module Itinerary
module Actions
class  Day
    
  include Nestable

  def initialize(date)
    super
    @date = date
  end
  
  def todo
    @todo ||= Array.new
  end

  def to_s
    "DUE: #{@date.upcase}:"
  end
  
end end end