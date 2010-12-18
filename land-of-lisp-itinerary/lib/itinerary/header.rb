module Itinerary
  class Header
    
    class Description
      Link = Struct.new :url , :text
      attr_reader :text , :links
      def initialize(description,&block)
        @links = []
        @text  = description.split("\n").map(&:strip).join(' ')
        instance_eval &block if block
      end
      def has_links?
        !@links.empty?
      end
      def link(params)
        @links << Link.new( params[:url] , params[:text] )
      end
    end
    
    def initialize(title,&definition)
      @title = title
      instance_eval &definition
    end
    
    def describe(description,&block)
      @descriptions ||= []
      @descriptions << Description.new( description , &block )
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
