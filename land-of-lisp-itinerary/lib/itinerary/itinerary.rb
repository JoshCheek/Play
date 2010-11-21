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

