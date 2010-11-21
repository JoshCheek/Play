module Itinerary
  class Header
    
    def initialize(title,&definition)
      @title = title
      instance_eval &definition
    end
    
    def describe(description)
      @description = description
    end
    
    def define(definition)
      definitions.merge! definition
    end
    
    def definitions
      @definitions ||= Hash.new
    end
    
    def to(type)
      [ "HEADER: ",
        "  DESCRIPTION: #{@description}",
        @definitions.map { |key,value| "  #{key.upcase}: #{value}" }
      ].flatten
    end
    
  end
end
