module Itinerary
module Actions
class  Comment
  
  include Nestable
  
  def initialize(comment)
    super
    @comment = comment
  end
  
  def to_s
    "COMMENT: #{@comment}"
  end
  
end end end