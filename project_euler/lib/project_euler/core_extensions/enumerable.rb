module Enumerable
  
  def sum
    inject :+
  end
  
  def multiplied
    inject :*
  end
  
end