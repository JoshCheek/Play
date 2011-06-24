# That could have been solved by a Casio AL-8. Loading question 2...
# 
# The following text is an in-order traversal of a binary tree with
# 1023 nodes. What is the sum of the digits appearing in the leaves?

class BinTree
  protected
    attr_accessor :left, :right, :data
  public
  
  def size
    return 1 if leaf?
    1 + left.size + right.size
  end
  
  def leaf?
    !left # due to my implementation, will always be 0 or 2 edges
  end
  
  def add_children
    if leaf?
      self.left = BinTree.new
      self.right = BinTree.new
    else
      left.add_children
      right.add_children
    end
    size
  end
  
  def show_leaves(str = "")
    if leaf?
      str << "L"    # Leaf
    else
      left.show_leaves str
      str << "N"    # Not leaf
      right.show_leaves str
    end
  end
  
end

b = BinTree.new(true)
b.size          # => 1
b.add_children  # => 3
b.show_leaves   # => "LNL"
b.add_children  # => 7
b.add_children  # => 15
b.show_leaves   # => "LNLNLNLNLNLNLNL"
b.add_children  # => 31
b.show_leaves   # => "LNLNLNLNLNLNLNLNLNLNLNLNLNLNLNL"
b.add_children  # => 63
b.add_children  # => 127
b.add_children  # => 255
b.add_children  # => 511
b.add_children  # => 1023

# Looks like it's every other node, how annoying -.^
# (plus, bad instructions, Binary tree does not mean 0 or 2 edges.
# it took me forever to realize that's what they were looking for)
sum = 0
DATA.read.each_char.with_index do |char, index|
  sum += char.to_i if index.even?
end
sum # => 331



__END__
bDq4i3eFNmjh2oMgjNsIFkRWsonRl=tz9kf8gOpED2gVQrfx49GjR9/QNqTEJkSzM30p4RfneDc7EmdusIYdxxZ8KKdND==YpLlmN/FkErS7uqVHYIyGEBIhIRX+mbg6FjVGqfYjobX3F1lSmPpLXXxhux1lV=EzIgGct9pd=ogzAdJU4/yZOj9=njfvbSo11bcE/yUDHg/J=6DAtmWt+P/VDvE4GyYHlKVGUoksn+Lzm6Y1VVF6qw=onnKZS=CQQUPeMlUGtMobJEeyIyGBMFj5kHml1waI97qgVt/yeKWSXxhJyK+As0M0UR2KL+U7klKMlWlxgbIJ2beN0gaMHbIClKrBuroo+L73CwnbFKRiyKOx8Ke=PPukm1BWYd4Do5nikrT0dgPWlmItCzyZrEiOBgBtEB9FG1qdQJud182qYU4Xwry=bR7R5PH=Npab7JQ7gY=MYHW24iw=m2+XayIachr=QVt4giclLluUEu3Dx/5y7R0GlINqoJc9O6QwEP6a9PRsdt86nZYQUF/b729lzilkM1PB8mDPACTOGobXSJJQshRQCoJoC9TX6ERou/tlMWNQTaaU0YmzIFh8t72lgOeIMu4W2S9V8Y5jO8T47ZPRGxeQDWRQlpx1tc3AC4+x2zJxZaYV6d4+rxxWgYnYC1ZwUvXNF2YLaRw7ldRXCz9/7xZ3mKBj4Ox51L3PqGXAIB+OI4pgkUc1X52tOPdRPgpsfi8wNpynfylwjITvNKq93iViQiyiEVGBgazbHQ7boh5tejStBE1SCk1fMe1=ycNoxJzhAH4x/YlQSUOz/2qkl+JxFBt8sqRYXZjZ6R=Gh87ZwS4B0Meo56/WF+40bf2mTgG05KQ/qR89NMyttHdwwnzvkZuXGrlt/yuStJaXJNkqQ5atDPWqLJy4Q9iylEdI3qmTe6Wmou/umQG7Q+aiOXorJde3Z4CzMyTYnCWvudFDZvgEZsuKRiSOurstnxFRlqVQ0LC7WRuS=qCsDcxoDT5dl9NHusV4kZ/
