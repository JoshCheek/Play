require File.dirname(__FILE__) + '/itinerary/itinerary'
require File.dirname(__FILE__) + '/itinerary/nestable'
require File.dirname(__FILE__) + '/itinerary/header'
require File.dirname(__FILE__) + '/itinerary/actions/complete'
require File.dirname(__FILE__) + '/itinerary/actions/day'
require File.dirname(__FILE__) + '/itinerary/actions/discuss'
require File.dirname(__FILE__) + '/itinerary/actions/live_code'
require File.dirname(__FILE__) + '/itinerary/actions/read'
require File.dirname(__FILE__) + '/itinerary/actions/show'
require File.dirname(__FILE__) + '/itinerary/actions/supplement'
require File.dirname(__FILE__) + '/itinerary/formatters/text'
require File.dirname(__FILE__) + '/itinerary/formatters/simple_html'

def by(date,&block)
  Itinerary.by date , &block
end

def header(title,&block)
  Itinerary.header title , &block
end
