module Overloadable  
  class Signature
    
    attr_accessor :types
    
    def initialize types
      self.types = types
    end
    
    def match?( *args , &block )
      if types
        types.size == args.size && types.zip(args).all? { |type,arg| arg.kind_of? type }
      else
        args.empty?
      end
    end
    
  end
end