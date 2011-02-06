module Overloadable
  module ClassMethods
    
    def overloaded_methods
      @overloaded_methods ||= Hash.new { |hash,methname| hash[methname] = OverloadedMethod.new }
    end
    
    def overloaded?(meth)
      overloaded_methods[meth]
    end
    
    def invoke_overloaded( obj , methname , *args , &block )
      @overloaded_methods[methname].invoke_for(obj,*args,&block)
    end
    
    def method_added(methname)
      overloaded_methods[methname].add current_sig , instance_method(methname)
      remove_method methname
    end
    
    def sig(*types)
      @current_sig = Signature.new(types)
    end
    
    def current_sig
      @current_sig ||= Signature.new(nil)
    end
    
  end
end

