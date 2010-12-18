module Itinerary
  class Header
    
    def initialize(title,&definition)
      @title = title
      instance_eval &definition
    end
    
    def describe(description)
      @descriptions ||= []
      @descriptions << description.split("\n").map(&:strip).join(' ')
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
    
    def descriptions
      @descriptions
    end
    
    def to_s
      title.dup
    end
    
    attr_reader :title
       
  end
end
