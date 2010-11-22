module Itinerary

  extend self
    
  def to_text
    Formatters::Text.format(@days.dup)
  end
  
  def to_simple_html
    Formatters::SimpleHTML.format(@days.dup)
  end
  
  def to_style4_html(root_dir)
    Formatters::Style4HTML.new(root_dir,@days.dup).format!
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

