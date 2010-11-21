require File.dirname(__FILE__) + '/land-of-lisp-itinerary/nestable'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/complete'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/day'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/discuss'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/live_code'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/read'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/show'
require File.dirname(__FILE__) + '/land-of-lisp-itinerary/actions/supplement'

def by(date,&block)
  Itinerary.by date , &block
end


module Itinerary

  extend self
    
  def to(type)
    days.map { |day| day.to type }.join("\n")
  end
  
  def by(date,&definition)
    days << Actions::Day.new(date,&definition)
  end
  
  def days
    @days ||= Array.new
  end
  
end

