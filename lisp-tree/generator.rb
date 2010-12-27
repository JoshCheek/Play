class BST
  
  def initialize
    @element = @left = @right = nil
  end
  
  def <<(element)
    if @element && element <= @element
      add_left element
    elsif @element
      add_right element
    else
      @element = element
    end
  end
  
  def add_left(element)
    @left = self.class.new unless @left
    @left << element
  end
  
  def add_right(element)
    @right = self.class.new unless @right
    @right << element
  end
  
  def to_s
    "(#{@left||'nil'}\n#{@element}\n#{@right||'nil'})"
  end
  
end


def elements(low,mid,up,&block)
  return if low >= mid || mid >= up
  block.call mid
  elements(low,(low+mid)/2,mid,&block)
  elements(mid,(mid+up)/2,up,&block)
end

tree = BST.new
elements 0 , 128 , 256 do |element|
  tree << element
end
puts tree
