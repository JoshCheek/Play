class BST
  
  def <<(element)
    empty?              ?  @element = element :
    element < @element  ?  left  << element   :
                           right << element
  end
  
  def empty?
    !@element
  end
  
  def left
    @left ||= BST.new
  end
  
  def right
    @right ||= BST.new
  end
  
  def to_s
    empty? ? "()" : "(#{left} #{@element} #{right})"
  end
  
end


def each_element(bot,crnt,top,&block)
  return if bot >= crnt || crnt >= top
  block.call crnt
  each_element( bot  , (bot+crnt)/2 , crnt , &block )
  each_element( crnt , (crnt+top)/2 , top  , &block )
end

tree = BST.new

each_element( 0 , 128 , 256 ) { |element| tree << element }

tree.to_s.split.each_slice 20 do |*elements|
  puts elements.join(' ')
end
