module Overloadable 
  class OverloadedMethod
    
    def methods
      @methods ||= Array.new
    end
    
    def add( signature , method )
      methods << [ signature , method ]
    end
    
    def invoke_for( obj , *args , &block )
      get_method_for(*args,&block).bind(obj).call(*args,&block)
    end
    
    def get_method_for( *args , &block )
      methods.find do |sig,meth|
        sig.match?(*args,&block)
      end.last
    end
    
  end
end
