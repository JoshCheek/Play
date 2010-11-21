module Itinerary

  extend self
    
  def to_text
    Formatters::Text.format(@days)
  end
  
  def to_html
    Formatters::HTML.format(@days)
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

