module Itinerary
  class LiveCode
    
    include Nestable
    
    def initialize(to_code)
      super
      @to_code = to_code
    end
    
    def to(type)
      case type
      when :text
        "LIVE CODE: #{@to_code}"
      end
    end
    
  end
end