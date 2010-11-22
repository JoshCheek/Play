module Itinerary
  class Header
    
    def initialize(title,&definition)
      @title = title
      instance_eval &definition
    end
    
    def describe(description)
      @description = description.split("\n").map(&:strip).join(' ')
    end
    
    def define(definition)
      definitions.merge! definition
    end
    
    def definitions
      @definitions ||= Hash.new
    end
    
    def children
      @definitions
    end
    
    def description
      @description
    end
    
    def to_s
      "HEADER: #{title}"
    end
    
    attr_reader :title
       
  end
end
