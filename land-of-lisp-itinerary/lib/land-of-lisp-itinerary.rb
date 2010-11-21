require File.dirname(__FILE__) + '/land-of-lisp-itinerary/complete'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/day'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/discuss'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/reading'

def by(date,&block)
  Itinerary.by date , &block
end


module Itinerary

  extend self
    
  def to(type)
    days.map { |day| day.to type }.join("\n")
  end
  
  def by(date,&definition)
    days << Day.new(date,&definition)
  end
  
  def days
    @days ||= Array.new
  end
  
end

