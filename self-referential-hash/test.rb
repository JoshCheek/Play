require File.dirname(__FILE__) + '/rhash'

def assert(desired, *actual)
  actual.each do |val| 
    unless val == desired
      raise "#{desired.inspect} expected, but got #{val.inspect}" 
    end
  end
end

h = RHash.new
assert nil, h[:foo]
h[:foo] = 5
assert 5, h[:foo]

h.refer :bar => :foo
assert 5, h[:foo], h[:bar]
h[:foo] = 6
assert 6, h[:bar]

h # => #<RHash:0x00000100861338 @data={:foo=>6}, @references={:foo=>:foo, :bar=>:foo}>
h.refer :foo => :baz
h # => #<RHash:0x00000100861338 @data={}, @references={:foo=>:baz, :bar=>:foo}>

h[:bar] = 12
h # => #<RHash:0x00000100861338 @data={:baz=>12}, @references={:foo=>:baz, :bar=>:foo, :baz=>:baz}>
assert 12, h[:foo], h[:bar], h[:baz]

h.refer :foo => :foo
h # => #<RHash:0x00000100861338 @data={:baz=>12}, @references={:foo=>:foo, :bar=>:foo, :baz=>:baz}>
assert nil, h[:foo], h[:bar]
assert 12, h[:baz]

h["garlic"] = "vampire"
h.refer :foo => 'garlic', :bar => :baz
h # => #<RHash:0x00000100861338 @data={:baz=>12, "garlic"=>"vampire"}, @references={:foo=>"garlic", :bar=>:baz, :baz=>:baz, "garlic"=>"garlic"}>
assert 'vampire', h[:foo], h['garlic']
assert 12, h[:bar], h[:baz]
