$: << File.dirname(__FILE__) + "/lib"

require 'overloadable'

class X
  include Overloadable

  def f
    "f"
  end
 
  sig Integer
 
  def f(i)
    "f#{i}"
  end
 
  sig String, String
 
  def f(s1, s2)
    [s1, s2].join('+')
  end
end

x = X.new

p !!x.respond_to?(:f)
p x.f          
p x.f(1)       
p x.f("A","B") 

# >> true
# >> "f"
# >> "f1"
# >> "A+B"
