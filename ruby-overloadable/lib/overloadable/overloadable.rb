module Overloadable
  
  def self.included( klass )
    klass.extend Overloadable::ClassMethods
  end
 
  def method_missing(meth,*args,&block)
    if self.class.overloaded?(meth)
      self.class.invoke_overloaded( self , meth , *args , &block )
    else
      super
    end
  end
 
  def respond_to?(meth)
    self.class.overloaded?(meth) || super
  end
  
end