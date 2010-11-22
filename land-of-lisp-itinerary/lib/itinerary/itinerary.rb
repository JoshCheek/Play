module Itinerary

  extend self
    
  def to_text
    Formatters::Text.format(@days.dup)
  end
  
  def to_simple_html
    Formatters::SimpleHTML.format(@days.dup)
  end
  
  def by(date,&definition)
    days << Actions::Day.new(date,&definition)
  end
  
  def days
    @days ||= Array.new
  end
  
  def header(title,&definition)
    days.unshift Header.new(title,&definition)
  end
  
end

